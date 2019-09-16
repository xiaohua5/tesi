%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description:
%           Generate the low resolution PANchromatic (PAN) and MultiSpectral (MS) images according to the Wald's protocol.
%
% Interface:
%           [I_MS_LR, I_PAN_LR] = resize_images(I_MS,I_PAN,ratio,sensor)
%
% Inputs:
%           I_MS:           MS image upsampled at PAN scale;
%           I_PAN:          PAN image;
%           ratio:          Scale ratio between MS and PAN. Pre-condition: Integer value;
%           sensor_MS:      String for type of MS sensor (e.g. 'WV2', 'IKONOS').
%           sensor_PAN:     String for type of MS sensor (e.g. 'WV2', 'IKONOS'). If sensor_PAN = 'ideal' almost-ideal resampling is performed
%           decimate:       1 : Scale reduction; 0 : Resolution reduction;
%
% Outputs:
%           I_MS_LR:        Low Resolution MS image;
%           I_PAN_LR:       Low Resolution PAN image.
%
% References:
%           [Wald97]    L. Wald, T. Ranchin, and M. Mangolini, “Fusion of satellite images of different spatial resolutions: assessing the quality of resulting images,”
%                       Photogrammetric Engineering and Remote Sensing, vol. 63, no. 6, pp. 691–699, June 1997.
%           [Aiazzi06]  B. Aiazzi, L. Alparone, S. Baronti, A. Garzelli, and M. Selva, “MTF-tailored multiscale fusion of high-resolution MS and Pan imagery,”
%                       Photogrammetric Engineering and Remote Sensing, vol. 72, no. 5, pp. 591–596, May 2006.
%           [Vivone14]  G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”,
%                       IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [I_MS_LR, I_PAN_LR] = resize_images(I_MS,I_PAN,ratio,sensor_MS,sensor_PAN,decimate)

I_MS = double(I_MS);
I_PAN = double(I_PAN);
flag_PAN_MTF = 0;
flag_resize_new=2;

if nargin < 6
    decimate = 1;
end

if nargin < 5
    if flag_PAN_MTF == 0
        sensor_PAN = 'ideal';
    else
        sensor_PAN = sensor_MS;
    end
end

% Decimation always performed for sensor_PAN = 'ideal'
% To be removed in a future release
if strcmp(sensor_PAN,'ideal')
    decimate = 1;
end

if strcmp(sensor_MS,'none')
    flag_resize_new = 1; % Bicubic Interpolator
end


if flag_resize_new == 1
    
    %%% Bicubic Interpolator MS
    
    I_MS_LR = imresize(I_MS,1/ratio);
    
    %%% Bicubic Interpolator PAN
    I_PAN_LR = imresize(I_PAN,1/ratio);
    
elseif flag_resize_new == 2
    
    %%% MTF
    I_MS_LP = MTF(I_MS,sensor_MS,[],ratio);
    
    %%% Decimation MS
    if decimate
        I_MS_LR = imresize(I_MS_LP,1/ratio,'nearest');
    else
        I_MS_LR = I_MS_LP;
    end
    
    if strcmp(sensor_PAN,'ideal')
        I_PAN_LR = imresize(I_PAN,1/ratio);
    else
        I_PAN_LP = MTF_PAN(I_PAN,sensor_PAN,ratio);
        %%% Decimation PAN
        if decimate
            I_PAN_LR = imresize(I_PAN_LP,1/ratio,'nearest');
        else
            I_PAN_LR = I_PAN_LP;
        end
    end
end

end