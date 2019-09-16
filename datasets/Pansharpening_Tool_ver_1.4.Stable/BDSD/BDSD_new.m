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
function I_Fus_BDSD = BDSD_new(I_MS,I_PAN,ratio,S,sensor_MS,sensor_PAN,tag_PAN)

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

%%%
% Parameter estimation at reduced resolution
%%%
% keyboard
in3 = cat(3,ms_LP_d,ms_orig,pan_LP_d);
fun_eg = @(bs) estimate_gamma_cube(bs.data,S,ratio);
gamma = blockproc(in3,[S/ratio S/ratio],fun_eg);
%%%
% Fusion
%%%
Nb = size(I_MS,3);
if S < Nb+1
    fun_pad = @(cs) padarray(cs.data,[Nb+1-S,Nb-S],0,'post');
    I_MS = blockproc(I_MS,[S,S],fun_pad);
    I_PAN = blockproc(I_PAN,[S,S],fun_pad);
end
in3 = cat(3,I_MS,I_PAN,gamma);
fun_Hi = @(bs) compH_inject(bs.data,S);
if S < Nb+1
    S1=Nb+1;
    S2=Nb;
else
    S1=S;
    S2=S;
end
I_Fus_BDSD = blockproc(in3,[S1 S2],fun_Hi);

%%%_______________________________________________________________
%%%
function gamma = estimate_gamma_cube(in3,S,ratio)

Nb = (size(in3,3)-1)/2;
hs_LP_d = in3(:,:,1:Nb);
hs_orig = in3(:,:,Nb+1:2*Nb);
pan_LP_d = in3(:,:,2*Nb+1);
% Compute Hd
Hd = zeros(S*S/ratio/ratio,Nb+1);
for k=1:Nb
    b = hs_LP_d(:,:,k);
    Hd(:,k) = b(:);
end
Hd(:,Nb+1) = pan_LP_d(:);
% Estimate gamma
B = (Hd'*Hd)\Hd';
gamma = zeros(Nb+1,Nb);
for k=1:Nb
    b = hs_orig(:,:,k);
    bd = hs_LP_d(:,:,k);
    gamma(:,k) = B *(b(:)-bd(:));
end
% keyboard
if S>=Nb+1
gamma = padarray(gamma,[S-Nb-1 S-Nb],0,'post');
end


%%%_______________________________________________________________
%%%
function ms_en = compH_inject(in3,S)

% keyboard
Nb = size(in3,3)-2;
hs = in3(1:S,1:S,1:Nb);
pan = in3(1:S,1:S,Nb+1);
gamma = in3(:,:,Nb+2); 

% Compute H
[N,M,Nb] = size(hs);
H = zeros(S*S,Nb+1);
for k=1:Nb
    b = hs(:,:,k);
    H(:,k) = b(:);
end
H(:,Nb+1) = pan(:);
% Inject
if S>Nb+1
g = gamma(1:Nb+1,1:Nb);
else
    g=gamma;
end
ms_en = zeros(N,M,Nb);
for k=1:Nb
    b = hs(:,:,k);
    b_en = b(:) + H * g(:,k);
    ms_en(:,:,k) = reshape(b_en,N,M);
end