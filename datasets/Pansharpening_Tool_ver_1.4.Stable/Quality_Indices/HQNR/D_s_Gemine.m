function Ds = D_s_Gemine(fused,exp,pan,S,ratio,q,sensor,tag)
%
% Ds = D_s(fused,exp,pan,S,ratio,q,sensor);
%
%       fused:  pansharpened image
%       exp:    original MS image resampled to panchromatic scale
%       pan:    panchromatic band
%       S:      block size
%       ratio:  MS scale over panchromatic scale
%       q:      exponent for spatial distortion computation, see [1]
%       sensor: 'QB' or 'IKONOS' or 'GeoEye1' or 'WV2' or 'none'
%
% [1] "Multispectral and panchromatic data fusion assessment without reference"
% L.Alparone, B.Aiazzi, S.Baronti, A.Garzelli, F.Nencini, M.Selva
% PHOTOGRAMMETRIC ENGINEERING & REMOTE SENSING, Feb 2008.
%
% keyboard
if (size(fused) ~= size(exp))
    error('The two images must have the same dimensions')
end

[N,M,Nb] = size(fused);

if (rem(N,S) ~= 0)
    error('number of rows must be multiple of the block size')
end

if (rem(M,S) ~= 0)
    error('number of columns must be multiple of the block size')
end
% load h67
% hh = h67;

%%%%%%%%%%%%%%%% Provvisorio %%%%%%%%%%%%%
pan_filt = MTF_PAN_Gemine(pan,sensor,ratio);
pan_filt = mean(pan_filt,3);

% pan_filt = MTF_PAN_Gemine(pan,sensor,ratio);
%pan_LP_d = pan_LP(3:ratio:end,3:ratio:end);
% hh = gaussfir(1,1,18); % Gaussian filter matching Pan MTF
% % hh = gaussfir(1,1,20); % Gaussian filter matching Pan MTF
% H = hh'*hh;
% w = size(H,1);
% pan_filt_full = imfilter(odd_extension(pan,w,w),H,'full');
% pan_filt = pan_filt_full(w:w+N-1,w:w+M-1);
% keyboard
Ds = 0;
for i = 1:Nb
    band1 = fused(:,:,i);
    band2 = pan;
    fun_uqi = @(bs) uqi(bs.data,...
        band2(bs.location(1):bs.location(1)+S-1,...
        bs.location(2):bs.location(2)+S-1));
    Qmap_high = blockproc(band1,[S S],fun_uqi);
    Q_high = mean2(Qmap_high);
    % Decimated
    band1 = imresize(exp(:,:,i),1./ratio,'nearest');%exp(:,:,i);
    band2 = imresize(pan_filt,1./ratio,'nearest');%pan_filt;
%         band1 = exp(:,:,i);
%         band2 = pan_filt;
    %% Mia
%     fun_uqi = @(bs) uqi(bs.data,...
%         band2(bs.location(1):bs.location(1)+S/ratio-1,...
%         bs.location(2):bs.location(2)+S/ratio-1));
%     Qmap_low = blockproc(band1,[S/ratio S/ratio],fun_uqi);
    %% Gemine
    fun_uqi = @(bs) uqi(bs.data,...
        band2(bs.location(1):bs.location(1)+S-1,...
        bs.location(2):bs.location(2)+S-1));
    Qmap_low = blockproc(band1,[S S],fun_uqi);
    
    %Undecimated (original Toolbox Version)
    %     band1 = exp(:,:,i);
    %     band2 = pan_filt;
    %     fun_uqi = @(bs) uqi(bs.data,...
    %         band2(bs.location(1):bs.location(1)+S-1,...
    %         bs.location(2):bs.location(2)+S-1));
    %     Qmap_low = blockproc(band1,[S S],fun_uqi);
    Q_low = mean2(Qmap_low);
    Ds = Ds + abs(Q_high-Q_low)^q;
end
Ds = (Ds/Nb)^(1/q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Q = uqi(x,y)
%
% Q = uqi(x,y);
%
% keyboard
x = double(x(:));
y = double(y(:));
mx = mean(x);
my = mean(y);
C = cov(x,y);

Q = 4 * C(1,2) * mx * my / (C(1,1)+C(2,2)) / (mx^2 + my^2);
