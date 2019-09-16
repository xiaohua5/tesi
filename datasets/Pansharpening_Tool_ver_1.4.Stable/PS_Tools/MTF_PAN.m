%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description:
%           MTF filters the image I_PAN using a Gaussin filter matched with the Modulation Transfer Function (MTF) of the PANchromatic (PAN) sensor.
%
% Interface:
%           I_Filtered = MTF_PAN(I_PAN,sensor,ratio)
%
% Inputs:
%           I_PAN:          PAN image;
%           sensor:         String for type of sensor (e.g. 'WV2', 'IKONOS');
%           ratio:          Scale ratio between MS and PAN.
%           Band:           It makes sense when a subset of bands is employed.
%                           It indicates the employed bands in the latter case.

% Outputs:
%           I_Filtered:     Output filtered PAN image.
%
% References:
%           [Aiazzi06]   B. Aiazzi, L. Alparone, S. Baronti, A. Garzelli, and M. Selva, “MTF-tailored multiscale fusion of high-resolution MS and Pan imagery,”
%                        Photogrammetric Engineering and Remote Sensing, vol. 72, no. 5, pp. 591–596, May 2006.
%           [Lee10]      J. Lee and C. Lee, “Fast and efficient panchromatic sharpening,” IEEE Transactions on Geoscience and Remote Sensing, vol. 48, no. 1,
%                        pp. 155–163, January 2010.
%           [Vivone14]   G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”,
%                        IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function I_Filtered = MTF_PAN(I_PAN,sensor,ratio,tag)

% keyboard
if nargin<4
    tag=1:size(I_PAN,3);
end
% if nargin<4
%     tag=[];
% end
switch sensor
    case {'QB','QB_PAN'}
        GNyq = 0.15;
    case {'QB_MS'}
        GNyq = [0.34 0.32 0.30 0.22];
    case {'IKONOS','IKONOS_PAN'}
        GNyq = 0.17;
    case {'IKONOS_MS'}
        GNyq = [0.26,0.28,0.29,0.28];
    case 'All_03'
%         GNyq = 0.3;
                GNyq = 0.15;
    case 'MS_029_PAN_015'
        GNyq = 0.15;
    case 'GeoEye1'
        GNyq = 0.16;
    case 'WV2'
        GNyq = 0.11;
    case 'WV4'
        GNyq = 0.14;
    case 'Pleiades'
        GNyq = 0.15;
    case {'WV3','WV3_4bands','WV3_PAN'}
        GNyq = 0.14;
    case {'WV3_MS'}
        GNyq = [0.325 0.355 0.360 0.350 0.365 0.360 0.335 0.315];
    case {'HYP','HYP_14_33','HYP_16_31'}
        GNyq = 0.11;
    case {'Ali_MS'}
        GNyq=[0.29,0.30,0.28,0.29,0.28,0.29,0.25,0.25,0.25];
    case {'Ali_PAN'}
        GNyq = 0.11; %%%%%%To check
    case 'Landsat8'
        GNyq = 0.4;
%        [Ref.] Lee, Storey, Morfitt, Choate, Hayes, Helder, Stone, 
%        Christopherson, Stensaas, "RER, FWHM, MTF from 
%        Landsat-8 OLI Lunar data (Level 1R), 2014    

    case 'none'
        GNyq = 0.15;
end
% keyboard
if size(I_PAN,3)>1 && length(GNyq)==1
    GNyq = GNyq*ones(1,size(I_PAN,3));
end
    
if (~isempty(tag) && isnumeric(tag))
    GNyq = GNyq(tag);
else
    GNyq = GNyq;
end
% keyboard
N = 41;
I_MS_LP = zeros(size(I_PAN));
nBands = size(I_PAN,3);
fcut = 1/ratio;

for ii = 1 : nBands
alpha = sqrt(((N-1)*(fcut/2))^2/(-2*log(GNyq(ii))));
H = fspecial('gaussian', N, alpha);
Hd = H./max(H(:));
h = fwind1(Hd,kaiser(N));
I_PAN_LP(:,:,ii)  = imfilter(I_PAN(:,:,ii),real(h),'replicate');
end
I_Filtered= double(I_PAN_LP);

end