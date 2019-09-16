%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           MTF_GLP_ECB fuses the upsampled MultiSpectral (MS) and PANchromatic (PAN) images by 
%           exploiting the Modulation Transfer Function - Generalized Laplacian Pyramid (MTF-GLP) with Context Based Decision (CBD) algorithm. 
% 
% Interface:
%           I_MTF_GLP_CBD = MTF_GLP_CBD(I_MS,I_PAN,ratio,blockSize,threshold,sensor,tag)
%
% Inputs:
%           I_MS:               MS image upsampled at PAN scale;
%           I_PAN:              PAN image;
%           ratio:              Scale ratio between MS and PAN. Pre-condition: Integer value;
%           blockSize:          Block size (e.g. 9 x 9);
%           threshold:          Threshold (e.g. -Inf);
%           sensor:             String for type of sensor (e.g. 'WV2','IKONOS');
%           tag:                Image tag. Often equal to the field sensor. It makes sense when sensor is 'none'. It indicates the band number
%                               in the latter case.
%
% Outputs:
%           I_Fus_MTF_GLP_CBD:  MTF_GLP_CBD pansharpened image.
% 
% References:
%           [Aiazzi02]          B. Aiazzi, L. Alparone, S. Baronti, and A. Garzelli, “Context-driven fusion of high spatial and spectral resolution images based on
%                               oversampled multiresolution analysis,” IEEE Transactions on Geoscience and Remote Sensing, vol. 40, no. 10, pp. 2300–2312, October
%                               2002.
%           [Aiazzi06]          B. Aiazzi, L. Alparone, S. Baronti, A. Garzelli, and M. Selva, “MTF-tailored multiscale fusion of high-resolution MS and Pan imagery,”
%                               Photogrammetric Engineering and Remote Sensing, vol. 72, no. 5, pp. 591–596, May 2006.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function I_MTF_GLP_CBD = MTF_GLP_CBD(I_MS,I_PAN,ratio,blockSize,threshold,sensor,tag)

addpath('..\PS_Tools')
%%% Check BlockSize
if rem(blockSize,2) == 0
    %%% Approximate to odd BlockSize
    blockSize = blockSize + 1; 
end

imageHR = double(I_PAN);
I_MS = double(I_MS);

imageHR = repmat(imageHR,[1 1 size(I_MS,3)]);

PAN_LP = MTF(imageHR,sensor,tag,ratio);
PAN_LP = double(PAN_LP);
t = imresize(PAN_LP,1/ratio,'nearest');
% imageHRLP = interp23tap(t,ratio);
imageHRLP = interp23tapGeneral(t,ratio);

DetailsHRPan = imageHR - imageHRLP;

I_MTF_GLP_CBD = zeros(size(I_MS));
for b = 1 : size(I_MS,3)
     for y=1 : size(I_MS,1)
        for x=1 : size(I_MS,2)
            
            startx = x - floor(blockSize/2);
            starty = y - floor(blockSize/2);
            endy = y + floor(blockSize/2);
            endx = x + floor(blockSize/2);
            
            if endy > size(I_MS,1)
                endy = size(I_MS,1);
            end
            
            if endx > size(I_MS,2)
                endx = size(I_MS,2);
            end
            
            if starty < 1
                starty = 1;
            end
            
            if startx < 1
                startx = 1;
            end
            
            BlockMS = I_MS((starty:endy),(startx:endx),b);
            BlockPan = imageHRLP((starty:endy),(startx:endx),b);
            StdMS=std2(BlockMS);
            StdPan=std2(BlockPan);
            Correlation=corr2(BlockMS,BlockPan);
            if(Correlation>threshold)
                LG=StdMS/StdPan;
            else
                LG=0;
            end

            BlockDetails = DetailsHRPan(y,x,b);
            Details2Add=LG*BlockDetails;
            FusedBlock = I_MS(y,x,b) + Details2Add;
            I_MTF_GLP_CBD(y,x,b)=FusedBlock;
        end
    end
end

end