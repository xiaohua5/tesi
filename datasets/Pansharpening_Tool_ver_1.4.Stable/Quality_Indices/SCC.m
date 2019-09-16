function [sCC,SCCMap]=SCC(I_F,I_GT)


% keyboard


%%% sCC
% Im_Lap_F = zeros(size(I_F));
for idim=1:size(I_F,3)
    Im_Lap_F_y= imfilter(I_F(2:end-1,2:end-1,idim),fspecial('sobel'));
Im_Lap_F_x= imfilter(I_F(2:end-1,2:end-1,idim),fspecial('sobel')');
Im_Lap_F(:,:,idim) = sqrt(Im_Lap_F_y.^2+Im_Lap_F_x.^2);
% Im_Lap_F(:,:,idim) = imfilter(I_F(2:end-1,2:end-1,idim),fspecial('laplacian'));
end
% Im_Lap_GT = zeros(size(I_GT));

for idim=1:size(I_GT,3)
    Im_Lap_GT_y= imfilter(I_GT(2:end-1,2:end-1,idim),fspecial('sobel'));
Im_Lap_GT_x= imfilter(I_GT(2:end-1,2:end-1,idim),fspecial('sobel')');
Im_Lap_GT(:,:,idim) = sqrt(Im_Lap_GT_y.^2+Im_Lap_GT_x.^2);
% Im_Lap_GT(:,:,idim) = imfilter(I_GT(2:end-1,2:end-1,idim),fspecial('laplacian'));

end

% 
% % Im_Lap_F= zeros(size(I_F));
% % Im_Lap_F_PAN= imfilter(I_F,fspecial('sobel'));
% Im_Lap_F_PAN_y= imfilter(I_F,fspecial('sobel'));
% Im_Lap_F_PAN_x= imfilter(I_F,fspecial('sobel')');
% Im_Lap_F= sqrt(Im_Lap_F_PAN_y.^2+Im_Lap_F_PAN_x.^2);
% % Im_Lap_GT = zeros(size(I_PAN));
% % Im_Lap_GT= imfilter(I_PAN,fspecial('sobel'));
% Im_Lap_GT_y= imfilter(I_GT,fspecial('sobel'));
% Im_Lap_GT_x= imfilter(I_GT,fspecial('sobel')');
% Im_Lap_GT = sqrt(Im_Lap_GT_y.^2+Im_Lap_GT_x.^2);


sCC=sum(sum(sum(Im_Lap_F.*Im_Lap_GT)));
sCC = sCC/sqrt(sum(Im_Lap_F(:).^2));
sCC = sCC/sqrt(sum(Im_Lap_GT(:).^2));

SCCMap=sum(Im_Lap_F.*Im_Lap_GT,3)/sqrt(sum(Im_Lap_F(:).^2))...
    /sqrt(sum(Im_Lap_GT(:).^2));

% for idim=1:size(I_GT,3)
% A(idim) =sum(sum(Im_Lap_F(:,:,idim).*Im_Lap_GT(:,:,idim)));
% A(idim)  = A(idim) /sqrt(sum(sum(Im_Lap_F(:,:,idim).^2)));
% A(idim)  = A(idim) /sqrt(sum(sum(Im_Lap_GT(:,:,idim).^2)));
%    
% end
%     figure,plot(A(:))
% % hold on
% % plot(B(:))
% legend('SCC')


