%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           GS2_GLP fuses the upsampled MultiSpectral (MS) and PANchromatic (PAN) images by 
%           exploiting the Gram-Schmidt (GS) mode 2 algorithm with Generalized Laplacian Pyramid (GLP) decomposition.
% 
% Interface:
%           I_Fus_GS2_GLP = GS2_GLP(I_MS,I_PAN,ratio,sensor,tag)
%
% Inputs:
%           I_MS:           MS image upsampled at PAN scale;
%           I_PAN:          PAN image;
%           ratio:          Scale ratio between MS and PAN. Pre-condition: Integer value;
%           sensor:         String for type of sensor (e.g. 'WV2','IKONOS');
%           tag:            Image tag. Often equal to the field sensor. It makes sense when sensor is 'none'. It indicates the band number
%                           in the latter case.
%
% Outputs:
%           I_Fus_GS2_GLP:  GS2_GLP pasharpened image.
% 
% References:
%           [Aiazzi06]      B. Aiazzi, L. Alparone, S. Baronti, A. Garzelli, and M. Selva, “MTF-tailored multiscale fusion of high-resolution MS and Pan imagery,”
%                           Photogrammetric Engineering and Remote Sensing, vol. 72, no. 5, pp. 591–596, May 2006.
%           [Alparone07]    L. Alparone, L. Wald, J. Chanussot, C. Thomas, P. Gamba, and L. M. Bruce, “Comparison of pansharpening algorithms: Outcome
%                           of the 2006 GRS-S Data Fusion Contest,” IEEE Transactions on Geoscience and Remote Sensing, vol. 45, no. 10, pp. 3012–3021,
%                           October 2007.
%           [Vivone14]      G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”, 
%                           IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function I_Fus_GS2_GLP = GS2_GLP(I_MS,I_PAN,ratio,sensor,tag)

addpath('..\PS_Tools')

imageLR = double(I_MS);
imageHR = double(I_PAN);

imageHR = repmat(imageHR,[1 1 size(imageLR,3)]);

PAN_LP = MTF(imageHR,sensor,tag,ratio);
PAN_LP = double(PAN_LP);
t = imresize(PAN_LP,1/ratio,'nearest');
% PAN_LP  = interp23tap(t,ratio);
PAN_LP = interp23tapGeneral(t,ratio);


%%% Coefficients
g = ones(1,size(I_MS,3));
for ii = 1 : size(I_MS,3)
    h = imageLR(:,:,ii);
    h2 = PAN_LP(:,:,ii);
    c = cov(h2(:),h(:));
    g(ii) = c(1,2)/var(h2(:));
end

%%% Detail Extraction
delta = imageHR - PAN_LP;

I_Fus_GS2_GLP = zeros(size(imageLR));

for ii = 1 : size(imageLR,3)
    I_Fus_GS2_GLP(:,:,ii) = imageLR(:,:,ii) + delta(:,:,ii) .* g(ii);
end

end