%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description:
%           Full resolution quality indexes.
%
% Interface:
%           [D_lambda,D_S,QNR_index,SAM_index,sCC,DQstar] = indexes_evaluation_FS(I_F,I_MS_LR,I_PAN,L,th_values,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size)
%
% Inputs:
%           I_F:                Fused Image;
%           I_MS_LR:            MS image;
%           I_PAN:              Panchromatic image;
%           L:                  Image radiometric resolution;
%           th_values:          Flag. If th_values == 1, apply an hard threshold to the dynamic range;
%           I_MS:               MS image upsampled to the PAN size;
%           sensor_MS:          String for type of LR sensor (e.g. 'WV2','IKONOS');
%           tag_MS:             LR image tag. It makes sense when a subset of bands is employed.
%                               It indicates the employed bands in the latter case.
%           sensor_PAN:         String for type of HR sensor (e.g. 'WV2','IKONOS');
%           tag_PAN:            HR image tag. It makes sense when a subset of bands is employed.
%                               It indicates the employed bands in the latter case.
%           ratio:              Scale ratio between MS and PAN. Pre-condition: Integer value.
%           Qblocks_size:       Block size (optional); Default value: 32;
%
% Outputs:
%           D_lambda:           D_lambda index;
%           D_S:                D_S index;
%           HQNR_index:          QNR index;
%           SAM_index:          Spectral Angle Mapper (SAM) index between fused and MS image;
%           sCC:                spatial Correlation Coefficient between fused and PAN images.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [D_lambda,D_S,HQNR_index,SAM_index,sCC,D_S_star,Q_star,...
    D_S_HSMS,Q_HSMS,D_S_mod,HQNR_index_mod,D_S_Khan,Q_Khan] = ...
    indexes_evaluation_FS_MI_BS(I_F,I_MS_LR,I_Ref,Groups_Ref,ass_Ref,...
    sensor_Ref,bands_Ref,L,th_values,I_MS,...
    sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size)

% keyboard
if th_values
    I_F(I_F > 2^L) = 2^L;
    I_F(I_F < 0) = 0;
end
if nargin < 12, Qblocks_size=32; end %Default value of the Block Size

% Versione:
% kind = 't'; % Toolbox Version
kind = 'd'; % Decimated Low Resolution Version
% kind = 'u'; % Undecimated Q Local Version
% kind = 'g'; % HQNR Gemine (MTF and MTF_PAN filters divided by N (and not N-1) and LR images)

% cd Quality_Indices
% cd HQNR
% [HQNR_index,D_lambda,D_S]= HQNR(I_F,I_MS_LR,I_MS,I_PAN,Qblocks_size,...
%     sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,kind);
D_lambda = D_lambda_K(I_F,I_MS_LR,ratio,sensor_MS,tag_MS,Qblocks_size);
D_S = D_s_decimated_BS(I_F,I_MS,I_Ref,Groups_Ref,ass_Ref,sensor_Ref,bands_Ref,...
    Qblocks_size,ratio,1,sensor_PAN,tag_PAN);
HQNR_index = (1-D_lambda)*(1-D_S);

I_Ref_filt = mean(imresize(I_Ref,1/ratio),3);
I_MS_LR_mean = mean(I_MS_LR,3);
I_Ref_mod = I_Ref*std2(I_MS_LR_mean)/std2(I_Ref_filt);
% I_Ref_mod = I_Ref*mad(I_MS_LR_mean(:))/mad(I_PAN_filt(:));
% D_S_mod = D_s_decimated_mod(I_F,I_MS,I_Ref_mod,Qblocks_size,ratio,1,sensor_PAN,tag_PAN);
D_S_mod = D_s_decimated_BS(I_F,I_MS,I_Ref_mod,Groups_Ref,ass_Ref,sensor_Ref,bands_Ref,...
    Qblocks_size,ratio,1,sensor_PAN,tag_PAN);
HQNR_index_mod = (1-D_lambda)*(1-D_S_mod);

D_S_star = D_s_Reg(I_F,mean(I_Ref,3));
Q_star = (1-D_lambda)*(1-D_S_star);
% [Q_star,~,D_S_star]= QStar(I_F,I_MS_LR,I_PAN,Qblocks_size,...
%     sensor_MS,tag_MS,ratio);
D_S_HSMS = D_s_decimated_HSMS_BS(I_F,I_MS,I_Ref,Groups_Ref,ass_Ref,sensor_Ref,bands_Ref,...
    Qblocks_size,ratio,1,sensor_PAN,tag_PAN);
% D_S_HSMS = D_s_decimated_HSMS_mod(I_F,I_MS,I_PAN,Qblocks_size,ratio,1,...
%     sensor_PAN,tag_PAN);

Q_HSMS = (1-D_lambda)*(1-D_S_HSMS);
% Im_Lap_PAN = zeros(size(I_PAN));
% for idim=1:size(I_PAN,3),
%     Im_Lap_PAN(:,:,idim)= imfilter(I_PAN(:,:,idim),fspecial('sobel'));
% end

[~,D_S_Khan]=Khan_BS(I_F,I_MS,I_Ref,Groups_Ref,ass_Ref,sensor_Ref,bands_Ref,...
    I_MS_LR,sensor_MS,tag_MS,ratio,Qblocks_size);
Q_Khan = (1-D_lambda)*(1-D_S_Khan);

switch kind
    case 'g'
        I_F_D = MTF_Gemine(I_F,sensor_MS,tag_MS,ratio);
    otherwise
        I_F_D = MTF(I_F,sensor_MS,tag_MS,ratio);
end

I_F_D = imresize(I_F_D,1/ratio,'nearest');
SAM_index = SAM(I_MS_LR,I_F_D);

% Im_Lap_F = zeros(size(I_F));
% for idim=1:size(I_MS_LR,3),
%     Im_Lap_F(:,:,idim)= imfilter(I_F(:,:,idim),fspecial('sobel'));
% end

% sCC=sum(sum(sum(Im_Lap_PAN.*Im_Lap_F)));
% sCC=sCC/sqrt(sum(sum(sum((Im_Lap_PAN.^2)))));
% sCC=sCC/sqrt(sum(sum(sum((Im_Lap_F.^2)))));
% keyboard
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I_Ref = mean(I_Ref,3);
% I_Ref = repmat(I_Ref,[1 1 size(I_MS,3)]);
for kk = 1: numel(Groups_Ref)
    Ref_Band(Groups_Ref{kk}) = kk;
end
for kkk = 1 : size(I_F,3)
sCC_Band(kkk)=SCC(I_F(:,:,kkk),I_Ref(:,:,Ref_Band(kkk))); %to implement
end
sCC = mean(sCC_Band);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cd ..

end