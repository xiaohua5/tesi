from scipy.signal import correlate
import scipy.io as sio
import numpy as np
from show_image import show_pan_img

FILTER_PATH = "h.mat"
def mtl_glp_hpf(pan_image, ms_image):
    inputImg=sio.loadmat(FILTER_PATH)
    h = np.array(inputImg['h'],dtype='double')
    
    pl = correlate(pan_image, h, mode="same")

    pansharp = np.zeros(ms_image.shape)

    const = ( pan_image - pl ) / np.std(pl)

    for i in range(ms_image.shape[0]):
        pansharp[i] = ms_image[i] + np.std(ms_image[i]) * const
    
    return pansharp