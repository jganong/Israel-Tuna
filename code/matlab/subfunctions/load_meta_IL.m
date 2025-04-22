%% load_meta_IL.m
% Sub-function of IsraelTuna.m; loads metadata for all tags.

%% Go To Folder

cd([fdir '/data/meta']);

%% Load MetaData

META = readtable("med_paper_metadata_2025mar7-edit.csv");

%% Create toppID 

META.toppID = roundn(META.eventid/100,0);
META = movevars(META, 'toppID', 'Before', 'eventid');