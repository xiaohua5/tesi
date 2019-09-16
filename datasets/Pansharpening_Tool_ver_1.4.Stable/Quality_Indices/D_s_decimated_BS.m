function Ds = D_s_decimated_BS(fused,exp,ref,Groups_Ref,ass_Ref,...
    sensor_Ref,bands_Ref,S,ratio,q,sensor,tag)
%
% Ds = D_s(fused,exp,ref,S,ratio,q,sensor);
%
%       fused:  pansharpened image
%       exp:    original MS image resampled to panchromatic scale
%       ref:    panchromatic band
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
[~,~,Nbp] = size(ref);

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
ref_filt = MTF_PAN(ref,sensor_Ref,ratio);
for kk = 1: Nbp
    Ref_Band(Groups_Ref{kk}) = kk;
end
% pan_filt = mean(pan_filt,3);
% expfilt=MTF(exp,'HYP',[],ratio);
%pan_LP_d = pan_LP(3:ratio:end,3:ratio:end);
% hh = gaussfir(1,1,18); % Gaussian filter matching ref MTF
% % hh = gaussfir(1,1,20); % Gaussian filter matching ref MTF
% H = hh'*hh;
% w = size(H,1);
% pan_filt_full = imfilter(odd_extension(ref,w,w),H,'full');
% pan_filt = pan_filt_full(w:w+N-1,w:w+M-1);
% keyboard
Ds = 0;
for ii = 1:Nb
    band1 = fused(:,:,ii);
    band2 = ref(:,:,Ref_Band(ii));
    fun_uqi = @(bs) uqi(bs.data,...
        band2(bs.location(1):bs.location(1)+S-1,...
        bs.location(2):bs.location(2)+S-1));
    Qmap_high = blockproc(band1,[S S],fun_uqi);
    Q_high = mean2(Qmap_high);
    % Decimated
    band1 = imresize(exp(:,:,ii),1./ratio,'nearest');%exp(:,:,i);
    band2 = imresize(ref_filt(:,:,Ref_Band(ii)),1./ratio,'nearest');%pan_filt;
%         band1 = exp(:,:,ii);
%         band2 = ref_filt(:,:,Ref_Band(ii));
%     band1 = imresize(expfilt(:,:,ii),1./ratio,'nearest');%exp(:,:,i);
%     band2 = imresize(ref_filt(:,:,Ref_Band(ii)),1./ratio);%pan_filt;
% band2 = imresize(ref_filt(:,:,Ref_Band(ii)),1./ratio);
    %% Mia
    fun_uqi = @(bs) uqi(bs.data,...
        band2(bs.location(1):bs.location(1)+S/ratio-1,...
        bs.location(2):bs.location(2)+S/ratio-1));
    Qmap_low = blockproc(band1,[S/ratio S/ratio],fun_uqi);
    %% Gemine
%     fun_uqi = @(bs) uqi(bs.data,...
%         band2(bs.location(1):bs.location(1)+S-1,...
%         bs.location(2):bs.location(2)+S-1));
%     Qmap_low = blockproc(band1,[S S],fun_uqi);
    
    %Undecimated (original Toolbox Version)
%         band1 = exp(:,:,ii);
%         band2 = pan_filt;
%         fun_uqi = @(bs) uqi(bs.data,...
%             band2(bs.location(1):bs.location(1)+S-1,...
%             bs.location(2):bs.location(2)+S-1));
%         Qmap_low = blockproc(band1,[S S],fun_uqi);
    Q_low = mean2(Qmap_low);
    A (ii) = Q_high;
    B (ii) = Q_low;

    Ds = Ds + abs(Q_high-Q_low)^q;
end
Ds = (Ds/Nb)^(1/q);
% keyboard
% figure,plot(A(:))
% hold on
% plot(B(:))
% legend('Qhigh','Qlow')

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
