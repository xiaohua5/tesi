%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% MAIN: FULL RESOLUTION VALIDATION  %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clc;
% clear all;
% close all;

addpath([cd,'\PS_Tools'])
addpath([cd,'\Quality_Indices'])
addpath([cd,'\..\Datasets'])
%% Show Final Products
show_results = 0;

%% Analyzed image choice (select one of the two datasets below)

%%%%%%% Toulose Dataset
im_tag = 'Toulouse';
sensor = 'IKONOS';

% %%%%%%% Rio Dataset
% im_tag = 'WV2';
% sensor = 'WV2';

%% Quality Index Blocks
Qblocks_size = 32;

%% Cut Final Image
flag_cut_bounds = 1;
dim_cut = 11;

%% Threshold values out of dynamic range
thvalues = 0;

%% Print Eps
printEPS = 0;

%% Resize factor
ratio = 4;

%% Radiometric Resolution
L = 11;

%% %%%%%%%%%%%%%%%%%%%%%%%% Dataset load %%%%%%%%%%%%%%%%%%%%%%%%%%
switch im_tag
    case 'Toulouse'
        load('Datasets/Toulouse_FR.mat');
    case 'WV2'
        load('Datasets/Rio_FR.mat');
end