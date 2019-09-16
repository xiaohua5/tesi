# -*- coding: utf-8 -*-
"""
Copyright (c) 2018 Image Processing Research Group of University Federico II of Naples ('GRIP-UNINA').
All rights reserved. This work should only be used for nonprofit purposes.
"""

import os
import numpy as np
import argparse
import time

parser = argparse.ArgumentParser( 
        description = 'Pansharpening')
                        
parser.add_argument('-g', '--gpu', action='store_true',default=False,
                        help='the identifier of the used GPU.')

parser.add_argument('-s', '--sensor', type=str, default='SAOPAULO_Ratio3_DatasetModify', #rimettere RIOWV2 ---------
                        help='the identifer of the used sensor.')

config, _ = parser.parse_known_args()
sensor = config.sensor                        
if (config.gpu):
	os.environ["THEANO_FLAGS"]='device=gpu0,floatX=float32,init_gpu_device=gpu0'
else:
	os.environ["THEANO_FLAGS"] = "floatX=float32"

import scipy.io as sio
from PNN_testing_model import Network, ConvLayer
from PNN_test import PNN_test
from PNN_test_HSMS_ratio_3 import PNN_test_HSMS_ratio_3
from PNN_test_divisible_9 import PNN_test_divisible_9
from PNN_test_HS_PAN_ratio_3 import PNN_test_HS_PAN_ratio_3
from others import parser_xml, export2
from IHS import IHS
from Brovey import Brovey


model=parser_xml('config_testing_'+sensor+'.xml')

execfile('copy_xml_fields_testing.py') #per Python 2.7

layer=[]
for i in xrange(0,len(PNN_model['layers']),2):
    layer.append(ConvLayer(PNN_model['layers'][i], PNN_model['layers'][i+1]))
net=Network(layer)


#%% Pansharpening

#load images
inputImg=sio.loadmat(testset_path)

#I_PAN = np.array(inputImg['I_PAN'],dtype='double')       # modifica 21/03
I_PAN0_LR = np.array(inputImg['I_PAN0_LR'],dtype='double')
I_MS_LR = np.array(inputImg['I_MS_LR'],dtype='double').transpose(2,0,1)  #tolgo un attimo transpose 
I_MS = np.array(inputImg['I_MS'],dtype='double').transpose(2,0,1)
I_GT = np.array(inputImg['I_GT'],dtype='double').transpose(2,0,1)
MS_Bands = np.array(inputImg['MS_Bands'],dtype='double')
PAN_Bands = np.array(inputImg['PAN_Bands'],dtype='double')

L = 15
ratio = 3

# prendo le prime 48 bande dell'iperspettrale partendo da zero
I_PAN0_LR = I_PAN0_LR[0:189,:]
#I_PAN = I_PAN[0:189,:,:]
I_MS_LR = I_MS_LR[0:48,0:63,:]
I_MS = I_MS[0:48,0:189,:]
I_GT = I_GT[0:48,0:189,:]
MS_Bands = MS_Bands[:,0:48]
ratio = 3

I_PAN = I_PAN0_LR



#%% Load others data NO GROUPING sia per IHS che per Brovey
#Groups_matlab = sio.loadmat('Groups.mat')
#Groups = np.array(Groups_matlab['Groups'])
#HS_BS_matlab = sio.loadmat('HS_BS.mat')
#HS_BS = np.array(HS_BS_matlab['HS_BS'])
#HS_BS = HS_BS.shape[1]

#%% Load Groups (senza ass_method essendo una fusione HS/PAN)
#Groups_matlab = sio.loadmat('Groups_SaoPaulo_Hyp_Ali_Single_HS_PAN_ratio_3.mat')
#Groups = np.array(Groups_matlab['Groups'])



#%% Fusion data based on CNN
# Load Variables MANUAL8
Groups_Masi_matlab = sio.loadmat('Groups_MANUAL4_SaoPaulo_Hyp_Ali_ratio_3_Fusion_HS_PAN.mat')
Groups_Masi = np.array(Groups_Masi_matlab['Groups'])
Ass_vector_matlab = sio.loadmat('ass_vector_HS_PAN_MANUAL_4_Single_SaoPauloModify_ratio_3_Fusion_HS_PAN.mat')
ass_vector = np.array(Ass_vector_matlab['ass_vect'])



#%% IHS Algorithm
I_Fus_IHS = I_MS

tic = time.time()

for ig in range(0,np.size(Groups_Masi)):  # start from zero

    HS_BS_Masi_Manual8 = Groups_Masi[0,ig]-1    # less one
    I_MS_g = I_MS[HS_BS_Masi_Manual8[0,:],:,:]    
    I_MS_LR_g = I_MS_LR[HS_BS_Masi_Manual8[0,:],:,:]    
    squeezeIndex = ass_vector[0][ig]-1
   
#    I_PAN_g = np.squeeze(I_PAN[ :, :,squeezeIndex])
    
    I_PAN_g = np.squeeze(I_PAN[ :, :])
    
    I_GT_g = I_GT[HS_BS_Masi_Manual8[0,:],:,:]    
    
    I_Fus_IHS[HS_BS_Masi_Manual8[0,:],:,:]= IHS(I_MS_g,I_PAN_g)  

elapsed = time.time() - tic
print("Time IHS:",elapsed,'sec')

