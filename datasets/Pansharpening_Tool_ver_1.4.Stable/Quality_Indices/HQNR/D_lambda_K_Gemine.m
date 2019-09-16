function Dl = D_lambda_K(fused,ms,ratio,sensor,tag,S)
%
% Dl = D_lambda_K(fused,exp,ratio,sensor,tag,S);
%
%       fused:  pansharpened image
%       ms:     original MS image
%       ratio:  MS scale over panchromatic scale
%       sensor: 'QB' or 'IKONOS' or 'GeoEye1' or 'WV2' or 'none'
%       tag:    (used only if sensor='none') 'WV2' for 8 bands, or []
%       S:      block size
%
if (size(fused,1) ~= ratio*size(ms,1) || size(fused,2) ~= ratio*size(ms,2))
    error('The two images must have the same dimensions')
end

[N,M,~] = size(fused);
if (rem(N,S) ~= 0)
    error('number of rows must be multiple of the block size')
end
if (rem(M,S) ~= 0)
    error('number of columns must be multiple of the block size')
end
%
% keyboard
fused_degraded = MTF_Gemine(fused,sensor,tag,ratio);
fused_degraded = imresize(fused_degraded,1/ratio,'nearest');
%% keyboard
[Q2n_index,~] = q2n(ms,fused_degraded,S,S);
Dl = 1-Q2n_index;

