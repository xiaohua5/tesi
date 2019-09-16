%% MS

if show_results
    if size(I_MS,3) == 4
        showImage4LR(I_MS_LR,printEPS,100,flag_cut_bounds,dim_cut,thvalues,L,ratio);
    elseif size(I_MS_LR,3) == 8
        showImage8LR(I_MS_LR,printEPS,100,flag_cut_bounds,dim_cut,thvalues,L,ratio);
    else
        showImageHS(I_MS_LR,printEPS,100,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,'MS_{LR}','EdgeColor','k','BackgroundColor','w');
end

%% PAN

if show_results
    showPan(I_PAN,printEPS,0,flag_cut_bounds,dim_cut);
    text(Xmap,Ymap,'PAN','EdgeColor','k','BackgroundColor','w');
end
%% GT

alg = alg+1;
titleImages{alg}='GT';
if exist('I_GT')

    % [D_lambda_GT,D_S_GT,QNRI_GT,SAM_GT,sCC_GT] = indexes_evaluation_FS(I_GT,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
    [D_lambda_GT,D_S_GT,QNRI_GT,SAM_GT,sCC_GT] = indexes_evaluation_FS_HQNR(I_GT,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);
    
    if show_results
        if size(I_MS,3) == 4
            showImage4(I_GT,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
        elseif size(I_MS,3) == 8
            showImage8(I_GT,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
        else
            showImageHS(I_GT,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
            text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
        end
    end
    MatrixResults_FR(alg,:) = [D_lambda_GT,D_S_GT,QNRI_GT,SAM_GT,sCC_GT,0];
else
    MatrixResults_FR(alg,:) = [0,0,1,0,1,0];
end

%% EXP
alg = alg+1;
% [D_lambda_EXP,D_S_EXP,QNRI_EXP,SAM_EXP,sCC_EXP] = indexes_evaluation_FS(I_MS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_EXP,D_S_EXP,QNRI_EXP,SAM_EXP,sCC_EXP] = indexes_evaluation_FS_HQNR(I_MS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='EXP';
if show_results
    if size(I_MS,3) == 4
        showImage4(I_MS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_MS,3) == 8
        showImage8(I_MS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_MS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
        text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
    end
end
MatrixResults_FR(alg,:) = [D_lambda_EXP,D_S_EXP,QNRI_EXP,SAM_EXP,sCC_EXP,0];

