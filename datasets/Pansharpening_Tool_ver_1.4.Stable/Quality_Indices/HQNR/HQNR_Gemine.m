function [HQNR_value,Dl,Ds] = HQNR_Gemine(ps_ms,ms,msexp,pan,S,sensor_MS,tag_MS,...
    sensor_PAN,tag_PAN,ratio)
%
% [HQNR_value,Dl,Ds] = HQNR(ps_ms,msexp,pan,S,p,q,sensor,alpha,beta);
%       ps_ms:      pansharpened image
%       ms:         original ms image
%       msexp:      ms image upsampled to pan scale
%       pan:        original panchromatic image
%       S:          block size (S=32)
%       sensor:     'QB' or 'IKONOS' or 'GeoEye1' or 'WV2' or 'none'
%       tag:    (used only if sensor='none') 'WV2' for 8 bands, or []
%       ratio:  MS scale over panchromatic scale

% Toolbox Version
% keyboard
Dl = D_lambda_K_Gemine(ps_ms,ms,ratio,sensor_MS,tag_MS,S);
% Exp Version
% Dl = D_lambda_K2(ps_ms,msexp,ratio,sensor_MS,tag_MS,S);

% Toolbox Version
% Ds = D_s(ps_ms,msexp,pan,S,ratio,1,sensor_PAN,tag_PAN);
% Decimated Low Resolution Version
% Ds = D_s_decimated(ps_ms,msexp,pan,S,ratio,1,sensor_PAN,tag_PAN);
% Undecimated Q Local Version
% Ds = D_s_Q(ps_ms,msexp,pan,S,ratio,1,sensor_PAN,tag_PAN);


Ds = D_s_Gemine(ps_ms,msexp,pan,S,ratio,1,sensor_PAN,tag_PAN);

HQNR_value = (1-Dl)*(1-Ds);
