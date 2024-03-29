%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           ATWT_M2 fuses the upsampled MultiSpectral (MS) and PANchromatic (PAN) images by 
%           exploiting the A Trous Wavelet Transform (ATWT) with Model 2 (M2) algorithm.
% 
% Interface:
%           I_Fus_ATWT_M2 = ATWT_M2(I_MS,I_PAN,ratio)
%
% Inputs:
%           I_MS:           MS image upsampled at PAN scale;
%           I_PAN:          PAN image;
%           ratio:          Scale ratio between MS and PAN. Pre-condition: Integer value.
%
% Outputs:
%           I_Fus_ATWT_M2:  ATWT M2 pasharpened image.
% 
% References:
%           [Ranchin00]     T. Ranchin and L. Wald, �Fusion of high spatial and spectral resolution images: the ARSIS concept and its implementation,�
%                           Photogrammetric Engineering and Remote Sensing, vol. 66, no. 1, pp. 49�61, January 2000.
%           [Vivone14]      G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, �A Critical Comparison Among Pansharpening Algorithms�, 
%                           IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function I_Fus_ATWT_M2 = ATWT_M2(I_MS,I_PAN,ratio)

[Height,Width,Bands]=size(I_MS);
I_Fus_ATWT_M2=zeros(Height,Width,Bands,'double');

I_PAN = repmat(I_PAN,[1 1 size(I_MS,3)]);

Levels = ceil(log2(ratio));

h=[1 4 6 4 1 ]/16;
g=[0 0 1 0 0 ]-h;
htilde=[ 1 4 6 4 1]/16;
gtilde=[ 0 0 1 0 0 ]+htilde;
h=sqrt(2)*h;
g=sqrt(2)*g;
htilde=sqrt(2)*htilde;
gtilde=sqrt(2)*gtilde;
WF={h,g,htilde,gtilde};

for i=1:Bands
        
    %%% Estimation Parameter Model
    WTP = ndwt2_working(I_PAN(:,:,i),Levels+1,WF);
    WTXS = ndwt2_working(I_MS(:,:,i),Levels+1,WF);
     
    a = zeros(1,3);
    b = a;
    for jj = 2 : 4
        a(jj-1) = std2(WTXS.dec{jj})./std2(WTP.dec{jj});
        b(jj-1) = mean2(WTXS.dec{jj}) - a(jj-1) .* mean2(WTP.dec{jj});
    end
   
    %%% Injection
    WTP = ndwt2_working(I_PAN(:,:,i),Levels,WF);
    WTXS = ndwt2_working(I_MS(:,:,i),Levels,WF);

    for jj = 2 : numel(WTP.dec)
        WTXS.dec{jj} = a(rem((jj-2),3) + 1) .* WTP.dec{jj} + b(rem((jj-2),3) + 1);
    end
    
    %%% Reconstruction
    I_Fus_ATWT_M2(:,:,i) = indwt2_working(WTXS,'c');
    
end

end