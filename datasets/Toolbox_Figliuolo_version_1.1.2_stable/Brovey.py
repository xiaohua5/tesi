# -*- coding: utf-8 -*-
"""
Created on Sat Mar 24 16:48:46 2018

@author: Michele
"""

# importo la divisione altrimenti 6/4 = 1 con / effettua il mod di default
from __future__ import division

import os
import numpy as np
import argparse
import scipy.io as sio
from PNN_testing_model import Network, ConvLayer
from PNN_test import PNN_test
from others import parser_xml, export2

def Brovey (I_MS,I_PAN):      
    
    imageLR = I_MS
    imageHR = I_PAN
    
    # Intesity component
    I = imageLR.mean(axis=0)    #nome.shape per la dimensione LA PRIMA DIM SONO I CANALI CON TRANSPOSE 
 
#    m2_imageHR = np.sum(imageHR) / np.size(imageHR)   
    
    # PAN component equalization
    media1_imageHR = imageHR.mean(axis=1) # medio lungo le bande, ma essendo PAN ha una sola banda ----> avremo problema HS/MS
    media2_imageHR = media1_imageHR.mean()
#    imageHR_temp = (imageHR - media2_imageHR)
    
    dev_I =I.std()
    dev_imageHR = imageHR.std()
    
#    deviazione_I_divide_imageHR = dev_I / dev_imageHR
    media2_I = np.sum(I) / np.size(I) 
    
    image_HR_res = (imageHR - media2_imageHR) * (dev_I / dev_imageHR) + media2_I
    
     #    repeatmatrix = np.tile(D,[D.shape[0],1,1])
#    Settaggio = D[:,:,np.newaxis]   # Python legge diversamente rispetto a Matlab senza transpose
     #repeatmatrix = np.tile(Settaggio,[1,1,imageLR.shape[2]]) #senza transpose   
     
     
    # con transpose   
    
    #In Settaggio avremo l'immagine HR di dimensione bande, righe, colonne, dato che la PAN era inizialmente righe x colonne
    Settaggio = image_HR_res[np.newaxis,:,:]
    
    # utilizzo di eps
    temp = I + np.spacing(1)
    temp2 = Settaggio / temp
    
    repeatmatrix = np.tile(temp2,[imageLR.shape[0],1,1])
    
    I_Fus_Brovey = imageLR * repeatmatrix
    
    
    return I_Fus_Brovey
    