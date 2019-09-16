# -*- coding: utf-8 -*-
"""
Created on Sat Mar 24 17:49:25 2018

@author: Michele
"""
from __future__ import division
import os
import numpy as np
import argparse


import scipy.io as sio
from PNN_testing_model import Network, ConvLayer
from PNN_test import PNN_test
from others import parser_xml, export2

def PrinCompAnal(I_MS,I_PAN):

imageLR = I_MS
imageHR = I_PAN

[d,n,m] =imageLR.shape

imageLR = np.reshape(imageLR, n*m, d )
imageLR = reshape(imageLR, [n*m,d]);

% PCA transform on MS bands
[W,PCAData] = pca(imageLR);
F = reshape(PCAData, [n,m,d]); 

% Equalization
I = F(:,:,1);
imageHR = (imageHR - mean(imageHR(:)))*std2(I)/std(imageHR(:)) + mean2(I);

% Replace 1st band with PAN
F(:,:,1) = imageHR;

% Inverse PCA
I_Fus_PCA = reshape(F,[n*m,d]) * W';
I_Fus_PCA = reshape(I_Fus_PCA, [n,m,d]);

% Final Linear Equalization
for ii = 1 : size(I_MS,3)
    h = I_Fus_PCA(:,:,ii);
    I_Fus_PCA(:,:,ii) = h - mean2(h) + mean2(squeeze(double(I_MS(:,:,ii))));
end

end