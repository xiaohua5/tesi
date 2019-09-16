%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  FR Indexes Calculation  %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


alg=0;

if ismember('GT',titleImages)
    alg=alg+1;
[D_lambda_GT,D_S_GT,QNRI_GT,SAM_GT,sCC_GT] = indexes_evaluation_FS_HQNR(I_GT,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_GT,D_S_GT,QNRI_GT,SAM_GT,sCC_GT,0];
end

if ismember('EXP',titleImages)
    alg=alg+1;
[D_lambda_EXP,D_S_EXP,QNRI_EXP,SAM_EXP,sCC_EXP] = indexes_evaluation_FS_HQNR(I_MS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_EXP,D_S_EXP,QNRI_EXP,SAM_EXP,sCC_EXP,0];
end

if ismember('PCA',titleImages)
alg = alg+1;
% [D_lambda_PCA,D_S_PCA,QNRI_PCA,SAM_PCA,sCC_PCA] = indexes_evaluation_FS(I_PCA,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_PCA,D_S_PCA,QNRI_PCA,SAM_PCA,sCC_PCA] = indexes_evaluation_FS_HQNR(I_PCA,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_PCA,D_S_PCA,QNRI_PCA,SAM_PCA,sCC_PCA,time_PCA];
end

if ismember('IHS',titleImages)
alg = alg+1;
% [D_lambda_IHS,D_S_IHS,QNRI_IHS,SAM_IHS,sCC_IHS] = indexes_evaluation_FS(I_IHS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_IHS,D_S_IHS,QNRI_IHS,SAM_IHS,sCC_IHS] = indexes_evaluation_FS_HQNR(I_IHS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_IHS,D_S_IHS,QNRI_IHS,SAM_IHS,sCC_IHS,time_IHS];
end

if ismember('BT',titleImages)
alg = alg+1;
% [D_lambda_Brovey,D_S_Brovey,QNRI_Brovey,SAM_Brovey,sCC_Brovey] = indexes_evaluation_FS(I_Brovey,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_Brovey,D_S_Brovey,QNRI_Brovey,SAM_Brovey,sCC_Brovey] = indexes_evaluation_FS_HQNR(I_Brovey,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_Brovey,D_S_Brovey,QNRI_Brovey,SAM_Brovey,sCC_Brovey,time_Brovey];
end

if ismember('BDSD',titleImages)
alg = alg+1;
% [D_lambda_BDSD,D_S_BDSD,QNRI_BDSD,SAM_BDSD,sCC_BDSD] = indexes_evaluation_FS(I_BDSD,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_BDSD,D_S_BDSD,QNRI_BDSD,SAM_BDSD,sCC_BDSD] = indexes_evaluation_FS_HQNR(I_BDSD,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_BDSD,D_S_BDSD,QNRI_BDSD,SAM_BDSD,sCC_BDSD,time_BDSD];
end

if ismember('GS',titleImages)
alg=alg+1;
% [D_lambda_GS,D_S_GS,QNRI_GS,SAM_GS,sCC_GS] = indexes_evaluation_FS(I_GS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_GS,D_S_GS,QNRI_GS,SAM_GS,sCC_GS] = indexes_evaluation_FS_HQNR(I_GS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_GS,D_S_GS,QNRI_GS,SAM_GS,sCC_GS,time_GS];
end

if ismember('GSA',titleImages)
alg=alg+1;
% [D_lambda_GSA,D_S_GSA,QNRI_GSA,SAM_GSA,sCC_GSA] = indexes_evaluation_FS(I_GSA,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_GSA,D_S_GSA,QNRI_GSA,SAM_GSA,sCC_GSA] = indexes_evaluation_FS_HQNR(I_GSA,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_GSA,D_S_GSA,QNRI_GSA,SAM_GSA,sCC_GSA,time_GSA];
end

if ismember('PRACS',titleImages)alg=alg+1;
% [D_lambda_PRACS,D_S_PRACS,QNRI_PRACS,SAM_PRACS,sCC_PRACS] = indexes_evaluation_FS(I_PRACS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_PRACS,D_S_PRACS,QNRI_PRACS,SAM_PRACS,sCC_PRACS] = indexes_evaluation_FS_HQNR(I_PRACS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_PRACS,D_S_PRACS,QNRI_PRACS,SAM_PRACS,sCC_PRACS,time_PRACS];
end

if ismember('HPF',titleImages)
alg=alg+1;
% [D_lambda_HPF,D_S_HPF,QNRI_HPF,SAM_HPF,sCC_HPF] = indexes_evaluation_FS(I_HPF,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_HPF,D_S_HPF,QNRI_HPF,SAM_HPF,sCC_HPF] = indexes_evaluation_FS_HQNR(I_HPF,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_HPF,D_S_HPF,QNRI_HPF,SAM_HPF,sCC_HPF,time_HPF];
end

