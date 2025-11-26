%% load_meta_IL.m
% Sub-function of IsraelTuna.m; loads metadata for all tags.

%% Go To Folder

cd(fdir);

%% Load MetaData

META = readtable("turkey_metadata_2025july15.csv");

% Sone datasets, eg Turkey Tuna, do not yet have manual_cut_date so use a harmless default
if (~ismember('manual_cut_date',fieldnames(META)))
    META.manual_cut_date(:) = datetime("inf");
end

% sometimes META has all NaN for date_last_lon, which gives horizcat() fits
% in this case set it to a date that is harmless in the context of min()
if (all(isnan(META.date_last_lon)))
    %META.date_last_lon=[];
    META.date_last_lon = repmat(datetime('inf'), height(META), 1);
end

%% Create toppID 

META.toppID = roundn(META.eventid/100,0);
META = movevars(META, 'toppID', 'Before', 'eventid');
