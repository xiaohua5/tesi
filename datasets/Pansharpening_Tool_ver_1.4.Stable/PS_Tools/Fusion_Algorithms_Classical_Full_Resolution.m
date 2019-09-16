%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  RUN AND REDUCED RESOLUTION VALIDATION  %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%    Classical Algorithms
%%

%% PCA
alg = alg+1;
cd PCA
t2=tic;
I_PCA = PCA(I_MS,I_PAN);
time_PCA=toc(t2);
fprintf('Elaboration time PCA: %.2f [sec]\n',time_PCA);
cd ..

% if cut_outliers
%     I_PCA(I_PCA > 2^L) = 2^L;
%     I_PCA(I_PCA < 0) = 0;
% end
%
% [D_lambda_PCA,D_S_PCA,QNRI_PCA,SAM_PCA,sCC_PCA] = indexes_evaluation_FS(I_PCA,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_PCA,D_S_PCA,QNRI_PCA,SAM_PCA,sCC_PCA] = indexes_evaluation_FS_HQNR(I_PCA,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='PCA';
if show_results
    if size(I_PCA,3) == 4
        showImage4(I_PCA,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_PCA,3) == 8
        showImage8(I_PCA,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_PCA,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end

MatrixResults_FR(alg,:) = [D_lambda_PCA,D_S_PCA,QNRI_PCA,SAM_PCA,sCC_PCA,time_PCA];

%% IHS
alg = alg+1;
cd IHS
t2=tic;
I_IHS= IHS(I_MS,I_PAN);
%     I_IHS = IHS_mod(I_MS,I_PAN,ratio);

time_IHS=toc(t2);
fprintf('Elaboration time IHS: %.2f [sec]\n',time_IHS);
cd ..
% if cut_outliers
%     I_IHS(I_IHS > 2^L) = 2^L;
%     I_IHS(I_IHS < 0) = 0;
% end

% [D_lambda_IHS,D_S_IHS,QNRI_IHS,SAM_IHS,sCC_IHS] = indexes_evaluation_FS(I_IHS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_IHS,D_S_IHS,QNRI_IHS,SAM_IHS,sCC_IHS] = indexes_evaluation_FS_HQNR(I_IHS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='IHS';
if show_results
    if size(I_IHS,3) == 4
        showImage4(I_IHS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_IHS,3) == 8
        showImage8(I_IHS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_IHS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end

MatrixResults_FR(alg,:) = [D_lambda_IHS,D_S_IHS,QNRI_IHS,SAM_IHS,sCC_IHS,time_IHS];

%% Brovey
alg = alg+1;
cd Brovey
t2=tic;
I_Brovey = Brovey(I_MS,I_PAN);
%     I_Brovey = Brovey_mod(I_MS,I_PAN,ratio);
time_Brovey=toc(t2);
fprintf('Elaboration time Brovey: %.2f [sec]\n',time_Brovey);
cd ..

% if cut_outliers
%     I_Brovey(I_Brovey > 2^L) = 2^L;
%     I_Brovey(I_Brovey < 0) = 0;
% end

% [D_lambda_Brovey,D_S_Brovey,QNRI_Brovey,SAM_Brovey,sCC_Brovey] = indexes_evaluation_FS(I_Brovey,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_Brovey,D_S_Brovey,QNRI_Brovey,SAM_Brovey,sCC_Brovey] = indexes_evaluation_FS_HQNR(I_Brovey,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='BT';
if show_results
    if size(I_Brovey,3) == 4
        showImage4(I_Brovey,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_Brovey,3) == 8
        showImage8(I_Brovey,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_Brovey,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end

MatrixResults_FR(alg,:) = [D_lambda_Brovey,D_S_Brovey,QNRI_Brovey,SAM_Brovey,sCC_Brovey,time_Brovey];

%% BDSD
alg = alg+1;
cd BDSD
t2=tic;
%     Classical BDSD works only if gcd(size(I_MS,1),size(I_MS,2))>size(I_MS,3)
%     BDSD always works but is only global (namely,
%     gcd(size(I_MS,1),size(I_MS,2)) is not used
I_BDSD = BDSD(I_MS,I_PAN,ratio,gcd(size(I_MS,1),size(I_MS,2)),sensor,sensor);
%     BDSD_new works but has not been checked
% I_BDSD = BDSD_new(I_MS,I_PAN,ratio,gcd(size(I_MS,1),size(I_MS,2)),sensor,sensor);
time_BDSD = toc(t2);
fprintf('Elaboration time BDSD: %.2f [sec]\n',time_BDSD);
cd ..
% if cut_outliers
%     I_BDSD(I_BDSD > 2^L) = 2^L;
%     I_BDSD(I_BDSD < 0) = 0;
% end
%
% [D_lambda_BDSD,D_S_BDSD,QNRI_BDSD,SAM_BDSD,sCC_BDSD] = indexes_evaluation_FS(I_BDSD,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_BDSD,D_S_BDSD,QNRI_BDSD,SAM_BDSD,sCC_BDSD] = indexes_evaluation_FS_HQNR(I_BDSD,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='BDSD';
if show_results
    if size(I_BDSD,3) == 4
        showImage4(I_BDSD,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_BDSD,3) == 8
        showImage8(I_BDSD,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_BDSD,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults_FR(alg,:) = [D_lambda_BDSD,D_S_BDSD,QNRI_BDSD,SAM_BDSD,sCC_BDSD,time_BDSD];

%% GS
alg=alg+1;
cd GS
t2=tic;
I_GS = GS(I_MS,I_PAN);
time_GS = toc(t2);
fprintf('Elaboration time GS: %.2f [sec]\n',time_GS);
cd ..

% if cut_outliers
%     I_GS(I_GS > 2^L) = 2^L;
%     I_GS(I_GS < 0) = 0;
% end

% [D_lambda_GS,D_S_GS,QNRI_GS,SAM_GS,sCC_GS] = indexes_evaluation_FS(I_GS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_GS,D_S_GS,QNRI_GS,SAM_GS,sCC_GS] = indexes_evaluation_FS_HQNR(I_GS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='GS';
if show_results
    if size(I_GS,3) == 4
        showImage4(I_GS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_GS,3) == 8
        showImage8(I_GS,printEPS,v,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_GS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end

MatrixResults_FR(alg,:) = [D_lambda_GS,D_S_GS,QNRI_GS,SAM_GS,sCC_GS,time_GS];

%% GSA
alg=alg+1;
cd GS
t2=tic;
I_GSA = GSA(I_MS,I_PAN,I_MS_LR,ratio);
time_GSA = toc(t2);
fprintf('Elaboration time GSA: %.2f [sec]\n',time_GSA);
cd ..

% if cut_outliers
%     I_GSA(I_GSA > 2^L) = 2^L;
%     I_GSA(I_GSA < 0) = 0;
% end

% [D_lambda_GSA,D_S_GSA,QNRI_GSA,SAM_GSA,sCC_GSA] = indexes_evaluation_FS(I_GSA,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_GSA,D_S_GSA,QNRI_GSA,SAM_GSA,sCC_GSA] = indexes_evaluation_FS_HQNR(I_GSA,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='GSA';
if show_results
    if size(I_GSA,3) == 4
        showImage4(I_GSA,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_GSA,3) == 8
        showImage8(I_GSA,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_GSA,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end

MatrixResults_FR(alg,:) = [D_lambda_GSA,D_S_GSA,QNRI_GSA,SAM_GSA,sCC_GSA,time_GSA];

%% PRACS
alg=alg+1;
cd PRACS
t2=tic;
I_PRACS = PRACS(I_MS,I_PAN,ratio);
time_PRACS = toc(t2);
fprintf('Elaboration time PRACS: %.2f [sec]\n',time_PRACS);
cd ..

% if cut_outliers
%     I_PRACS(I_PRACS > 2^L) = 2^L;
%     I_PRACS(I_PRACS < 0) = 0;
% end

% [D_lambda_PRACS,D_S_PRACS,QNRI_PRACS,SAM_PRACS,sCC_PRACS] = indexes_evaluation_FS(I_PRACS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_PRACS,D_S_PRACS,QNRI_PRACS,SAM_PRACS,sCC_PRACS] = indexes_evaluation_FS_HQNR(I_PRACS,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='PRACS';
if show_results
    if size(I_PRACS,3) == 4
        showImage4(I_PRACS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_PRACS,3) == 8
        showImage8(I_PRACS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_PRACS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end

MatrixResults_FR(alg,:) = [D_lambda_PRACS,D_S_PRACS,QNRI_PRACS,SAM_PRACS,sCC_PRACS,time_PRACS];


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MultiResolution Analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% HPF
alg=alg+1;
cd HPF
t2=tic;
I_HPF = HPF(I_MS,I_PAN,ratio);
time_HPF = toc(t2);
fprintf('Elaboration time HPF: %.2f [sec]\n',time_HPF);
cd ..

% if cut_outliers
%     I_HPF(I_HPF > 2^L) = 2^L;
%     I_HPF(I_HPF < 0) = 0;
% end

% [D_lambda_HPF,D_S_HPF,QNRI_HPF,SAM_HPF,sCC_HPF] = indexes_evaluation_FS(I_HPF,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_HPF,D_S_HPF,QNRI_HPF,SAM_HPF,sCC_HPF] = indexes_evaluation_FS_HQNR(I_HPF,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='HPF';
if show_results
    if size(I_HPF,3) == 4
        showImage4(I_HPF,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_HPF,3) == 8
        showImage8(I_HPF,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_HPF,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end

MatrixResults_FR(alg,:) = [D_lambda_HPF,D_S_HPF,QNRI_HPF,SAM_HPF,sCC_HPF,time_HPF];

%% SFIM
alg=alg+1;
cd SFIM
t2=tic;
I_SFIM = SFIM(I_MS,I_PAN,ratio);
%       I_SFIM = SFIM_mod(I_MS,I_PAN,ratio);
time_SFIM = toc(t2);
fprintf('Elaboration time SFIM: %.2f [sec]\n',time_SFIM);
cd ..

% if cut_outliers
%     I_SFIM(I_SFIM > 2^L) = 2^L;
%     I_SFIM(I_SFIM < 0) = 0;
% end

% [D_lambda_SFIM,D_S_SFIM,QNRI_SFIM,SAM_SFIM,sCC_SFIM] = indexes_evaluation_FS(I_SFIM,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_SFIM,D_S_SFIM,QNRI_SFIM,SAM_SFIM,sCC_SFIM] = indexes_evaluation_FS_HQNR(I_SFIM,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='SFIM';
if show_results
    if size(I_SFIM,3) == 4
        showImage4(I_SFIM,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_SFIM,3) == 8
        showImage8(I_SFIM,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_SFIM,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults_FR(alg,:) = [D_lambda_SFIM,D_S_SFIM,QNRI_SFIM,SAM_SFIM,sCC_SFIM,time_SFIM];

%% %% Indusion
alg=alg+1;
cd Indusion
t2=tic;
I_Indusion = Indusion(I_PAN,I_MS_LR,ratio);
%   I_Indusion = Indusion_mod(I_PAN,I_MS_LR,ratio);
time_Indusion = toc(t2);
fprintf('Elaboration time Indusion: %.2f [sec]\n',time_Indusion);
cd ..

% if cut_outliers
%     I_Indusion(I_Indusion > 2^L) = 2^L;
%     I_Indusion(I_Indusion < 0) = 0;
% end

% [D_lambda_Indusion,D_S_Indusion,QNRI_Indusion,SAM_Indusion,sCC_Indusion] = indexes_evaluation_FS(I_Indusion,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_Indusion,D_S_Indusion,QNRI_Indusion,SAM_Indusion,sCC_Indusion] = indexes_evaluation_FS_HQNR(I_Indusion,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='Indusion';
if show_results
if size(I_Indusion,3) == 4
    showImage4(I_Indusion,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
elseif size(I_Indusion,3) == 8
    showImage8(I_Indusion,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
else
    showImageHS(I_Indusion,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
end
text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults_FR(alg,:) = [D_lambda_Indusion,D_S_Indusion,QNRI_Indusion,SAM_Indusion,sCC_Indusion,time_Indusion];

%% ATWT
alg=alg+1;
cd Wavelet
t2=tic;
I_ATWT = ATWT(I_MS,I_PAN,ratio);
time_ATWT = toc(t2);
fprintf('Elaboration time ATWT: %.2f [sec]\n',time_ATWT);
cd ..

% if cut_outliers
%     I_ATWT(I_ATWT > 2^L) = 2^L;
%     I_ATWT(I_ATWT < 0) = 0;
% end

% [D_lambda_ATWT,D_S_ATWT,QNRI_ATWT,SAM_ATWT,sCC_ATWT] = indexes_evaluation_FS(I_ATWT,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_ATWT,D_S_ATWT,QNRI_ATWT,SAM_ATWT,sCC_ATWT] = indexes_evaluation_FS_HQNR(I_ATWT,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='ATWT';
if show_results
    if size(I_ATWT,3) == 4
        showImage4(I_ATWT,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_ATWT,3) == 8
        showImage8(I_ATWT,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_ATWT,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults_FR(alg,:) = [D_lambda_ATWT,D_S_ATWT,QNRI_ATWT,SAM_ATWT,sCC_ATWT,time_ATWT];

%% AWLP
alg=alg+1;
cd Wavelet
t2=tic;
I_AWLP = AWLP(I_MS,I_PAN,ratio);
time_AWLP = toc(t2);
fprintf('Elaboration time AWLP: %.2f [sec]\n',time_AWLP);
cd ..

% if cut_outliers
%     I_AWLP(I_AWLP > 2^L) = 2^L;
%     I_AWLP(I_AWLP < 0) = 0;
% end

% [D_lambda_AWLP,D_S_AWLP,QNRI_AWLP,SAM_AWLP,sCC_AWLP] = indexes_evaluation_FS(I_AWLP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_AWLP,D_S_AWLP,QNRI_AWLP,SAM_AWLP,sCC_AWLP] = indexes_evaluation_FS_HQNR(I_AWLP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='AWLP';
if show_results
    if size(I_AWLP,3) == 4
        showImage4(I_AWLP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_AWLP,3) == 8
        showImage8(I_AWLP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_AWLP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults_FR(alg,:) = [D_lambda_AWLP,D_S_AWLP,QNRI_AWLP,SAM_AWLP,sCC_AWLP,time_AWLP];

%% ATWT-M2
alg=alg+1;
cd Wavelet
t2=tic;
I_ATWTM2 = ATWT_M2(I_MS,I_PAN,ratio);
time_ATWTM2 = toc(t2);
fprintf('Elaboration time ATWT-M2: %.2f [sec]\n',time_ATWTM2);
cd ..

% if cut_outliers
%     I_ATWTM2(I_ATWTM2 > 2^L) = 2^L;
%     I_ATWTM2(I_ATWTM2 < 0) = 0;
% end

% [D_lambda_ATWTM2,D_S_ATWTM2,QNRI_ATWTM2,SAM_ATWTM2,sCC_ATWTM2] = indexes_evaluation_FS(I_ATWTM2,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_ATWTM2,D_S_ATWTM2,QNRI_ATWTM2,SAM_ATWTM2,sCC_ATWTM2] = indexes_evaluation_FS_HQNR(I_ATWTM2,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='ATWT-M2';
if show_results
    if size(I_ATWTM2,3) == 4
        showImage4(I_ATWTM2,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_ATWTM2,3) == 8
        showImage8(I_ATWTM2,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_ATWTM2,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults_FR(alg,:) = [D_lambda_ATWTM2,D_S_ATWTM2,QNRI_ATWTM2,SAM_ATWTM2,sCC_ATWTM2,time_ATWTM2];

%% ATWT-M3
alg=alg+1;
cd Wavelet
t2=tic;
I_ATWTM3 = ATWT_M3(I_MS,I_PAN,ratio);
time_ATWTM3 = toc(t2);
fprintf('Elaboration time ATWT-M3: %.2f [sec]\n',time_ATWTM3);
cd ..

% if cut_outliers
%     I_ATWTM3(I_ATWTM3 > 2^L) = 2^L;
%     I_ATWTM3(I_ATWTM3 < 0) = 0;
% end

% [D_lambda_ATWTM3,D_S_ATWTM3,QNRI_ATWTM3,SAM_ATWTM3,sCC_ATWTM3] = indexes_evaluation_FS(I_ATWTM3,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_ATWTM3,D_S_ATWTM3,QNRI_ATWTM3,SAM_ATWTM3,sCC_ATWTM3] = indexes_evaluation_FS_HQNR(I_ATWTM3,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='ATWT-M3';
if show_results
    if size(I_ATWTM3,3) == 4
        showImage4(I_ATWTM3,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_ATWTM3,3) == 8
        showImage8(I_ATWTM3,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_ATWTM3,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults_FR(alg,:) = [D_lambda_ATWTM3,D_S_ATWTM3,QNRI_ATWTM3,SAM_ATWTM3,sCC_ATWTM3,time_ATWTM3];

%% MTF-GLP
alg=alg+1;
cd GLP
t2=tic;
I_MTF_GLP = MTF_GLP(I_PAN,I_MS,sensor,tag,ratio);
time_MTF_GLP = toc(t2);
fprintf('Elaboration time MTF-GLP: %.2f [sec]\n',time_MTF_GLP);
cd ..

% if cut_outliers
%     I_MTF_GLP(I_MTF_GLP > 2^L) = 2^L;
%     I_MTF_GLP(I_MTF_GLP < 0) = 0;
% end

% [D_lambda_MTF_GLP,D_S_MTF_GLP,QNRI_MTF_GLP,SAM_MTF_GLP,sCC_MTF_GLP] = indexes_evaluation_FS(I_MTF_GLP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_MTF_GLP,D_S_MTF_GLP,QNRI_MTF_GLP,SAM_MTF_GLP,sCC_MTF_GLP] = indexes_evaluation_FS_HQNR(I_MTF_GLP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='GLP-HPF';
if show_results
    if size(I_MTF_GLP,3) == 4
        showImage4(I_MTF_GLP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_MTF_GLP,3) == 8
        showImage8(I_MTF_GLP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_MTF_GLP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults_FR(alg,:) = [D_lambda_MTF_GLP,D_S_MTF_GLP,QNRI_MTF_GLP,SAM_MTF_GLP,sCC_MTF_GLP,time_MTF_GLP];

%% MTF-GLP-HPM
alg=alg+1;
cd GLP
t2=tic;
I_MTF_GLP_HPM = MTF_GLP_HPM(I_PAN,I_MS,sensor,tag,ratio);
time_MTF_GLP_HPM = toc(t2);
fprintf('Elaboration time MTF-GLP-HPM: %.2f [sec]\n',time_MTF_GLP_HPM);
cd ..

% if cut_outliers
%     I_MTF_GLP_HPM(I_MTF_GLP_HPM > 2^L) = 2^L;
%     I_MTF_GLP_HPM(I_MTF_GLP_HPM < 0) = 0;
% end

% [D_lambda_MTF_GLP_HPM,D_S_MTF_GLP_HPM,QNRI_MTF_GLP_HPM,SAM_MTF_GLP_HPM,sCC_MTF_GLP_HPM] = indexes_evaluation_FS(I_MTF_GLP_HPM,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_MTF_GLP_HPM,D_S_MTF_GLP_HPM,QNRI_MTF_GLP_HPM,SAM_MTF_GLP_HPM,sCC_MTF_GLP_HPM] = indexes_evaluation_FS_HQNR(I_MTF_GLP_HPM,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='GLP-HPM';
if show_results
    if size(I_MTF_GLP_HPM,3) == 4
        showImage4(I_MTF_GLP_HPM,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_MTF_GLP_HPM,3) == 8
        showImage8(I_MTF_GLP_HPM,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_MTF_GLP_HPM,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults_FR(alg,:) = [D_lambda_MTF_GLP_HPM,D_S_MTF_GLP_HPM,QNRI_MTF_GLP_HPM,SAM_MTF_GLP_HPM,sCC_MTF_GLP_HPM,time_MTF_GLP_HPM];

%% %% MTF-GLP-HPM-PP
% alg=alg+1;
% I_MTF_GLP_HPM_PP = I_MS;
% cd GLP
% t2=tic;
% for ig=1:numel(Groups)
%     HS_BS = cell2mat(Groups(ig));
% if ~isempty(HS_BS)
%     I_MS_g = I_MS(:,:,HS_BS);
%     I_MS_LR_g = I_MS_LR(:,:,HS_BS);
%     I_PAN_g = squeeze(I_PAN(:,:,ig));
% %     I_MTF_GLP_HPM(:,:,HS_BS) = MTF_GLP_HPM(I_PAN_g,I_MS_g,sensor,tag,ratio);
%     I_MTF_GLP_HPM_PP(:,:,HS_BS) = MTF_GLP_HPM_PP(I_PAN_g,I_MS_LR_g,sensor,tag,ratio);
%
% end
% end
%
% time_MTF_GLP_HPM_PP = toc(t2);
% fprintf('Elaboration time MTF-GLP-HPM-PP: %.2f [sec]\n',time_MTF_GLP_HPM_PP);
% cd ..
%
% % if cut_outliers
% %     I_MTF_GLP_HPM_PP(I_MTF_GLP_HPM_PP > 2^L) = 2^L;
% %     I_MTF_GLP_HPM_PP(I_MTF_GLP_HPM_PP < 0) = 0;
% % end
%
% % [D_lambda_MTF_GLP_HPM_PP,D_S_MTF_GLP_HPM_PP,QNRI_MTF_GLP_HPM_PP,SAM_MTF_GLP_HPM_PP,sCC_MTF_GLP_HPM_PP] = indexes_evaluation_FS(I_MTF_GLP_HPM_PP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
% [D_lambda_MTF_GLP_HPM_PP,D_S_MTF_GLP_HPM_PP,QNRI_MTF_GLP_HPM_PP,SAM_MTF_GLP_HPM_PP,sCC_MTF_GLP_HPM_PP] = indexes_evaluation_FS_HQNR(I_MTF_GLP_HPM_PP,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);
%
% titleImages{alg}='GLP-HPM-PP';
% if show_results
%     if size(I_MTF_GLP_HPM_PP,3) == 4
%         showImage4(I_MTF_GLP_HPM_PP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
%     elseif size(I_MTF_GLP_HPM_PP,3) == 8
%         showImage8(I_MTF_GLP_HPM_PP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
%     else
%         showImageHS(I_MTF_GLP_HPM_PP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
%     end
%     text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
% end
% MatrixResults_FR(alg,:) = [D_lambda_MTF_GLP_HPM_PP,D_S_MTF_GLP_HPM_PP,QNRI_MTF_GLP_HPM_PP,SAM_MTF_GLP_HPM_PP,sCC_MTF_GLP_HPM_PP,time_MTF_GLP_HPM_PP];

%% MTF-GLP-CBD
alg=alg+1;
cd GS
t2=tic;
I_MTF_GLP_CBD = GS2_GLP(I_MS,I_PAN,ratio,sensor,tag);
time_MTF_GLP_CBD = toc(t2);
fprintf('Elaboration time MTF-GLP-CBD: %.2f [sec]\n',time_MTF_GLP_CBD);
cd ..

% if cut_outliers
%     I_MTF_GLP_CBD(I_MTF_GLP_CBD > 2^L) = 2^L;
%     I_MTF_GLP_CBD(I_MTF_GLP_CBD < 0) = 0;
% end
% [D_lambda_MTF_GLP_CBD,D_S_MTF_GLP_CBD,QNRI_MTF_GLP_CBD,SAM_MTF_GLP_CBD,sCC_MTF_GLP_CBD] = indexes_evaluation_FS(I_MTF_GLP_CBD,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,);
[D_lambda_MTF_GLP_CBD,D_S_MTF_GLP_CBD,QNRI_MTF_GLP_CBD,SAM_MTF_GLP_CBD,sCC_MTF_GLP_CBD] = indexes_evaluation_FS_HQNR(I_MTF_GLP_CBD,I_MS_LR,I_PAN,L,thvalues,I_MS,sensor,tag,sensor,tag,ratio,Qblocks_size);

titleImages{alg}='GLP-CBD';
if show_results
    if size(I_MTF_GLP_CBD,3) == 4
        showImage4(I_MTF_GLP_CBD,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_MTF_GLP_CBD,3) == 8
        showImage8(I_MTF_GLP_CBD,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_MTF_GLP_CBD,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults_FR(alg,:) = [D_lambda_MTF_GLP_CBD,D_S_MTF_GLP_CBD,QNRI_MTF_GLP_CBD,SAM_MTF_GLP_CBD,sCC_MTF_GLP_CBD,time_MTF_GLP_CBD];

