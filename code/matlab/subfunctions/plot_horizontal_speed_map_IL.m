%% plot_horizontal_speed_map_IL.m
% Sub-function of IsraelTuna.m; plots median horizontal speeed in 
% 1 x 1 degree bins.



%% Compute distance between adjacent daily positions. 
tbl = cell(height(META),1);
tmp = struct;
for i = 1:height(META)
	row=META(i,:);
	SSM_SUBSET = SSM(SSM.TOPPID == row.toppID, :);

    tmp.lat = SSM_SUBSET.Latitude;
    tmp.lon = SSM_SUBSET.Longitude;
    tmp.date = SSM_SUBSET.Date;

    Distance_km = m_lldist(tmp.lon,tmp.lat);
    Speed_m_per_s = Distance_km*1000./86400; % 1 day = 86400 seconds
    Latitude = tmp.lat(1:end-1);
    Longitude = tmp.lon(1:end-1);
    Date = tmp.date(1:end-1);
    toppID 	= Latitude; % placeholder copy
    toppID(:)= row.toppID; % fill in the placeholder values with toppID
    tbl{i} = table(toppID,Distance_km,Speed_m_per_s,Latitude,Longitude,Date);

    
% I got the following error:
% Unable to concatenate a datetime array that has a time zone with one
% that does not have a time zone.
    tbl{i}.Date.TimeZone = 'UTC';
end
B.speed = cat(1,tbl{:});

%% Create figure and axes for bathymetry. 

figure('Position',[476 334 716 532]);

%% Set projection of map.

LATLIMS = [30 46]; LONLIMS = [-5.61 40];
m_proj('miller','lon',LONLIMS,'lat',LATLIMS);

%% Compute median of speed (m/s) in each bin.

clear binned;
binned.LONedges = -6:1:40;
binned.LATedges = 30:1:46;

LONmid = diff(binned.LONedges)/2 + binned.LONedges(1);
LATmid = diff(binned.LATedges)/2 + binned.LATedges(1);

[binned] = twodmed(B.speed.Longitude,B.speed.Latitude,...
         B.speed.Speed_m_per_s,binned.LONedges,binned.LATedges);




% bins.speed = binned.mz.';

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
m_text(32, 39, ['n = ' num2str(length(unique(B.speed.toppID)))], 'FontSize', 20);

%% Add colorbar

h = colorbar('FontSize',14,'Location','southoutside'); 
colormap(cmocean('deep',8))
set(h,'Position',[0.65 0.615 0.2325 0.0244],'FontSize',12)
ylabel(h,'Speed (m/s)','FontSize',16,'FontWeight','bold');
caxis([0 3]);
h.Ticks = 0:0.5:3;

%% Set location of figure to match bin_map

set(gca,'Position',[0.1300 0.1100 0.7750 0.8150]);

%% Save

cd([fdir '/figures']);
exportgraphics(gcf, 'speed_map_IL.png','Resolution',300)

%% Clear

clear h* binned *LIMS
clear tmp
clear ans

close gcf
