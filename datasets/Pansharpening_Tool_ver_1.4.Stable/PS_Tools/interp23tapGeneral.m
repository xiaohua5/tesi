function I_Interpolated = interp23tapGeneral(I_Interpolated,ratio,tag_interp)
% keyboard

if nargin <3
    tag_interp ='o_o';
end

L_tap = 44; % tap

[r,c,b] = size(I_Interpolated);

if strcmp(tag_interp(1),'o')
    BaseCoeff = ratio.*fir1(L_tap,1./ratio);
else
    BaseCoeff = ratio.*fir1(L_tap+1,1./ratio);
end

if strcmp(tag_interp(3),'o')
    BaseCoeff2 = ratio.*fir1(L_tap,1./ratio);
else
    BaseCoeff2 = ratio.*fir1(L_tap+1,1./ratio);
end


I1LRU = zeros(ratio.*r, ratio.*c, b);
I1LRU(floor(ratio/2)+1:ratio:end,floor(ratio/2)+1:ratio:end,:) = I_Interpolated;

for ii = 1 : b
    t = I1LRU(:,:,ii);
    t = imfilter(t',BaseCoeff2,'circular');
    I1LRU(:,:,ii) = imfilter(t',BaseCoeff,'circular');
end

I_Interpolated = I1LRU;

end