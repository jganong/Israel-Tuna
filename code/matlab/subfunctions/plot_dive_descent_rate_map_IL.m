%% plot_dive_descent_rate_map_IL.m
% Sub-function of IsraelTuna.m; plots median dive max descent rate in 
% 1 x 1 degree bins.

%% Create figure and axes for bathymetry. 

figure('Position',[476 334 716 532]);

%% Set projection of map.

LATLIMS = [30 46]; LONLIMS = [-5.61 40];
m_proj('miller','lon',LONLIMS,'lat',LATLIMS);

%% Compute median of daily dive frequency in each bin.

binned.LONedges = -6:1:40;
binned.LATedges = 30:1:46;

[binned.mz,binned.LONmid,binned.LATmid] = twodmed(B.dives.lon,B.dives.lat,...
        B.dives.max_descent,binned.LONedges,binned.LATedges);
bins.descent_rate = binned.mz.';

m_pcolor(binned.LONmid-0.5,binned.LATmid-0.5,binned.mz);

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
m_text(32, 39, ['n = ' num2str(length(unique(B.dives.toppID)))], 'FontSize', 20);

%% Add colorbar

h = colorbar('FontSize',14,'Location','southoutside'); 
colormap(getPyPlot_cMap('YlGnBu',12)); 
set(h,'Position',[0.65 0.615 0.2325 0.0244],'FontSize',12)
ylabel(h,'Descent Rate (m/s)','FontSize',16,'FontWeight','bold');
caxis([0 3]);
h.Ticks = 0:1:3;

%% Set location of figure to match bin_map

set(gca,'Position',[0.1300 0.1100 0.7750 0.8150]);

%% Save

cd([fdir '/figures']);
exportgraphics(gcf,'dive_descent_rate_map_IL.png','Resolution',300)

%% Clear

clear h* *LIMS
clear binned
clear ans

close gcf