if ismember('SFIM',titleImages)
alg=alg+1;
% [D_lambda_SFIM,D_S_SFIM,QNRI_SFIM,SAM_SFIM,sCC_SFIM] = indexes_evaluation_FS(I_SFIM,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_SFIM,D_S_SFIM,QNRI_SFIM,SAM_SFIM,sCC_SFIM] = indexes_evaluation_FS_HQNR(I_SFIM,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_SFIM,D_S_SFIM,QNRI_SFIM,SAM_SFIM,sCC_SFIM,time_SFIM];
end

if ismember('Indusion',titleImages)
alg=alg+1;
% [D_lambda_Indusion,D_S_Indusion,QNRI_Indusion,SAM_Indusion,sCC_Indusion] = indexes_evaluation_FS(I_Indusion,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_Indusion,D_S_Indusion,QNRI_Indusion,SAM_Indusion,sCC_Indusion] = indexes_evaluation_FS_HQNR(I_Indusion,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_Indusion,D_S_Indusion,QNRI_Indusion,SAM_Indusion,sCC_Indusion,time_Indusion];
end

if ismember('ATWT',titleImages)
alg=alg+1;
% [D_lambda_ATWT,D_S_ATWT,QNRI_ATWT,SAM_ATWT,sCC_ATWT] = indexes_evaluation_FS(I_ATWT,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_ATWT,D_S_ATWT,QNRI_ATWT,SAM_ATWT,sCC_ATWT] = indexes_evaluation_FS_HQNR(I_ATWT,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_ATWT,D_S_ATWT,QNRI_ATWT,SAM_ATWT,sCC_ATWT,time_ATWT];
end

if ismember('AWLP',titleImages)
alg=alg+1;
% [D_lambda_AWLP,D_S_AWLP,QNRI_AWLP,SAM_AWLP,sCC_AWLP] = indexes_evaluation_FS(I_AWLP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_AWLP,D_S_AWLP,QNRI_AWLP,SAM_AWLP,sCC_AWLP] = indexes_evaluation_FS_HQNR(I_AWLP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_AWLP,D_S_AWLP,QNRI_AWLP,SAM_AWLP,sCC_AWLP,time_AWLP];
end

if ismember('ATWT-M2',titleImages)alg=alg+1;
% [D_lambda_ATWTM2,D_S_ATWTM2,QNRI_ATWTM2,SAM_ATWTM2,sCC_ATWTM2] = indexes_evaluation_FS(I_ATWTM2,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_ATWTM2,D_S_ATWTM2,QNRI_ATWTM2,SAM_ATWTM2,sCC_ATWTM2] = indexes_evaluation_FS_HQNR(I_ATWTM2,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_ATWTM2,D_S_ATWTM2,QNRI_ATWTM2,SAM_ATWTM2,sCC_ATWTM2,time_ATWTM2];
end

if ismember('ATWT-M3',titleImages)
    alg=alg+1;
% [D_lambda_ATWTM3,D_S_ATWTM3,QNRI_ATWTM3,SAM_ATWTM3,sCC_ATWTM3] = indexes_evaluation_FS(I_ATWTM3,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_ATWTM3,D_S_ATWTM3,QNRI_ATWTM3,SAM_ATWTM3,sCC_ATWTM3] = indexes_evaluation_FS_HQNR(I_ATWTM3,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_ATWTM3,D_S_ATWTM3,QNRI_ATWTM3,SAM_ATWTM3,sCC_ATWTM3,time_ATWTM3];
end

if ismember('GLP-HPF',titleImages)
alg=alg+1;
% [D_lambda_MTF_GLP,D_S_MTF_GLP,QNRI_MTF_GLP,SAM_MTF_GLP,sCC_MTF_GLP] = indexes_evaluation_FS(I_MTF_GLP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_MTF_GLP,D_S_MTF_GLP,QNRI_MTF_GLP,SAM_MTF_GLP,sCC_MTF_GLP] = indexes_evaluation_FS_HQNR(I_MTF_GLP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_MTF_GLP,D_S_MTF_GLP,QNRI_MTF_GLP,SAM_MTF_GLP,sCC_MTF_GLP,time_MTF_GLP];
end

if ismember('GLP-HPM',titleImages)
alg=alg+1;
% [D_lambda_MTF_GLP_HPM,D_S_MTF_GLP_HPM,QNRI_MTF_GLP_HPM,SAM_MTF_GLP_HPM,sCC_MTF_GLP_HPM] = indexes_evaluation_FS(I_MTF_GLP_HPM,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_MTF_GLP_HPM,D_S_MTF_GLP_HPM,QNRI_MTF_GLP_HPM,SAM_MTF_GLP_HPM,sCC_MTF_GLP_HPM] = indexes_evaluation_FS_HQNR(I_MTF_GLP_HPM,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_MTF_GLP_HPM,D_S_MTF_GLP_HPM,QNRI_MTF_GLP_HPM,SAM_MTF_GLP_HPM,sCC_MTF_GLP_HPM,time_MTF_GLP_HPM];
end

