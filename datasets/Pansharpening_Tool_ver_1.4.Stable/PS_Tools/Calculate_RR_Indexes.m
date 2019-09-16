%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  RR Indexes Calculation  %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


alg=0;

if ismember('GT',titleImages)
    alg=alg+1;
    [Q_avg_GT, SAM_GT, ERGAS_GT, SCC_GT_GT, Q_GT] = indexes_evaluation(I_GT,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_GT,Q_avg_GT,SAM_GT,ERGAS_GT,SCC_GT_GT,0];
end

if ismember('EXP',titleImages)
    alg=alg+1;
    [Q_avg_EXP, SAM_EXP, ERGAS_EXP, SCC_GT_EXP, Q_EXP] = indexes_evaluation(I_MS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_EXP,Q_avg_EXP,SAM_EXP,ERGAS_EXP,SCC_GT_EXP,0];
end

if ismember('PCA',titleImages)
    alg=alg+1;
    [Q_avg_PCA, SAM_PCA, ERGAS_PCA, SCC_GT_PCA, Q_PCA] = indexes_evaluation(I_PCA,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_PCA,Q_avg_PCA,SAM_PCA,ERGAS_PCA,SCC_GT_PCA,time_PCA];
end

if ismember('IHS',titleImages)
    alg=alg+1;
    [Q_avg_IHS, SAM_IHS, ERGAS_IHS, SCC_GT_IHS, Q_IHS] = indexes_evaluation(I_IHS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_IHS,Q_avg_IHS,SAM_IHS,ERGAS_IHS,SCC_GT_IHS,time_IHS];
end

if ismember('BT',titleImages)
    alg=alg+1;
    [Q_avg_Brovey, SAM_Brovey, ERGAS_Brovey, SCC_GT_Brovey, Q_Brovey] = indexes_evaluation(I_Brovey,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_Brovey,Q_avg_Brovey,SAM_Brovey,ERGAS_Brovey,SCC_GT_Brovey,time_Brovey];
end

if ismember('BDSD',titleImages)
    alg=alg+1;
    [Q_avg_BDSD, SAM_BDSD, ERGAS_BDSD, SCC_GT_BDSD, Q_BDSD] = indexes_evaluation(I_BDSD,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_BDSD,Q_avg_BDSD,SAM_BDSD,ERGAS_BDSD,SCC_GT_BDSD,time_BDSD];
end

if ismember('GS',titleImages)
    alg=alg+1;
    [Q_avg_GS, SAM_GS, ERGAS_GS, SCC_GT_GS, Q_GS] = indexes_evaluation(I_GS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_GS,Q_avg_GS,SAM_GS,ERGAS_GS,SCC_GT_GS,time_GS];
end

if ismember('GSA',titleImages)
    alg=alg+1;
    [Q_avg_GSA, SAM_GSA, ERGAS_GSA, SCC_GT_GSA, Q_GSA] = indexes_evaluation(I_GSA,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_GSA,Q_avg_GSA,SAM_GSA,ERGAS_GSA,SCC_GT_GSA,time_GSA];
end

if ismember('PRACS',titleImages)
    alg=alg+1;
    [Q_avg_PRACS, SAM_PRACS, ERGAS_PRACS, SCC_GT_PRACS, Q_PRACS] = indexes_evaluation(I_PRACS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_PRACS,Q_avg_PRACS,SAM_PRACS,ERGAS_PRACS,SCC_GT_PRACS,time_PRACS];
end

if ismember('HPF',titleImages)
    alg=alg+1;
    [Q_avg_HPF, SAM_HPF, ERGAS_HPF, SCC_GT_HPF, Q_HPF] = indexes_evaluation(I_HPF,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_HPF,Q_avg_HPF,SAM_HPF,ERGAS_HPF,SCC_GT_HPF,time_HPF];
end

if ismember('SFIM',titleImages)
    alg=alg+1;
    [Q_avg_SFIM, SAM_SFIM, ERGAS_SFIM, SCC_GT_SFIM, Q_SFIM] = indexes_evaluation(I_SFIM,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_SFIM,Q_avg_SFIM,SAM_SFIM,ERGAS_SFIM,SCC_GT_SFIM,time_SFIM];
end

if ismember('Indusion',titleImages)
    alg=alg+1;
    [Q_avg_Indusion, SAM_Indusion, ERGAS_Indusion, SCC_GT_Indusion, Q_Indusion] = indexes_evaluation(I_Indusion,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_Indusion,Q_avg_Indusion,SAM_Indusion,ERGAS_Indusion,SCC_GT_Indusion,time_Indusion];
end

if ismember('ATWT',titleImages)
    alg=alg+1;
    [Q_avg_ATWT, SAM_ATWT, ERGAS_ATWT, SCC_GT_ATWT, Q_ATWT] = indexes_evaluation(I_ATWT,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_ATWT,Q_avg_ATWT,SAM_ATWT,ERGAS_ATWT,SCC_GT_ATWT,time_ATWT];
end

