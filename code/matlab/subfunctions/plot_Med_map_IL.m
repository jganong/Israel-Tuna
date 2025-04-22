%% plot_Med_map_IL %%
% Sub-function of IsraelTuna.m; plots SSM tracks of all tags colored by
% year in Med.

%% Create figure and axes for bathymetry.

figure('Position',[476 334 716 532]);

%% Set projection of map.

LATLIMS = [30 46]; LONLIMS = [-5.61 40];
m_proj('miller','lon',LONLIMS,'lat',LATLIMS);

%% Plot bathymetry.

m_etopo2('contourf',-8000:500:0,'edgecolor','none');

colormap(m_colmap('blue'));

hold on

%% Plot land.

m_coast('patch',[.7 .7 .7]);

hold on

%% Plot patch.

m_patch([-5.61 5 -5.61 -5.61],[40 46 46 40],'w');

%% Get unique deployment months.

MM = unique(month(SSM.Date));

%% Set colormap.

cmap.month = [0.122,0.122,1; 0,0.773,1; 0.149,0.451,0; 0.298,0.902,0;...
    0.914,1,0.745; 1,1,0; 1,0.666,0; 1,0,0; 0.659,0,0; 0.8,0.745,0.639;...
    0.663,0,0.902; 1,1,1];

%% Plot SSM positions.

% by month
for i = 1:height(SSM)

    m_plot(SSM.Longitude(i),...
        SSM.Latitude(i),...
        'ko','MarkerFaceColor',cmap.month(find(month(SSM.Date(i)) == MM),:),...
        'MarkerEdgeColor','k','MarkerSize',4,'LineStyle','none','LineWidth',1);
    hold on

end
clear i

for i = 1:length(MM)
    m(i) = m_plot(-100,100,'o','MarkerFaceColor',cmap.month(i,:),'MarkerEdgeColor','k','MarkerSize',5,'LineWidth',1);
end

%% Create figure border.

m_grid('linewi',2,'tickdir','in','linest','none','fontsize',18);

%% Add north arrow and scale bar.

m_northarrow(-3.9,43.6,2,'type',2,'linewi',2);
m_ruler([.04 .24],.125,2,'fontsize',16,'ticklength',0.01);

%% Set location of figure to match bin_map

set(gca,'Position',[0.1300 0.1100 0.7750 0.8150]);

%% Save figure with legend.

cd([fdir '/figures']);
exportgraphics(gcf,'Med_map_IL.png','Resolution',300);

%% Clear

clear ax* h* m* *LIMS
clear cs ch
clear ans
clear TOPPid
clear PSATid
clear yy
clear MM

close gcf