#%% Brovey algorithms
I_Fus_Brovey = I_MS

tic = time.time()

for ig in range(0,np.size(Groups_Masi)):  # start from zero

    HS_BS_Masi_Manual8 = Groups_Masi[0,ig]-1    # less one
    I_MS_g = I_MS[HS_BS_Masi_Manual8[0,:],:,:]    
    I_MS_LR_g = I_MS_LR[HS_BS_Masi_Manual8[0,:],:,:]    
    squeezeIndex = ass_vector[0][ig]-1
    
    
#    I_PAN_g = np.squeeze(I_PAN[ :, :,squeezeIndex])
    
    I_PAN_g = np.squeeze(I_PAN[ :, :])
    
    I_GT_g = I_GT[HS_BS_Masi_Manual8[0,:],:,:]    
    
    I_Fus_Brovey[HS_BS_Masi_Manual8[0,:],:,:]= Brovey(I_MS_g,I_PAN_g)  

elapsed = time.time() - tic
print("Time Brovey:",elapsed,'sec')   
    

#%% CNN_method
I_Fus_CNN = np.zeros(I_MS.shape)
# used PAN transpose
#I_PAN_modify = I_PAN.transpose(2,0,1)


I_PAN_modify = I_PAN

tic = time.time()

for ig in range(0,np.size(Groups_Masi)):  # start from zero

    HS_BS_Masi_Manual8 = Groups_Masi[0,ig]-1    # less one
    I_MS_g = I_MS[HS_BS_Masi_Manual8[0,:],:,:]    
    I_MS_LR_g = I_MS_LR[HS_BS_Masi_Manual8[0,:],:,:]    
    squeezeIndex = ass_vector[0][ig]-1
    
#    I_PAN_g_modify = np.squeeze(I_PAN_modify[squeezeIndex, :, :])
    
    I_PAN_g_modify = np.squeeze(I_PAN_modify[ :, :])
    
    I_GT_g = I_GT[HS_BS_Masi_Manual8[0,:],:,:]

    I_Fus_CNN[ HS_BS_Masi_Manual8[0,:], : , :] = PNN_test_divisible_9(I_MS_LR_g,I_PAN_g_modify,inputImg,PNN_model,net,path,mode,epochs) 

elapsed = time.time() - tic
print("Time CNN:",elapsed,'sec')  

#%% save data choice one for time
export2(I_Fus_CNN,test_dir_out)


#%% Visualization

from image_quantile import image_quantile, image_stretch
import matplotlib.pyplot as plt
plt.close('all')

RGB_indexes_MS = np.array([2,1,0])

I_PAN0_LR=np.expand_dims(I_PAN0_LR,axis=0)
plt.figure()
plt.subplot(231)
th_PAN = image_quantile(I_PAN0_LR, np.array([0.01, 0.99]))
PAN = image_stretch(np.squeeze(I_PAN0_LR),np.squeeze(th_PAN))
plt.imshow( image_stretch(np.squeeze(I_PAN0_LR),np.squeeze(th_PAN)),cmap='gray',clim=[0,1])
plt.title('PAN Image'), plt.axis('off')     

#RGB_indexes = RGB_indexes - 1
RGB_indexes_HS = np.array([20,14,7]) # matlab 8,15,21 quindi transpongo ed abbasso di una unità
    
plt.subplot(232)
th_MSrgb = image_quantile(np.squeeze(I_MS_LR[RGB_indexes_HS,:,:]), np.array([0.01, 0.99]));
d=image_stretch(np.squeeze(I_MS_LR[RGB_indexes_HS,:,:]),th_MSrgb)
d[d<0]=0
d[d>1]=1
plt.imshow(d.transpose(1,2,0))
plt.title('HS Image (MS scale)'), plt.axis('off')

plt.subplot(233)
I_GT = np.squeeze(I_GT)
c=image_stretch(np.squeeze(I_GT[RGB_indexes_HS,:,:]),th_MSrgb)
c[c<0]=0
c[c>1]=1
plt.imshow(c.transpose(1,2,0))
plt.title('GT Image'), plt.axis('off')

plt.subplot(234)
I_Fus_IHS = np.squeeze(I_Fus_IHS)
c=image_stretch(np.squeeze(I_Fus_IHS[RGB_indexes_HS,:,:]),th_MSrgb)
c[c<0]=0
c[c>1]=1
plt.imshow(c.transpose(1,2,0))
plt.title('IHS Fusion Algorithm'), plt.axis('off')

plt.subplot(235)
I_Fus_Brovey = np.squeeze(I_Fus_Brovey)
c=image_stretch(np.squeeze(I_Fus_Brovey[RGB_indexes_HS,:,:]),th_MSrgb)
c[c<0]=0
c[c>1]=1
plt.imshow(c.transpose(1,2,0))
plt.title('Brovey Fusion Algorithm'), plt.axis('off')

plt.subplot(236)
I_Fus_CNN = np.squeeze(I_Fus_CNN)
c=image_stretch(np.squeeze(I_Fus_CNN[RGB_indexes_HS,:,:]),th_MSrgb)
c[c<0]=0
c[c>1]=1
plt.imshow(c.transpose(1,2,0))
plt.title('CNN Fusion Algorithm'), plt.axis('off')

plt.show() 
