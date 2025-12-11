%% plot_daily_dive_frequency_map_IL.m
% Sub-function of IsraelTuna.m; plots mean maximum daily dive depth in 
% 1 x 1 degree bins.

%% Create figure and axes for bathymetry. 

figure('Position',[476 334 716 532]);

%% Set projection of map.

LATLIMS = [30 46]; LONLIMS = [-5.61 40];
m_proj('miller','lon',LONLIMS,'lat',LATLIMS);

%% Compute median of daily dive frequency in each bin.

binned.LONedges = -6:1:40;
binned.LATedges = 30:1:46;
LONmid = diff(binned.LONedges)/2 + binned.LONedges(1);
LATmid = diff(binned.LATedges)/2 + binned.LATedges(1);

[binned] = twodmed(SSM.Longitude,SSM.Latitude,...
        SSM.DivesPerDay,binned.LONedges,binned.LATedges);
bins.daily_dive_f = binned.mz.';

m_pcolor(LONmid-0.5,LATmid-0.5,binned.mz);

hold on

%% Plot land.

m_coast('patch',[.7 .7 .7]);

hold on

%% Plot patch.

m_patch([-5.61 5 -5.61 -5.61],[40 46 46 40],'w');
m_patch([23.75 40 40 23.75 23.75],[41.5 41.5 46 46 41.5],'w');
clear p

%% Plot hotspots

m_plot(regions.Alboran(:,1),regions.Alboran(:,2),':','LineWidth',4,'Color',cmap.regions(2,:))
m_plot(regions.WesternMed(:,1),regions.WesternMed(:,2),':','LineWidth',4,'Color',cmap.regions(3,:))
m_plot(regions.Adriatic(:,1),regions.Adriatic(:,2),':','LineWidth',4,'Color',cmap.regions(4,:))
m_plot(regions.Ionian(:,1),regions.Ionian(:,2),':','LineWidth',4,'Color',cmap.regions(5,:))
m_plot(regions.Tunisian(:,1),regions.Tunisian(:,2),':','LineWidth',4,'Color',cmap.regions(6,:))
m_plot(regions.Aegean(:,1),regions.Aegean(:,2),':','LineWidth',4,'Color',cmap.regions(7,:))
m_plot(regions.Levantine(:,1),regions.Levantine(:,2),':','LineWidth',4,'Color',cmap.regions(8,:))

%% Create figure border.

m_grid('linewi',2,'tickdir','in','linest','none','fontsize',18);

%% Add north arrow and scale bar.

m_northarrow(-3.9,43.6,2,'type',2,'linewi',2);
m_ruler([.04 .24],.125,2,'fontsize',16,'ticklength',0.01);

patch([0.25 0.33 0.33 0.25],[0.7 0.7 0.733 0.733],'w');
m_text(32, 39, ['n = ' num2str(length(unique(SSM.TOPPID(~isnan(SSM.DivesPerDay)))))], 'FontSize', 20);

%% Add colorbar

h = colorbar('FontSize',14,'Location','southoutside');  

% for getPyPlot_cMap,
% install python3's matplotlib  see notes.jeg file
% also make sure "python" runs python3.
% i did it like this:
% sudo apt install python-is-python3
% 
% this still gets the following error (and how to fix it)
%
% Error using getPyPlot_cMap (line 122)
% There was an error executing the command
% 	python
%     "/home/jeg/Israel-Tuna-jeg/lib/PyColormap4Matlab/pyplotCMap2txt.py"
%     YlGnBu -o "/tmp/tp6c513512_bee0_4f4b_9ae1_3a216c201e57" -n 12
% System returned:
% 	Traceback (most recent call last):
%   File
%   "/home/jeg/Israel-Tuna-jeg/lib/PyColormap4Matlab/pyplotCMap2txt.py",
%   line 5, in <module>
%     import matplotlib.pyplot as plt
%   File "/usr/lib/python3/dist-packages/matplotlib/__init__.py", line
%   214, in <module>
%     _check_versions()
%   File "/usr/lib/python3/dist-packages/matplotlib/__init__.py", line
%   208, in _check_versions
%     module = importlib.import_module(modname)
%              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%   File "/usr/lib/python3.12/importlib/__init__.py", line 90, in
%   import_module
%     return _bootstrap._gcd_import(name[level:], package, level)
%            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%   File "/usr/lib/python3/dist-packages/kiwisolver/__init__.py", line
%   8, in <module>
%     from ._cext import (
% ImportError: /usr/local/MATLAB/R2025b/sys/os/glnxa64/libstdc++.so.6:
% version `GLIBCXX_3.4.32' not found (required by
% /usr/lib/python3/dist-packages/kiwisolver/_cext.cpython-312-x86_64-linux-gnu.so)
% 
% 
% Error in plot_daily_dive_frequency_map_IL (line 70)
% colormap(getPyPlot_cMap('YlGnBu',12));
%          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
% Caused by:
%     There was an unexpected error while executing the python script.
%     Sorry.
%
%
% Force MATLAB to use system libstdc++
if isunix && ~ismac
    system_lib = '/usr/lib/x86_64-linux-gnu';
    current_path = getenv('LD_LIBRARY_PATH');
    if ~contains(current_path, system_lib)
        setenv('LD_LIBRARY_PATH', [system_lib ':' current_path]);
        warning('Library path updated. You may need to restart MATLAB.');
    end
end 

colormap(getPyPlot_cMap('YlGnBu',12));  

set(h,'Position',[0.65 0.615 0.2325 0.0244],'FontSize',12)
ylabel(h,'Dive Frequency (no./day)','FontSize',16,'FontWeight','bold');
caxis([0 60]);

%% Set location of figure to match bin_map

set(gca,'Position',[0.1300 0.1100 0.7750 0.8150]);

%% Save

cd([fdir '/figures']);
exportgraphics(gcf,'daily_dive_frequency_map_IL.png','Resolution',300)

%% Clear

clear h* *LIMS
clear binned
clear ans

close gcf
