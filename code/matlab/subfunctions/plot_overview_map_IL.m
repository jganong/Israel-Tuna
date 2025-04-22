%% plot_overview_map_IL %%
% Sub-function of IsraelTuna.m; plots SSM tracks of all tags colored by
% year.

%% Create figure and axes for bathymetry.

figure('Position',[476 334 716 532]);

%% Set projection of map.

LATLIMS = [15 65]; LONLIMS = [-85 40];
m_proj('miller','lon',LONLIMS,'lat',LATLIMS);

%% Plot bathymetry.

[cs,ch] = m_etopo2('contourf',-8000:500:0,'edgecolor','none');

colormap(m_colmap('blue'));

hold on

%% Plot land.

m_coast('patch',[.7 .7 .7]);

hold on

%% Get unique deployment years.

yy = unique(year(META.taggingdate));

%% Set colormap.

cmap.year = [0.298,0.902,0; 0.122,0.122,1; 1,0.666,0; 1,1,0];

%% Get unique TOPP IDs and PSAT IDs.

TOPPid = unique(SSM.TOPPID);

%% Plot SSM positions.

% by deployment year
for i = fliplr(1:length(TOPPid))
    m_plot(SSM.Longitude(SSM.TOPPID == TOPPid(i),:),...
        SSM.Latitude(SSM.TOPPID == TOPPid(i),:),...
        'k-','Color',[0.5 0.5 0.5]);

    hold on
    m_plot(SSM.Longitude(SSM.TOPPID == TOPPid(i),:),...
        SSM.Latitude(SSM.TOPPID == TOPPid(i),:),...
        'ko','MarkerFaceColor',cmap.year(find(year(META.taggingdate(META.toppID == TOPPid(i))) == yy),:),...
        'MarkerEdgeColor','k','MarkerSize',4,'LineStyle','none','LineWidth',1);
    hold on

end
clear i

for i = 1:length(yy)
    m(i) = m_plot(-100,100,'o','MarkerFaceColor',cmap.year(i,:),'MarkerEdgeColor','k','MarkerSize',5,'LineWidth',1);
end

%% Plot ICCAT regions.

m_line([-45 -45],[15 65],'linewi',2,'color','k','linestyle','--')

%% Plot Med outline.

m_plot([-5.61 40 40 -5.61 -5.61],[30 30 46 46 30],'k-','LineWidth',2)

%% Plot Tagging and Pop-Up Locations

for i = fliplr(1:length(TOPPid))

    m_plot(META.deploylon(META.toppID == TOPPid(i)),...
        META.deploylat(META.toppID == TOPPid(i)),...
        'ks','MarkerFaceColor',cmap.year(find(year(META.taggingdate(META.toppID == TOPPid(i))) == yy),:),...
        'MarkerEdgeColor','k','MarkerSize',10,'LineStyle','none','LineWidth',1);

    hold on

    if isnan(META.reclon(META.toppID == TOPPid(i)))
        m_plot(META.poplon(META.toppID == TOPPid(i)),...
            META.poplat(META.toppID == TOPPid(i)),...
            'kv','MarkerFaceColor',cmap.year(find(year(META.taggingdate(META.toppID == TOPPid(i))) == yy),:),...
            'MarkerEdgeColor','k','MarkerSize',10,'LineStyle','none','LineWidth',1);

        hold on

    else

        m_plot(META.reclon(META.toppID == TOPPid(i)),...
            META.reclat(META.toppID == TOPPid(i)),...
            'kv','MarkerFaceColor',cmap.year(find(year(META.taggingdate(META.toppID == TOPPid(i))) == yy),:),...
            'MarkerEdgeColor','k','MarkerSize',10,'LineStyle','none','LineWidth',1);

        hold on

    end

end
clear i

%% Create figure border.

m_grid('linewi',2,'tickdir','in','linest','none','fontsize',18);

%% Add north arrow and scale bar.

m_northarrow(-79,60,4,'type',2,'linewi',2);
m_ruler([.04 .24],.1,2,'fontsize',16,'ticklength',0.01);

%% Bathymetry Bar

h1 = m_contfbar([.65 .95],.32,cs,ch,'endpiece','no','FontSize',12);

xlabel(h1,'Bottom Depth (m)','FontWeight','bold');

%% Set location of figure to match bin_map

set(gca,'Position',[0.1300 0.1100 0.7750 0.8150]);

%% Save figure.

cd([fdir '/figures']);
exportgraphics(gcf,'overview_map_IL.png','Resolution',300);

%% Add Legend

delete(h1);

t = m_plot(0,0,'ks','MarkerFaceColor','w','MarkerEdgeColor','k','MarkerSize',8,'LineStyle','none');
p = m_plot(0,0,'kv','MarkerFaceColor','w','MarkerEdgeColor','k','MarkerSize',8,'LineStyle','none');

[~,icon] = legend([m, t, p],[str2cell(string(yy));"Tagging";"Pop-Up"],'FontSize',14,'Location','eastoutside');
icons = findobj(icon, 'type', 'line');
set(icons,'MarkerSize',12);
clear yy
clear icon*
clear t p

%% Save figure with legend.

cd([fdir '/figures']);
exportgraphics(gcf,'overview_map_IL_legend.png','Resolution',300);

%% Clear

clear ax* h* m* *LIMS
clear cs ch
clear ans
clear TOPPid
clear PSATid

close gcf