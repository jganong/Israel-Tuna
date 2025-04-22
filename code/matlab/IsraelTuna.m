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

fdir = '/Users/cpagniello/Library/CloudStorage/GoogleDrive-cpagniel@stanford.edu/Shared drives/ABFT Med Eyal';

%% Load Data

run load_meta_IL
run load_SSM_IL
run load_archive_IL

run load_tseries_IL

%% Set timezone of SSM.

SSM.Date.TimeZone = 'UTC';

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