if ismember('GLP-HPM-PP',titleImages)
alg=alg+1;
% [D_lambda_MTF_GLP_HPM_PP,D_S_MTF_GLP_HPM_PP,QNRI_MTF_GLP_HPM_PP,SAM_MTF_GLP_HPM_PP,sCC_MTF_GLP_HPM_PP] = indexes_evaluation_FS(I_MTF_GLP_HPM_PP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_MTF_GLP_HPM_PP,D_S_MTF_GLP_HPM_PP,QNRI_MTF_GLP_HPM_PP,SAM_MTF_GLP_HPM_PP,sCC_MTF_GLP_HPM_PP] = indexes_evaluation_FS_HQNR(I_MTF_GLP_HPM_PP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_MTF_GLP_HPM_PP,D_S_MTF_GLP_HPM_PP,QNRI_MTF_GLP_HPM_PP,SAM_MTF_GLP_HPM_PP,sCC_MTF_GLP_HPM_PP,time_MTF_GLP_HPM_PP];
end


if ismember('GLP-CBD',titleImages)
alg=alg+1;
% [D_lambda_MTF_GLP_CBD,D_S_MTF_GLP_CBD,QNRI_MTF_GLP_CBD,SAM_MTF_GLP_CBD,sCC_MTF_GLP_CBD] = indexes_evaluation_FS(I_MTF_GLP_CBD,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_MTF_GLP_CBD,D_S_MTF_GLP_CBD,QNRI_MTF_GLP_CBD,SAM_MTF_GLP_CBD,sCC_MTF_GLP_CBD] = indexes_evaluation_FS_HQNR(I_MTF_GLP_CBD,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_MTF_GLP_CBD,D_S_MTF_GLP_CBD,QNRI_MTF_GLP_CBD,SAM_MTF_GLP_CBD,sCC_MTF_GLP_CBD,time_MTF_GLP_CBD];
end

if ismember('PNN-Masi',titleImages)
alg=alg+1;
% [D_lambda_PNN_Masi,D_S_PNN_Masi,QNRI_PNN_Masi,SAM_PNN_Masi,sCC_PNN_Masi] = indexes_evaluation_FS(I_PNN_Masi,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_PNN_Masi,D_S_PNN_Masi,QNRI_PNN_Masi,SAM_PNN_Masi,sCC_PNN_Masi] = indexes_evaluation_FS_HQNR(I_PNN_Masi,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_PNN_Masi,D_S_PNN_Masi,QNRI_PNN_Masi,SAM_PNN_Masi,sCC_PNN_Masi,time_PNN_Masi];
end

if ismember('PNN-FT',titleImages)
alg=alg+1;
% [D_lambda_PNN_FT,D_S_PNN_FT,QNRI_PNN_FT,SAM_PNN_FT,sCC_PNN_FT] = indexes_evaluation_FS(I_PNN_FT,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_PNN_FT,D_S_PNN_FT,QNRI_PNN_FT,SAM_PNN_FT,sCC_PNN_FT] = indexes_evaluation_FS_HQNR(I_PNN_FT,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_PNN_FT,D_S_PNN_FT,QNRI_PNN_FT,SAM_PNN_FT,sCC_PNN_FT,time_PNN_FT];
end

if ismember('PNN-Random',titleImages)
alg=alg+1;
% [D_lambda_PNN_Random ,D_S_PNN_Random ,QNRI_PNN_Random ,SAM_PNN_Random ,sCC_PNN_Random ] = indexes_evaluation_FS(I_PNN_Random ,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_PNN_Random ,D_S_PNN_Random ,QNRI_PNN_Random ,SAM_PNN_Random ,sCC_PNN_Random ] = indexes_evaluation_FS_HQNR(I_PNN_Random ,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_PNN_Random ,D_S_PNN_Random ,QNRI_PNN_Random ,SAM_PNN_Random ,sCC_PNN_Random ,time_PNN_Random ];
end

if ismember('PNN-Diff',titleImages)
alg=alg+1;
% [D_lambda_PNN_Diff  ,D_S_PNN_Diff  ,QNRI_PNN_Diff  ,SAM_PNN_Diff  ,sCC_PNN_Diff  ] = indexes_evaluation_FS(I_PNN_Diff  ,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,);
[D_lambda_PNN_Diff  ,D_S_PNN_Diff  ,QNRI_PNN_Diff  ,SAM_PNN_Diff  ,sCC_PNN_Diff  ] = indexes_evaluation_FS_HQNR(I_PNN_Diff  ,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor_MS,tag_MS,sensor_PAN,tag_PAN,ratio,Qblocks_size);
MatrixResults_FR(alg,:) = [D_lambda_PNN_Diff  ,D_S_PNN_Diff  ,QNRI_PNN_Diff  ,SAM_PNN_Diff  ,sCC_PNN_Diff  ,time_PNN_Diff  ];
end
