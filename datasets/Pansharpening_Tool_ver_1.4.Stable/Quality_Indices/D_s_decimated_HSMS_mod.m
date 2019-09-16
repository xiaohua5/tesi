function Ds = D_s_decimated_HSMS(fused,exp,pan,S,ratio,q,sensor,tag)
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

if (size(fused) ~= size(exp))
    error('The two images must have the same dimensions')
end

[N,M,Nb] = size(fused);
[~,~,Nbp] = size(pan);

if (rem(N,S) ~= 0)
    error('number of rows must be multiple of the block size')
end

if (rem(M,S) ~= 0)
    error('number of columns must be multiple of the block size')
end
% load h67
% hh = h67;
% keyboard
%%%%%%%%%%%%%%%% Provvisorio %%%%%%%%%%%%%

%%%%%%%%%%%%%%%% Provvisorio %%%%%%%%%%%%%
pan_filt = MTF_PAN(pan,sensor,ratio);
% pan_filt = mean(pan_filt,3);
% pan = mean(pan,3);

%pan_LP_d = pan_LP(3:ratio:end,3:ratio:end);
% hh = gaussfir(1,1,18); % Gaussian filter matching Pan MTF
% % hh = gaussfir(1,1,20); % Gaussian filter matching Pan MTF
% H = hh'*hh;
% w = size(H,1);
% pan_filt_full = imfilter(odd_extension(pan,w,w),H,'full');
% pan_filt = pan_filt_full(w:w+N-1,w:w+M-1);
% keyboard
Ds = 0;
for jj=1:size(pan_filt,3)

for ii = 1:Nb
    band1 = fused(:,:,ii);
    band2 = pan(:,:,jj);
    C = cov(band1(:),band2(:))/cov(band2(:));
    band2 = C(1,2)/C(2,2)*band2;
    fun_uqi = @(bs) uqi(bs.data,...
        band2(bs.location(1):bs.location(1)+S-1,...
        bs.location(2):bs.location(2)+S-1));
    Qmap_high = blockproc(band1,[S S],fun_uqi);
    Q_high = mean2(Qmap_high);
    % Decimated
    band1 = imresize(exp(:,:,ii),1./ratio,'nearest');%exp(:,:,i);
    band2 = imresize(pan_filt(:,:,jj),1./ratio,'nearest');%pan_filt;
        C = cov(band1(:),band2(:))/cov(band2(:));
        band2 = C(1,2)/C(2,2)*band2; 
%     band1 = exp(:,:,i);
    %     band2 = pan_filt;
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
    A (ii,jj) = Q_high;
    B (ii,jj) = Q_low;

    Ds = Ds + abs(Q_high-Q_low)^q;
end
end
% Ds = (Ds/Nb)^(1/q);
Ds = (Ds/Nb/size(pan_filt,3))^(1/q);

% keyboard
figure,plot(A(:))
hold on
plot(B(:))
legend('Qhigh','Qlow')

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
