# -*- coding: utf-8 -*-
"""
Copyright (c) 2018 Image Processing Research Group of University Federico II of Naples ('GRIP-UNINA').
All rights reserved. This work should only be used for nonprofit purposes.
"""
from inputprep import input_preparation
import theano
from downgrade_images import downgrade_images
from downgrade_images_ratio_3 import downgrade_images_ratio_3
import numpy as np
from PNN_finetuning_model import ConvLayer, Network
import os
import pdb;

def fine_tuning_ratio_3(I_MS,I_PAN,model,epochs,ft_dir_out):
    """
    single image fine tuning
    model:       dictionary with all necessary parameters
    epochs:      #epochs of fine tuning
    ft_dir_out:  directory of output for fine tuned network
    """
    
    
#    import pdb; pdb.set_trace()
    
    # load parameters
    residual=model['residual']                          # commento 17/04   ---------------------------------
    
    pretrained_lr=model['lr']
    cost=model['cost']
    regol=model['regol']
    patch_size=model['patch_size']
    net_scope=model['net_scope']
    ratio=model['ratio']
    sensor=model['sensor']


    ratio = 4
    cost='L2'       
    
    
#    pdb.set_trace()
    
    
    # net building    
    layer=[]
    for i in range(0,len(model['layers']),2):
        layer.append(ConvLayer(model['layers'][i], model['layers'][i+1]))
    net=Network(layer)
    
    
    if not os.path.exists(ft_dir_out):
        os.makedirs(ft_dir_out)
        
        
#    import pdb; pdb.set_trace()
               
    I_MS =np.expand_dims(I_MS,axis=0)
    I_PAN =np.expand_dims(I_PAN,axis=0)
    
    
#    import pdb; pdb.set_trace()
    
    # scope-adaptative learning rate
    img_dim=I_MS.shape[2]
    lr=pretrained_lr*((patch_size-net_scope+1)**2)/((img_dim-net_scope+1)**2)     #commento questa riga 25/04
#    lr = pretrained_lr

#    ratio = 3
    
#    import pdb; pdb.set_trace()
    
    # downgrade images 
    I_MS_LR,I_PAN_LR=downgrade_images_ratio_3(np.squeeze(I_MS),np.squeeze(I_PAN),ratio,sensor)
    
    
    I_PAN_LR=np.expand_dims(I_PAN_LR,axis=0)
    I_MS=I_MS/(2**np.float32(model['L']))
    
    
    # c'è interp23 in input_preparation    
#    I_input=inputprep_ratio_3(I_MS,I_MS_LR,I_PAN_LR,model)
    
    I_input=inputprep(I_MS,I_MS_LR,I_PAN_LR,model)
    
    I_input =np.expand_dims(I_input,axis=0)
    
    I_in=theano.shared(np.asarray((I_input),dtype=theano.config.floatX))
    I_ref=theano.shared(np.asarray((I_MS),dtype=theano.config.floatX))
    
    

#    residual = 'false'                                         # modifica 17/04

    
    if residual == 'true' or residual == 1:
        I_ref=I_ref-I_in[:,:-1,:,:]
    else:
        I_ref= I_ref;
    
    
    #training
    loss=np.zeros((2,1))
    net.SGD(I_in,I_ref,epochs, lr,residual,model,cost,regol,ft_dir_out,loss)
    
 
