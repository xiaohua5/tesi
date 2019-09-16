%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  RUN AND REDUCED RESOLUTION VALIDATION  %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization of the Matrix of Results
NumAlgs = 0;
NumIndexes = 6;
MatrixResults = zeros(NumAlgs,NumIndexes);
Xmap=3; Ymap=3;
alg = 0;
titleImages={};
Toolbox_Directory = cd;
addpath([Toolbox_Directory,'\PS_Tools'])
addpath([Toolbox_Directory,'\Quality_Indices'])
if ~exist('show_results')
    show_results = 0;
end
if ~exist('tag_interp')
    tag_interp = 'o_o';
end
if ~exist('tag')
    tag=[];
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Base Images
cd(Toolbox_Directory)

Fusion_Algorithms_Base_Reduced_Resolution

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Classical
cd(Toolbox_Directory)

Fusion_Algorithms_Classical_Reduced_Resolution

%% Print in LATEX

matrix2latex(MatrixResults,'Real_Dataset.tex', 'rowLabels',titleImages,'columnLabels',[{'Q2n'},{'Q'},{'SAM'},{'ERGAS'},{'SCC'},{'Time'}],'alignment','c','format', '%.4f');

