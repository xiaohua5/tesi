import numpy as np
from image_quantile import image_stretch, image_quantile
import matplotlib.pyplot as plt

def show_pan_img(image):
    pan_ext=np.expand_dims(image,axis=0)
    plt.figure()
    th_pan = image_quantile(pan_ext, np.array([0.01, 0.99]))
    pan_ext = image_stretch(np.squeeze(pan_ext),np.squeeze(th_pan))
    plt.imshow(pan_ext,cmap='gray',clim=[0,1])
    plt.title('PANCHROMATIC'), plt.axis('off')
    plt.show() 

def show_ms_img(image, rgb_idx):
    th_msrgb = image_quantile(np.squeeze(image[rgb_idx,:,:]), np.array([0.01, 0.99]));
    d = image_stretch(np.squeeze(image[rgb_idx,:,:]),th_msrgb)
    d[d<0] = 0
    d[d>1] = 1
    plt.imshow(d.transpose(1,2,0))
    plt.title('MULTISPECTRAL LOW RESOLUTION'), plt.axis('off')
    plt.show() 