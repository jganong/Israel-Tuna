%% plot_Med_bin_map_IL.m
% Sub-function of IsraelTuna.m; plots SSM tracks of binned by days in 
% 1 x 1 degree bins in Med.

%% Create figure and axes for bathymetry. 

figure('Position',[476 334 716 532]);

%% Set projection of map.

LATLIMS = [30 46]; LONLIMS = [-5.61 40];
m_proj('miller','lon',LONLIMS,'lat',LATLIMS);

%% Bin SSM Positions

binned.LONedges = -6:1:40;
binned.LATedges = 30:1:46;

[binned.N,~,~,binned.indLON,binned.indLAT] = histcounts2(SSM.Longitude,SSM.Latitude,binned.LONedges,binned.LATedges); % number of daily geolocations
SSM.Index = sub2ind(size(binned.N),binned.indLON+1,binned.indLAT+1);

tmp = groupcounts(groupcounts(SSM,["Index" "TOPPID" ]),"Index");
binned.n = zeros(size(binned.N)); % number of unique toppids per bin
binned.n(tmp.Index) = tmp.GroupCount;
clear tmp

binned.Nn = (1-(binned.n./length(unique(SSM.TOPPID)))).*binned.N; % number of daily geolocations x 1 - number of tags in bin/total number of tags
% binned.Nn = (binned.n./length(unique(SSM.toppid))).*binned.N; % number of daily geolocations x number of tags in bin/total number of tags

binned.LONmid = diff(binned.LONedges)/2 + -6:1:40;
binned.LATmid = diff(binned.LATedges)/2 + 30:1:46;

m_pcolor(binned.LONmid-0.5,binned.LATmid-0.5,binned.Nn.');

hold on

%% Plot land.

m_coast('patch',[.7 .7 .7]);

hold on

%% Plot patch.

m_patch([-5.61 5 -5.61 -5.61],[40 46 46 40],'w');

%% Plot hotspots

cmap.regions = hsv(8);
cmap.regions(3,:) = [1 1 0];
cmap.regions(5:7,:) = cmap.regions(6:8,:);
cmap.regions = [1 1 1; cmap.regions];
cmap.regions(end,:) = [];

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

%% Add colorbar

p = get(gca,'Position');

h = colorbar('FontSize',16); 
cmap.bin = flipud(hot(85));
cmap.bin = [1,1,1; cmap.bin(6:end,:)];
colormap(cmap.bin);
ylab = ylabel(h,'Total Daily Positions x (1 - Proportion of Total Tags)','FontSize',16);
caxis([0 80]);

set(gca,'Position',p);
ylab.Position(1) = ylab.Position(1) - 0.13;

clear ylab
clear p

%% Save

cd([fdir '/figures']);
exportgraphics(gcf,'Med_bin_map_IL.png','Resolution',300)

%% Clear

clear h* binned *LIMS
clear ans

close gcf