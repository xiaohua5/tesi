%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           Erreur Relative Globale Adimensionnelle de Synthèse (ERGAS).
% 
% Interface:
%           ERGAS_index = ERGAS(I1,I2,ratio)
%
% Inputs:
%           I1:             First multispectral image;
%           I2:             Second multispectral image;
%           ratio:          Scale ratio between MS and PAN. Pre-condition: Integer value.
% 
% Outputs:
%           ERGAS_index:    ERGAS index.
% References:
%           [Ranchin00]     T. Ranchin and L. Wald, “Fusion of high spatial and spectral resolution images: the ARSIS concept and its implementation,”
%                           Photogrammetric Engineering and Remote Sensing, vol. 66, no. 1, pp. 49–61, January 2000.
%           [Vivone14]      G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”, 
%                           IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ERGAS_index,ERGAS_map,ERGAS_map_band2] = ERGAS(I1,I2,ratio)

I1 = double(I1);
I2 = double(I2);

Err=I1-I2;
ERGAS_index=0;
for iLR=1:size(Err,3),
    ERGAS_index = ERGAS_index+mean2(Err(:,:,iLR).^2)/(mean2((I1(:,:,iLR))))^2;   
end

ERGAS_index = (100/ratio) * sqrt((1/size(Err,3)) * ERGAS_index);

ERGAS_map_band = zeros(size(I1));
ERGAS_map_band2 = zeros(size(I1));
for idim = 1 : size(I1,3),
    I_GT_band=I1(:,:,idim);
    I_F_band=I2(:,:,idim);
    ERGAS_map_band(:,:,idim) = (I_GT_band-I_F_band).^2/(mean2(I_GT_band))^2;
    ERGAS_map_band2(:,:,idim) = (100/ratio) * sqrt((I_GT_band-I_F_band).^2/(mean2(I_GT_band))^2);
end
ERGAS_map = mean(ERGAS_map_band,3);
ERGAS_map = (100/ratio) * sqrt(mean(ERGAS_map,3));

end