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
[Q_avg_PCA, SAM_PCA, ERGAS_PCA, SCC_GT_PCA, Q_PCA] = indexes_evaluation(I_PCA,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

titleImages{alg}='PCA';
if show_results
    if size(I_PCA,3) == 4
        showImage4(I_PCA,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_MS_LR,3) == 8
        showImage8(I_PCA,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_PCA,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end

MatrixResults(alg,:) = [Q_PCA,Q_avg_PCA,SAM_PCA,ERGAS_PCA,SCC_GT_PCA,time_PCA];

%% IHS
alg = alg+1;

cd IHS
t2=tic;

I_IHS = IHS(I_MS,I_PAN);
%     I_IHS = IHS_mod(I_MS,I_PAN,ratio);
time_IHS=toc(t2);
fprintf('Elaboration time IHS: %.2f [sec]\n',time_IHS);
cd ..
% if cut_outliers
%     I_IHS(I_IHS > 2^L) = 2^L;
%     I_IHS(I_IHS < 0) = 0;
% end

[Q_avg_IHS, SAM_IHS, ERGAS_IHS, SCC_GT_IHS, Q_IHS] = indexes_evaluation(I_IHS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

titleImages{alg}='IHS';
if show_results
    if size(I_IHS,3) == 4
        showImage4(I_IHS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_MS_LR,3) == 8
        showImage8(I_IHS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_IHS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults(alg,:) = [Q_IHS,Q_avg_IHS,SAM_IHS,ERGAS_IHS,SCC_GT_IHS,time_IHS];

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

[Q_avg_Brovey, SAM_Brovey, ERGAS_Brovey, SCC_GT_Brovey, Q_Brovey] = indexes_evaluation(I_Brovey,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

titleImages{alg}='BT';
if show_results
    if size(I_Brovey,3) == 4
        showImage4(I_Brovey,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_MS_LR,3) == 8
        showImage8(I_Brovey,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_Brovey,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults(alg,:) = [Q_Brovey,Q_avg_Brovey,SAM_Brovey,ERGAS_Brovey,SCC_GT_Brovey,time_Brovey];

%% BDSD
alg = alg+1;
I_BDSD = I_MS;

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
[Q_avg_BDSD, SAM_BDSD, ERGAS_BDSD, SCC_GT_BDSD, Q_BDSD] = indexes_evaluation(I_BDSD,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_BDSD,Q_avg_BDSD,SAM_BDSD,ERGAS_BDSD,SCC_GT_BDSD,time_BDSD];

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

[Q_avg_GS, SAM_GS, ERGAS_GS, SCC_GT_GS, Q_GS] = indexes_evaluation(I_GS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

titleImages{alg}='GS';
if show_results
    if size(I_GS,3) == 4
        showImage4(I_GS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_GS,3) == 8
        showImage8(I_GS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_GS,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults(alg,:) = [Q_GS,Q_avg_GS,SAM_GS,ERGAS_GS,SCC_GT_GS,time_GS];

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

[Q_avg_GSA, SAM_GSA, ERGAS_GSA, SCC_GT_GSA, Q_GSA] = indexes_evaluation(I_GSA,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_GSA,Q_avg_GSA,SAM_GSA,ERGAS_GSA,SCC_GT_GSA,time_GSA];

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

[Q_avg_PRACS, SAM_PRACS, ERGAS_PRACS, SCC_GT_PRACS, Q_PRACS] = indexes_evaluation(I_PRACS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_PRACS,Q_avg_PRACS,SAM_PRACS,ERGAS_PRACS,SCC_GT_PRACS,time_PRACS];


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

[Q_avg_HPF, SAM_HPF, ERGAS_HPF, SCC_GT_HPF, Q_HPF] = indexes_evaluation(I_HPF,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_HPF,Q_avg_HPF,SAM_HPF,ERGAS_HPF,SCC_GT_HPF,time_HPF];

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

[Q_avg_SFIM, SAM_SFIM, ERGAS_SFIM, SCC_GT_SFIM, Q_SFIM] = indexes_evaluation(I_SFIM,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_SFIM,Q_avg_SFIM,SAM_SFIM,ERGAS_SFIM,SCC_GT_SFIM,time_SFIM];

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

[Q_avg_Indusion, SAM_Indusion, ERGAS_Indusion, SCC_GT_Indusion, Q_Indusion] = indexes_evaluation(I_Indusion,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_Indusion,Q_avg_Indusion,SAM_Indusion,ERGAS_Indusion,SCC_GT_Indusion,time_Indusion];
%
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

[Q_avg_ATWT, SAM_ATWT, ERGAS_ATWT, SCC_GT_ATWT, Q_ATWT] = indexes_evaluation(I_ATWT,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_ATWT,Q_avg_ATWT,SAM_ATWT,ERGAS_ATWT,SCC_GT_ATWT,time_ATWT];

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

[Q_avg_AWLP, SAM_AWLP, ERGAS_AWLP, SCC_GT_AWLP, Q_AWLP] = indexes_evaluation(I_AWLP,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_AWLP,Q_avg_AWLP,SAM_AWLP,ERGAS_AWLP,SCC_GT_AWLP,time_AWLP];

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

[Q_avg_ATWTM2, SAM_ATWTM2, ERGAS_ATWTM2, SCC_GT_ATWTM2, Q_ATWTM2] = indexes_evaluation(I_ATWTM2,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_ATWTM2,Q_avg_ATWTM2,SAM_ATWTM2,ERGAS_ATWTM2,SCC_GT_ATWTM2,time_ATWTM2];

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

[Q_avg_ATWTM3, SAM_ATWTM3, ERGAS_ATWTM3, SCC_GT_ATWTM3, Q_ATWTM3] = indexes_evaluation(I_ATWTM3,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_ATWTM3,Q_avg_ATWTM3,SAM_ATWTM3,ERGAS_ATWTM3,SCC_GT_ATWTM3,time_ATWTM3];

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

[Q_avg_MTF_GLP, SAM_MTF_GLP, ERGAS_MTF_GLP, SCC_GT_MTF_GLP, Q_MTF_GLP] = indexes_evaluation(I_MTF_GLP,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_MTF_GLP,Q_avg_MTF_GLP,SAM_MTF_GLP,ERGAS_MTF_GLP,SCC_GT_MTF_GLP,time_MTF_GLP];

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

[Q_avg_MTF_GLP_HPM, SAM_MTF_GLP_HPM, ERGAS_MTF_GLP_HPM, SCC_GT_MTF_GLP_HPM, Q_MTF_GLP_HPM] = indexes_evaluation(I_MTF_GLP_HPM,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_MTF_GLP_HPM,Q_avg_MTF_GLP_HPM,SAM_MTF_GLP_HPM,ERGAS_MTF_GLP_HPM,SCC_GT_MTF_GLP_HPM,time_MTF_GLP_HPM];

%% %% MTF-GLP-HPM-PP
alg=alg+1;
I_MTF_GLP_HPM_PP = I_MS;
cd GLP
t2=tic;

I_MTF_GLP_HPM_PP = MTF_GLP_HPM_PP(I_PAN,I_MS_LR,sensor,tag,ratio);

time_MTF_GLP_HPM_PP = toc(t2);
fprintf('Elaboration time MTF-GLP-HPM-HPM: %.2f [sec]\n',time_MTF_GLP_HPM_PP);
cd ..

% if cut_outliers
%     I_MTF_GLP_HPM_PP(I_MTF_GLP_HPM_PP > 2^L) = 2^L;
%     I_MTF_GLP_HPM_PP(I_MTF_GLP_HPM_PP < 0) = 0;
% end

[Q_avg_MTF_GLP_HPM_PP, SAM_MTF_GLP_HPM_PP, ERGAS_MTF_GLP_HPM_PP, SCC_GT_MTF_GLP_HPM_PP, Q_MTF_GLP_HPM_PP] = indexes_evaluation(I_MTF_GLP_HPM_PP,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

titleImages{alg}='GLP-HPM-PP';
if show_results
    if size(I_MTF_GLP_HPM_PP,3) == 4
        showImage4(I_MTF_GLP_HPM_PP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    elseif size(I_MTF_GLP_HPM_PP,3) == 8
        showImage8(I_MTF_GLP_HPM_PP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L);
    else
        showImageHS(I_MTF_GLP_HPM_PP,printEPS,alg,flag_cut_bounds,dim_cut,thvalues,L,bands_to_display);
    end
    text(Xmap,Ymap,titleImages{alg},'EdgeColor','k','BackgroundColor','w');
end
MatrixResults(alg,:) = [Q_MTF_GLP_HPM_PP,Q_avg_MTF_GLP_HPM_PP,SAM_MTF_GLP_HPM_PP,ERGAS_MTF_GLP_HPM_PP,SCC_GT_MTF_GLP_HPM_PP,time_MTF_GLP_HPM_PP];

%% MTF-GLP-CBD
alg=alg+1;
I_MTF_GLP_CBD = I_MS;
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
[Q_avg_MTF_GLP_CBD, SAM_MTF_GLP_CBD, ERGAS_MTF_GLP_CBD, SCC_GT_MTF_GLP_CBD, Q_MTF_GLP_CBD] = indexes_evaluation(I_MTF_GLP_CBD,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

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
MatrixResults(alg,:) = [Q_MTF_GLP_CBD,Q_avg_MTF_GLP_CBD,SAM_MTF_GLP_CBD,ERGAS_MTF_GLP_CBD,SCC_GT_MTF_GLP_CBD,time_MTF_GLP_CBD];

