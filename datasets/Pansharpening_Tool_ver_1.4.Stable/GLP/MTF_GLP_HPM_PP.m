%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           MTF_GLP_HPM_PP fuses the upsampled MultiSpectral (MS) and PANchromatic (PAN) images by 
%           exploiting the Lee et al. algorithm based on Modulation Transfer Function -
%           Generalized Laplacian Pyramid (MTF-GLP), High Pass Modulation (HPM), and Post-Processing (PP). 
% 
% Interface:
%           I_Fus_MTF_GLP_HPM_PP = MTF_GLP_HPM_PP(I_PAN,I_MS,sensor,tag,ratio)
%
% Inputs:
%           I_PAN:                  PAN image;
%           I_MS:                   MS image upsampled at PAN scale;
%           sensor:                 String for type of sensor (e.g. 'WV2','IKONOS');
%           tag:                    Image tag. Often equal to the field sensor. It makes sense when sensor is 'none'. It indicates the band number
%                                   in the latter case;
%           ratio:                  Scale ratio between MS and PAN. Pre-condition: Integer value.
%
% Outputs:
%           I_Fus_MTF_GLP_HPM_PP:   MTF_GLP_HPM_PP pansharpened image.
% 
% References:
%           [Lee10]                 J. Lee and C. Lee, “Fast and efficient panchromatic sharpening,” IEEE Transactions on Geoscience and Remote Sensing, vol. 48, no. 1,
%                                   pp. 155–163, January 2010.
%           [Vivone14]              G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”, 
%                                   IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function I_Fus_MTF_GLP_HPM_PP = MTF_GLP_HPM_PP(I_PAN,I_MS,sensor,tag,ratio)

imageHR = double(I_PAN);
I_MS = double(I_MS);

imageHR = repmat(imageHR,[1 1 size(I_MS,3)]);
for ii = 1 : size(I_MS,3)    
  imageHR(:,:,ii) = (imageHR(:,:,ii) - mean2(imageHR(:,:,ii))).*(std2(I_MS(:,:,ii))./std2(imageHR(:,:,ii))) + mean2(I_MS(:,:,ii));  
end

switch sensor
    case {'QB'}
        MTF_MS = [0.34 0.32 0.30 0.22]; % Band Order: B,G,R,NIR
    case {'IKONOS'}
        MTF_MS = [0.26,0.28,0.29,0.28]; % Band Order: B,G,R,NIR
    case 'All_03'
        MTF_MS = 0.3*ones(1,size(I_MS,3));%[0.3,0.3,0.3,0.3]; % Band Order: B,G,R,NIR
    case 'MS_029_PAN_015'
        MTF_MS = 0.29*ones(1,size(I_MS,3));
    case 'GeoEye1'
        MTF_MS = [0.23,0.23,0.23,0.23]; % Band Order: B,G,R,NIR
    case 'WV2'
        MTF_MS =  [0.35 .* ones(1,7), 0.27];
        case 'WV4'
        MTF_MS = [0.35 .* ones(1,7), 0.27];
    case 'Pleiades'
        MTF_MS = 0.3 .* ones(1,4);
    case {'WV3','WV3_4bands'}
        MTF_MS = [0.325 0.355 0.360 0.350 0.365 0.360 0.335 0.315];
        if strcmp(sensor,'WV3_4bands')
            tag = [2 3 5 7];
            %             GNyq = GNyq([2 3 5 7]);
        end
    case {'HYP','HYP_14_33','HYP_16_31'}
        flag_resize_new = 2; % MTF usage
        %VNIR
        MTF_MS(1:21)=0.27;
        MTF_MS(22:41)=0.28;
        MTF_MS(42:49)=0.26;
        MTF_MS(50:70)=0.26;
        %SWIR
        MTF_MS(71:100)=0.30;
        MTF_MS(101:130)=0.30;
        MTF_MS(131:177)=0.27;
        MTF_MS(177:242)=0.27;
        if strcmp(sensor,'HYP_14_33')
            tag = 14:33;
        elseif strcmp(sensor,'HYP_16_31')
            tag = 16:31;
        end
    case {'Ali_MS'}
        MTF_MS=[0.29,0.30,0.28,0.29,0.28,0.29,0.25,0.25,0.25];
    case 'none'
        MTF_MS = 0.29 .* ones(1,size(I_MS,3));
end

if (~isempty(tag) && isnumeric(tag))
    GNyq = MTF_MS(tag);
else
    GNyq = MTF_MS;
end
%%% LPF MTF
N = 41;
PAN_LP = zeros(size(imageHR));
nBands = size(I_MS,3);
fcut = 1/(ratio/2);
   
for ii = 1 : nBands
    alpha = sqrt((N*(fcut/2))^2/(-2*log(GNyq(ii))));
    H = fspecial('gaussian', N, alpha);
    Hd = H./max(H(:));
    h = fwind1(Hd,kaiser(N));
    PAN_LP(:,:,ii) = imfilter(imageHR(:,:,ii),real(h),'replicate');
end
PAN_LP = double(PAN_LP);

%%% Downsampling and Interpolation (h_{LPF})
PAN_LP_D = imresize(PAN_LP,1/(ratio/2),'nearest');

PAN_LP = imresize(PAN_LP_D,(ratio/2),'bilinear');

PAN_LP_D = imresize(PAN_LP,1/(ratio/2),'nearest');


%%% LPF MTF
N = 41;
PAN_LP_LP = zeros(size(PAN_LP_D));
nBands = size(I_MS,3);
fcut = 1/(ratio/2);
   
for ii = 1 : nBands
    alpha = sqrt((N*(fcut/2))^2/(-2*log(GNyq(ii))));
    H = fspecial('gaussian', N, alpha);
    Hd = H./max(H(:));
    h = fwind1(Hd,kaiser(N));
    PAN_LP_LP(:,:,ii) = imfilter(PAN_LP_D(:,:,ii),real(h),'replicate');
end

%%% Downsampling and Interpolation (h_{LPF})
PAN_LP_LP = imresize(PAN_LP_LP,1/(ratio/2),'nearest');

PAN_LP_LP = imresize(PAN_LP_LP,(ratio/2),'bilinear');

I_Fus_MTF_GLP_HPM_PP = Fusion_Procedure_MTF_GLP_HPM_PP(PAN_LP_D,I_MS,PAN_LP_LP,ratio/2);
I_Fus_MTF_GLP_HPM_PP = Fusion_Procedure_MTF_GLP_HPM_PP(imageHR,I_Fus_MTF_GLP_HPM_PP,PAN_LP,ratio/2);

end