if ismember('AWLP',titleImages)
    alg=alg+1;
    [Q_avg_AWLP, SAM_AWLP, ERGAS_AWLP, SCC_GT_AWLP, Q_AWLP] = indexes_evaluation(I_AWLP,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_AWLP,Q_avg_AWLP,SAM_AWLP,ERGAS_AWLP,SCC_GT_AWLP,time_AWLP];
end

if ismember('ATWT-M2',titleImages)
    alg=alg+1;
    [Q_avg_ATWTM2, SAM_ATWTM2, ERGAS_ATWTM2, SCC_GT_ATWTM2, Q_ATWTM2] = indexes_evaluation(I_ATWTM2,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_ATWTM2,Q_avg_ATWTM2,SAM_ATWTM2,ERGAS_ATWTM2,SCC_GT_ATWTM2,time_ATWTM2];
end

if ismember('ATWT-M3',titleImages)
    alg=alg+1;
    [Q_avg_ATWTM3, SAM_ATWTM3, ERGAS_ATWTM3, SCC_GT_ATWTM3, Q_ATWTM3] = indexes_evaluation(I_ATWTM3,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_ATWTM3,Q_avg_ATWTM3,SAM_ATWTM3,ERGAS_ATWTM3,SCC_GT_ATWTM3,time_ATWTM3];
end

if ismember('GLP-HPF',titleImages)
    alg=alg+1;
    [Q_avg_MTF_GLP, SAM_MTF_GLP, ERGAS_MTF_GLP, SCC_GT_MTF_GLP, Q_MTF_GLP] = indexes_evaluation(I_MTF_GLP,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_MTF_GLP,Q_avg_MTF_GLP,SAM_MTF_GLP,ERGAS_MTF_GLP,SCC_GT_MTF_GLP,time_MTF_GLP];
end

if ismember('GLP-HPM',titleImages)
    alg=alg+1;
    [Q_avg_MTF_GLP_HPM, SAM_MTF_GLP_HPM, ERGAS_MTF_GLP_HPM, SCC_GT_MTF_GLP_HPM, Q_MTF_GLP_HPM] = indexes_evaluation(I_MTF_GLP_HPM,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_MTF_GLP_HPM,Q_avg_MTF_GLP_HPM,SAM_MTF_GLP_HPM,ERGAS_MTF_GLP_HPM,SCC_GT_MTF_GLP_HPM,time_MTF_GLP_HPM];
end

if ismember('GLP-HPM-PP',titleImages)
    alg=alg+1;
    [Q_avg_MTF_GLP_HPM_PP, SAM_MTF_GLP_HPM_PP, ERGAS_MTF_GLP_HPM_PP, SCC_GT_MTF_GLP_HPM_PP, Q_MTF_GLP_HPM_PP] = indexes_evaluation(I_MTF_GLP_HPM_PP,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_MTF_GLP_HPM_PP,Q_avg_MTF_GLP_HPM_PP,SAM_MTF_GLP_HPM_PP,ERGAS_MTF_GLP_HPM_PP,SCC_GT_MTF_GLP_HPM_PP,time_MTF_GLP_HPM_PP];
end

if ismember('GLP-CBD',titleImages)
    alg=alg+1;
    [Q_avg_MTF_GLP_CBD, SAM_MTF_GLP_CBD, ERGAS_MTF_GLP_CBD, SCC_GT_MTF_GLP_CBD, Q_MTF_GLP_CBD] = indexes_evaluation(I_MTF_GLP_CBD,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_MTF_GLP_CBD,Q_avg_MTF_GLP_CBD,SAM_MTF_GLP_CBD,ERGAS_MTF_GLP_CBD,SCC_GT_MTF_GLP_CBD,time_MTF_GLP_CBD];
end

if ismember('PNN-Masi',titleImages)
    alg=alg+1;
    [Q_avg_PNN_Masi, SAM_PNN_Masi, ERGAS_PNN_Masi, SCC_GT_PNN_Masi, Q_PNN_Masi] = indexes_evaluation(I_PNN_Masi,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_PNN_Masi,Q_avg_PNN_Masi,SAM_PNN_Masi,ERGAS_PNN_Masi,SCC_GT_PNN_Masi,time_PNN_Masi];
end


if ismember('PNN-FT',titleImages)
    alg=alg+1;
    [Q_avg_PNN_FT, SAM_PNN_FT, ERGAS_PNN_FT, SCC_GT_PNN_FT, Q_PNN_FT] = indexes_evaluation(I_PNN_FT,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_PNN_FT,Q_avg_PNN_FT,SAM_PNN_FT,ERGAS_PNN_FT,SCC_GT_PNN_FT,time_PNN_FT];
end



if ismember('PNN-Diff',titleImages)
    alg=alg+1;
    [Q_avg_PNN_Diff , SAM_PNN_Diff , ERGAS_PNN_Diff , SCC_GT_PNN_Diff , Q_PNN_Diff ] = indexes_evaluation(I_PNN_Diff ,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    MatrixResults(alg,:) = [Q_PNN_Diff ,Q_avg_PNN_Diff ,SAM_PNN_Diff ,ERGAS_PNN_Diff ,SCC_GT_PNN_Diff ,time_PNN_Diff ];
end
