import scipy.io as sio
import os
import numpy as np
import sys
from mtl_glp_hpf import mtl_glp_hpf
from show_image import show_ms_img, show_pan_img

TEST_PATH = "./Toulouse_FR.mat"

def extract_images(path_mat):
    inputImg=sio.loadmat(path_mat)


    i_ms_lr = np.array(inputImg['I_MS'],dtype='double').transpose(2,0,1)
    i_pan = np.array(inputImg['I_PAN'],dtype='double')

    if 'RGB_indexes' in inputImg:
        rgb_idx = np.array(inputImg['RGB_indexes'])
        rgb_idx = rgb_idx - 1
    else:
        rgb_idx = [2, 1, 0]

    return i_pan, i_ms_lr, rgb_idx

if __name__ == '__main__':
    if len(sys.argv) > 1:
        image_mat_path = sys.argv[1]
    else:
        image_mat_path = TEST_PATH

    i_pan, i_ms_lr, rgb_idx = extract_images(image_mat_path)
    show_pan_img(i_pan)
    show_ms_img(i_ms_lr, rgb_idx)
    pansharp = mtl_glp_hpf(i_pan, i_ms_lr)
    show_ms_img(pansharp, rgb_idx)
    
