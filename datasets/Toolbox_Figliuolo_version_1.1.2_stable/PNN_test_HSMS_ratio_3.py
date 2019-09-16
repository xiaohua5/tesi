# -*- coding: utf-8 -*-
"""
Created on Fri May 04 11:36:33 2018

@author: Michele
"""

# -*- coding: utf-8 -*-
"""
Created on Fri Apr 13 14:43:57 2018

@author: Michele
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Mar 15 14:58:50 2018

@author: Michele
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Mar 15 14:40:08 2018

@author: Michele
"""

# -*- coding: utf-8 -*-
"""
Copyright (c) 2018 Image Processing Research Group of University Federico II of Naples ('GRIP-UNINA').
All rights reserved. This work should only be used for nonprofit purposes.
"""
    
import numpy as np
import sys
from others import interp23
from fine_tuning import fine_tuning
from fine_tuning_ratio_3 import fine_tuning_ratio_3
import scipy.io as sio
from downgrade_images import downgrade_images



def PNN_test_HSMS_ratio_3 (I_MS_LR,I_PAN,inputImg, param,net,path,mode,epochs):    #iniz è uguale a 0 QUI ERA IL PROBLEMA FACEVA UN OVERRIDE
    
    test_dir_out=path['test_dir_out']
    FTnetwork_dir_out=path['ftnetwork_dir_out']
	
    
#    import pdb; pdb.set_trace()	
    
    # san paolo hs/ms
    param['L']=15                       # modifica del 23/04
#    param['ratio']=3  
    param['ratio']=3 # modificato il 04/04    
    param['lr'] = 0.0001   # prec 10e-4                                #modificato il 25/04
    param['patchSize'] = 33  #preced = 33
    
#    param['padSize'] = 8
    
    
    # per il debug
#    import pdb; pdb.set_trace()
    
    
    if 'inputType' not in param.keys():
        param['inputType']='MS_PAN'
    

    #fine tuning
    if epochs != 0:
        
#        pdb.set_trace()	
        
        fine_tuning(I_MS_LR,I_PAN,param,epochs,FTnetwork_dir_out)        
        ft_model_path = FTnetwork_dir_out+'/PNN_model.mat'
        
        FT_model = sio.loadmat(ft_model_path,squeeze_me=True)   #provo25/04
        
        from PNN_testing_model import Network, ConvLayer
        
        layer=[]
        for j in range(0,len(FT_model['layers']),2):
            layer.append(ConvLayer(FT_model['layers'][j], FT_model['layers'][j+1]))
        net=Network(layer)
        
#        layer=[]
#        for j in range(0,len(param['layers']),2):
#            layer.append(ConvLayer(param['layers'][j], param['layers'][j+1]))
#        net=Network(layer)
        
        
        

#        pdb.set_trace()        
    
    if mode != 'full':
        I_MS_LR,I_PAN=downgrade_images(I_MS_LR,I_PAN,param['ratio'],param['sensor'])    
    
    I_PAN = np.expand_dims(I_PAN,axis=0)    
  
    
    
    NDxI_LR = [];    
    mav_value=2**(np.float32(param['L']))
    
    # compute radiometric indexes
    if param['inputType']=='MS_PAN_NDxI':
        if I_MS_LR.shape[0] == 8:
            NDxI_LR = np.stack((
                  (I_MS_LR[4,:,:]-I_MS_LR[7,:,:])/(I_MS_LR[4,:,:]+I_MS_LR[7,:,:]),
                  (I_MS_LR[0,:,:]-I_MS_LR[7,:,:])/(I_MS_LR[0,:,:]+I_MS_LR[7,:,:]),
                  (I_MS_LR[2,:,:]-I_MS_LR[3,:,:])/(I_MS_LR[2,:,:]+I_MS_LR[3,:,:]),
                  (I_MS_LR[5,:,:]-I_MS_LR[0,:,:])/(I_MS_LR[5,:,:]+I_MS_LR[0,:,:])),axis=0 )
        else:
            NDxI_LR = np.stack((
                                (I_MS_LR[3,:,:]-I_MS_LR[2,:,:])/(I_MS_LR[3,:,:]+I_MS_LR[2,:,:]),
                                (I_MS_LR[1,:,:]-I_MS_LR[3,:,:])/(I_MS_LR[1,:,:]+I_MS_LR[3,:,:])), axis=0 )
           
#    %input preparation      
    if param['typeInterp']=='interp23tap':
        
#        import pdb; pdb.set_trace()
        
        I_MS = interp23(I_MS_LR, param['ratio'])
#        if len(NDxI_LR)!=0:
#            NDxI = interp23(NDxI_LR, param['ratio'])
#    else:
#        sys.exit('interpolation not supported')
    
    
    if param['inputType']=='MS':
        I_in = I_MS.astype('single')/mav_value
    elif param['inputType']=='MS_PAN':     
#        import pdb; pdb.set_trace()
        
        I_in = np.vstack((I_MS, I_PAN)).astype('single')/mav_value        
    elif param['inputType']=='MS_PAN_NDxI':
        I_in = np.vstack((I_MS, I_PAN)).astype('single')/mav_value
        I_in = np.vstack((I_in, NDxI)).astype('single')
    else:
        sys.exit('Configuration not supported')
    print (I_in.shape) 


#    import pdb; pdb.set_trace()

    I_in_residual=np.expand_dims(I_in,axis=0)
    I_in_residual=I_in_residual[:,:I_MS.shape[0],:,:]
    
    
    import pdb; pdb.set_trace()
    
    I_in = np.pad(I_in, ((0,0),(param['padSize']/2,param['padSize']/2),(param['padSize']/2,param['padSize']/2)),mode='edge')
    I_in = np.expand_dims(I_in,axis=0)
    
    #Pansharpening MODIFICA 17/04
#    param['residual'] = 'false'    
    
#    I_MS_residual = np.expand_dims(I_MS,axis=0) 
    
    if param['residual'] == 'true' or param['residual'] == 1:
        I_out=net.build(I_in)+I_in_residual[:,:I_MS.shape[0],:,:]
#        I_out = net.build(I_in) + I_MS_residual
    else:
        I_out=net.build(I_in)
        
    I_out = I_out * mav_value
    
    return np.squeeze(I_out)
    
    
