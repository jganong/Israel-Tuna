addpath  ~/Israel-Tuna-jeg/code/matlab
dbstop if error;
%dbstop IsraelTuna.m  74

 cd  /home/jeg/Israel-Tuna-jeg/code/matlab
    
    %% Israel Tuna %%
% The following runs code to process, analyze and plot data related to
% tag deployments on tuna from Israel and beyond in the Med.
%
%
% Author: Camille Pagniello, University of Hawai'i at Manoa (cpagniel@hawaii.edu)
%
% Last Update: 03/06/2024

%% Requirements

warning off


%% Load Data

workspace_file = 'workspace_04212025_FINAL.mat';

% camille already ran this and saved the dataset,
% so we can just load it, and skip running the load_* functions

if exist(workspace_file)
    load('workspace_04212025_FINAL.mat')
else
    toppdir = '/TOPP';
    fdir = '/home/jeg/Israel-Tuna-jeg';

    if not(exist([toppdir '/Tuna']))
        error(['to regen ', workspace_file, ' you need /TOPP to be mounted'])
    end

    % the above workspace file defines a value in fdir
    % that only makes sense on camille's computer,
    % so we redefine it to make sense in this git repo.
    addpath([ fdir '/code/matlab/subfunctions' ]);
    % camille uses a function called 'gsw_t_interp'
    % so i downloaded https://www.teos-10.org/software/gsw_matlab_v3_06_16.zip
    % i made a folder in fdir/matlab called gsw
    % and unzipped the downlod there
    gswdir =     [fdir '/lib/gsw'];
    gswlibdir =     [fdir '/lib/gsw/library'];
    sunrisedir = [fdir '/lib/sunrise-master'];
    addpath(gswdir)
    addpath(gswlibdir)
    addpath(sunrisedir)
    % camille's calculate_MLD_IL script
    % uses a function called mld()
    % that is provided by Climate Data Toolbox
    % so i downloaded it from:https://github.com/chadagreene/CDT
    % then i made a directory in fdir/code called cdt
    % and upzipped it there
    cdtdir = [ fdir '/lib/cdt/CDT-master/cdt'];
    addpath(cdtdir)

    run load_meta_IL.m

    CENSUS=META;
    CENSUS.SSM_FILE(:)="";
    CENSUS.SSM_RAW(:)=nan;
    CENSUS.SSM_TRIMMED(:)=nan;
    CENSUS.PSAT_RAW(:)=nan;
    CENSUS.PSAT_TRIMMED(:)=nan;
    CENSUS.PSAT_FILE(:)="";
    CENSUS.TSERIES_RAW(:)=nan;
    CENSUS.TSERIES_TRIMMED(:)=nan;
    CENSUS.TSERIES_FILE(:)="";



    
    run load_SSM_IL

    run load_tseries_IL

    run load_archive_IL

    %% Set timezone of SSM.

    SSM.Date.TimeZone = 'UTC';

writetable(CENSUS,'census.csv')

    save(workspace_file)

    %% Data Analysis





    run calculate_MLD_IL
    run stats_MLD_IL

    run detect_dives_IL_v2
    run daily_dive_stats_IL_v2

    %% Figures

    % Figure 1
    run plot_overview_map_IL
    run plot_Med_map_IL
    run plot_Med_bin_map_IL

    % Figure 2
    run plot_horizontal_speed_map_IL

    run plot_daily_dive_frequency_map_IL
    run plot_dive_duration_map_IL
    run plot_dive_descent_rate_map_IL

    run plot_median_daynight_depth_map_IL

    run load_minmax_IL
    run plot_daily_max_depth_map_IL

    run plot_time_in_mesopelagic_map_IL

    % Figures 3
    run plot_individual_tracks_Med_with_regions_IL
    run plot_timeseries_IL

    % Figure 4 & S4
    run plot_seasonal_habitat_envelopes_IL

    %% Supplementary Figures

    % Figure S1
    run plot_seasonal_map_IL

    % Figure S2
    run plot_individual_tracks_IL
    run plot_individual_tracks_Med_IL

    % Figure S3
    run plot_transmitted_timeseries_IL

    % Figure S5
    run plot_TaD_IL

    % Figure S6
    run plot_TaT_IL

    % Figure S7 and S8
    run plot_boxplots_hotspots_IL

    %% Supplementary Tables

    run calculate_time_in_Med_regions_IL
    run calculate_dive_stats_IL

    save(workspace_file)

end
