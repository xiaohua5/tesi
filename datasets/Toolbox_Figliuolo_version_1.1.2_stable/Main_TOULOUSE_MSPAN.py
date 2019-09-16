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


# modifica 21/03
# utilizzare RIOWV2
parser.add_argument('-s', '--sensor', type=str, default='TOULOUSE', #rimettere RIOWV2 o TOULOUSEFR  ------------------------
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
from others import parser_xml, export2
from IHS import IHS
from Brovey import Brovey


model=parser_xml('config_testing_'+sensor+'.xml')

# modificato 13_03
execfile('copy_xml_fields_testing.py') #per Python 2.7
#exec(open('copy_xml_fields_testing.py').read # per Python 3.6.4

layer=[]
for i in xrange(0,len(PNN_model['layers']),2):
    layer.append(ConvLayer(PNN_model['layers'][i], PNN_model['layers'][i+1]))
net=Network(layer)


#%% Pansharpening

#load images
inputImg=sio.loadmat(testset_path)

# per il sensore RIOWV2
I_PAN = np.array(inputImg['I_PAN_LR'],dtype='double')       # DATASET TOULOUSE


# provo con le transpose
#I_MS_LR = np.array(inputImg['I_MS_LR'],dtype='double').transpose(2,0,1)   
I_GT = np.array(inputImg['I_MS'],dtype='double').transpose(2,0,1)           # contiene la Ground Truth
#I_GT = np.array(inputImg['I_GT'],dtype='double').transpose(2,0,1)

L = 11
ratio = 4

#%% Load others data from matlab
I_MS_read = sio.loadmat('I_MS_Toulouse.mat')
I_MS = np.array(I_MS_read['I_MS'],dtype='double').transpose(2,0,1)

I_MS_LR_read = sio.loadmat('I_MS_LR_Toulouse.mat')
I_MS_LR = np.array(I_MS_LR_read['I_MS_LR'],dtype='double').transpose(2,0,1)



#%% IHS Algorithm
tic = time.time() 
I_Fus_IHS = I_MS
 
I_Fus_IHS = IHS(I_MS,I_PAN)

elapsed = time.time() - tic
print("Time IHS:",elapsed,'sec')

#%% Brovey Algorithm
tic = time.time() 
I_Fus_Brovey = I_MS

I_Fus_Brovey = Brovey(I_MS,I_PAN)

elapsed = time.time() - tic
print("Time Brovey:",elapsed,'sec')


#%% CNN_method
tic = time.time() 
I_Fus_CNN = np.zeros(I_MS.shape)


I_Fus_CNN = PNN_test(I_MS_LR,I_PAN,inputImg, PNN_model,net,path,mode,epochs)


elapsed = time.time() - tic
print("Time CNN:",elapsed,'sec')



#%% save data choice one for time
export2(I_Fus_CNN,test_dir_out)


#%% Visualization

from image_quantile import image_quantile, image_stretch
import matplotlib.pyplot as plt
plt.close('all')

I_PAN=np.expand_dims(I_PAN,axis=0)
plt.figure()
plt.subplot(231)
th_PAN = image_quantile(I_PAN, np.array([0.01, 0.99]))
PAN = image_stretch(np.squeeze(I_PAN),np.squeeze(th_PAN))
plt.imshow( image_stretch(np.squeeze(I_PAN),np.squeeze(th_PAN)),cmap='gray',clim=[0,1])
plt.title('PAN Image'), plt.axis('off')    


RGB_indexes = np.array([3,2,1])
#RGB_indexes = RGB_indexes - 1
    
plt.subplot(232)
th_MSrgb = image_quantile(np.squeeze(I_MS[RGB_indexes,:,:]), np.array([0.01, 0.99]));   #modifico delle cose 06/04
d=image_stretch(np.squeeze(I_MS_LR[RGB_indexes,:,:]),th_MSrgb)
d[d<0]=0
d[d>1]=1
plt.imshow(d.transpose(1,2,0))
plt.title('MS Image (pan scale)'), plt.axis('off')

plt.subplot(233)
I_GT = np.squeeze(I_GT)
c=image_stretch(np.squeeze(I_GT[RGB_indexes,:,:]),th_MSrgb)
c[c<0]=0
c[c>1]=1
plt.imshow(c.transpose(1,2,0))
plt.title('GT Image'), plt.axis('off')

plt.subplot(234)
I_Fus_IHS = np.squeeze(I_Fus_IHS)
c=image_stretch(np.squeeze(I_Fus_IHS[RGB_indexes,:,:]),th_MSrgb)
c[c<0]=0
c[c>1]=1
plt.imshow(c.transpose(1,2,0))
plt.title('IHS Fusion Algorithm'), plt.axis('off')

plt.subplot(235)
I_Fus_Brovey = np.squeeze(I_Fus_Brovey)
c=image_stretch(np.squeeze(I_Fus_Brovey[RGB_indexes,:,:]),th_MSrgb)
c[c<0]=0
c[c>1]=1
plt.imshow(c.transpose(1,2,0))
plt.title('Brovey Fusion Algorithm'), plt.axis('off')

plt.subplot(236)
I_Fus_CNN = np.squeeze(I_Fus_CNN)
c=image_stretch(np.squeeze(I_Fus_CNN[RGB_indexes,:,:]),th_MSrgb)
c[c<0]=0
c[c>1]=1
plt.imshow(c.transpose(1,2,0))
plt.title('CNN Fusion Algorithm'), plt.axis('off')


plt.show() 
