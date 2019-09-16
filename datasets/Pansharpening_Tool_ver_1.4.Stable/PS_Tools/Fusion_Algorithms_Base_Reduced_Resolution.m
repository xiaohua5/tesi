
%% MS

if show_results
    if size(I_GT,3) == 4
        showImage4LR(I_MS_LR,printEPS,100,flag_cut_bounds,dim_cut,thvalues,L,ratio);
    elseif size(I_MS_LR,3) == 8
        showImage8LR(I_MS_LR,printEPS,100,flag_cut_bounds,dim_cut,thvalues,L,ratio);
    else
        showImageHSLR(I_MS_LR,printEPS,100,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display,ratio);
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
[Q_avg_GT, SAM_GT, ERGAS_GT, SCC_GT_GT, Q_GT] = indexes_evaluation(I_GT,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

titleImages{alg}='GT';
if show_results
    if size(I_GT,3) == 4
        showImage4(I_GT,printEPS,0,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_GT,3) == 8
        showImage8(I_GT,printEPS,0,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_GT,printEPS,0,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults(alg,:) = [Q_GT,Q_avg_GT,SAM_GT,ERGAS_GT,SCC_GT_GT,0];

%% EXP
alg = alg+1;
[Q_avg_EXP, SAM_EXP, ERGAS_EXP, SCC_GT_EXP, Q_EXP] = indexes_evaluation(I_MS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
titleImages{alg}='EXP';
if show_results
    if size(I_GT,3) == 4
        showImage4(I_MS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_GT,3) == 8
        showImage8(I_MS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_MS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end

MatrixResults(alg,:) = [Q_EXP,Q_avg_EXP,SAM_EXP,ERGAS_EXP,SCC_GT_EXP,0];
