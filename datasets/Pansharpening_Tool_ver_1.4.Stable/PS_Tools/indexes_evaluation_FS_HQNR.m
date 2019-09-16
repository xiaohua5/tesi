%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description:
%           Full resolution quality indexes.
%
% Interface:
%           [D_lambda,D_S,QNR_index,SAM_index,sCC] = indexes_evaluation_FS(I_F,I_MS_LR,I_PAN,L,th_values,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size)
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
function [D_lambda,D_S,HQNR_index,SAM_index,sCC] = indexes_evaluation_FS_HQNR(I_F,I_MS_LR,I_PAN,L,th_values,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size)

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
[HQNR_index,D_lambda,D_S]= HQNR(I_F,I_MS_LR,I_MS,I_PAN,Qblocks_size,...
    sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,kind);


% Im_Lap_PAN = zeros(size(I_PAN));
% for idim=1:size(I_PAN,3),
%     Im_Lap_PAN(:,:,idim)= imfilter(I_PAN(:,:,idim),fspecial('sobel'));
% end

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
I_PAN = mean(I_PAN,3);
I_PAN = repmat(I_PAN,[1 1 size(I_MS,3)]);
sCC=SCC(I_F,I_PAN); %to implement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cd ..

end