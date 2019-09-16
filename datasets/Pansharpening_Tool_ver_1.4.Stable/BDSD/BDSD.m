%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           BDSD fuses the upsampled MultiSpectral (MS) and PANchromatic (PAN) images by 
%           exploiting the Band-Dependent Spatial-Detail (BDSD) algorithm. 
% 
% Interface:
%           I_Fus_BDSD = BDSD(I_MS,I_PAN,ratio,S,sensor)
%
% Inputs:
%           I_MS:           MS image upsampled at PAN scale;
%           I_PAN:          PAN image;
%           ratio:          Scale ratio between MS and PAN. Pre-condition: Integer value;
%           S:              Local estimation on SxS distinct blocks (typically 128x128); 
%           sensor_MS:      String for type of LR sensor (e.g. 'WV2','IKONOS');
%           tag_MS:         LR image tag. It makes sense when a subset of bands is employed.
%                           It indicates the employed bands in the latter case. 
%           sensor_PAN:     String for type of HR sensor (e.g. 'WV2','IKONOS');
%           tag_PAN:        HR image tag. It makes sense when a subset of bands is employed.
%                           It indicates the employed bands in the latter case. 
%
% Outputs:
%           I_Fus_BDSD:     BDSD pansharpened image.
% 
% References:
%           [Garzelli08]    A. Garzelli, F. Nencini, and L. Capobianco, “Optimal MMSE pan sharpening of very high resolution multispectral images,” 
%                           IEEE Transactions on Geoscience and Remote Sensing, vol. 46, no. 1, pp. 228–236, January 2008.
%           [Vivone14]      G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”, 
%                           IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function I_Fus_BDSD = BDSD(I_MS,I_PAN,ratio,S,sensor_MS,sensor_PAN,tag_PAN)

%%%
% Control of input parameters and initialization
%%%
if nargin<7
    tag_PAN = 1;
end
if nargin <6
    sensor_PAN = sensor_MS;
end

addpath('..\PS_Tools')

if (S > 1)
    if(rem(S,2) && S >1)
        fprintf(1,'\n\n ');
        error('block size for local estimation must be even')
    end

    if(rem(S,ratio))
        fprintf(1,'\n\n ');
        error('block size must be multiple of ratio')
    end

    [N,M] = size(I_PAN);

    if(rem(N,S)||rem(M,S))
        fprintf(1,'\n\n ');
        error('x and y dims of pan must be multiple of the block size')
    end
end

I_MS = double(I_MS);
I_PAN = double(I_PAN);

%%%
% Reduced resolution
%%%

pan_LP = MTF_PAN(I_PAN,sensor_PAN,ratio,tag_PAN);
% pan_LP_d = pan_LP(3:ratio:end,3:ratio:end);
pan_LP_d = imresize(pan_LP,1/ratio,'nearest');

ms_orig = imresize(I_MS,1/ratio);

ms_LP_d = MTF(ms_orig,sensor_MS,[],ratio);

IHc = pan_LP_d(:);
ILRc = reshape(ms_LP_d,[size(ms_LP_d,1)*size(ms_LP_d,2) size(ms_LP_d,3)]);
Diffc = reshape(ms_orig - ms_LP_d,[size(ms_LP_d,1)*size(ms_LP_d,2) size(ms_LP_d,3)]);
g = [ILRc,IHc]\Diffc;

IHHc = I_PAN(:);
IHRc = reshape(I_MS,[size(I_MS,1)*size(I_MS,2) size(I_MS,3)]);
I_Fus_BDSD2c = IHRc+[IHRc,IHHc]*g;
I_Fus_BDSD = reshape(I_Fus_BDSD2c,...
    [size(I_MS,1) size(I_MS,2) size(I_MS,3)]);


