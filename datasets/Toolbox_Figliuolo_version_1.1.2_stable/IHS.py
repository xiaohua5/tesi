# importo la divisione altrimenti 6/4 = 1 con / effettua il mod di default
from __future__ import division

import os
import numpy as np
import argparse
import scipy.io as sio
from PNN_testing_model import Network, ConvLayer
from PNN_test import PNN_test
from others import parser_xml, export2


def IHS (I_MS,I_PAN):  
    
    
    imageLR = I_MS  #31/03
    imageHR = I_PAN # aggiunto il 30/03
    
    # Intesity component
    I = imageLR.mean(axis=0)    #nome.shape per la dimensione LA PRIMA DIM SONO I CANALI CON TRANSPOSE  
 
#    m2_imageHR = np.sum(imageHR) / np.size(imageHR)    
    
    
    # PAN component equalization
    media1_imageHR = imageHR.mean(axis=0) #  modificato il 30/03
    media2_imageHR = media1_imageHR.mean()
#    imageHR_temp = (imageHR - media2_imageHR)
    
    dev_I =I.std()
    dev_imageHR = imageHR.std()
    
#    deviazione_I_divide_imageHR = dev_I / dev_imageHR
    
    # media 2 di I
    media2_I = np.sum(I) / np.size(I)    

    
    image_HR_res = (imageHR - media2_imageHR) * (dev_I / dev_imageHR) + media2_I
    
#    a = imageHR - media2_imageHR
#    b = (dev_I / dev_imageHR)
#    image_HR_res = np.dot(a,b)
#    image_HR_res = image_HR_res + media2_I
    
    D = image_HR_res - I
    
#    repeatmatrix = np.tile(D,[D.shape[0],1,1])
#    Settaggio = D[:,:,np.newaxis]   # Python legge diversamente rispetto a Matlab senza transpose
     #repeatmatrix = np.tile(Settaggio,[1,1,imageLR.shape[2]]) #senza transpose
     
     
    # con transpose
    #In Settaggio avremo l'immagine HR di dimensione bande, righe, colonne, dato che la PAN era inizialmente righe x colonne

#    Settaggio = D[np.newaxis,:,:]  
    repeatmatrix = np.tile(D,[imageLR.shape[0],1,1])
    
    I_Fus_IHS = imageLR + repeatmatrix
    
    
    return I_Fus_IHS
    