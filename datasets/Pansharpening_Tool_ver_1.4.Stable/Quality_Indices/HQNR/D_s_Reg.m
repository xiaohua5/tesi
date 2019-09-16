function d_s = D_s_Reg(I_F, I_PAN)
warning off
% keyboard
%     X = [reshape(I_F,[size(I_F,1)*size(I_F,2) size(I_F,3)]) ones(size(I_F,1)*size(I_F,2),1)];
    X = reshape(I_F,[size(I_F,1)*size(I_F,2) size(I_F,3)]);
    Y = reshape(I_PAN,[size(I_PAN,1)*size(I_PAN,2) 1]);
    [~,~,~,~,STATS] = regress(Y,X);
    cd = STATS(1);
%     [~,~,cd,~] = LSR(I_F,I_PAN);
    d_s = 1 - cd;
end