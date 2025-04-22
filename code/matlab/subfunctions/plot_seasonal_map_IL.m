%% plot_seasonal_map_IL.m
% Sub-function of IsraelTuna.m; plots SSM tracks of all tags in each season
% colored by month.

%% Loop through each season.

for i = 1:length(unique(SSM.Season))

    %% Create figure.

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

    %% Set colormap by month.

    MM = unique(month(SSM.Date));
    cmap.month = [0.122,0.122,1; 0,0.773,1; 0.149,0.451,0; 0.298,0.902,0;...
        0.914,1,0.745; 1,1,0; 1,0.666,0; 1,0,0; 0.659,0,0; 0.8,0.745,0.639;...
        0.663,0,0.902; 1,1,1];

    %% Plot hotspots

    m_plot(regions.Alboran(:,1),regions.Alboran(:,2),':','LineWidth',4,'Color',cmap.regions(2,:));
    m_plot(regions.WesternMed(:,1),regions.WesternMed(:,2),':','LineWidth',4,'Color',cmap.regions(3,:));
    m_plot(regions.Adriatic(:,1),regions.Adriatic(:,2),':','LineWidth',4,'Color',cmap.regions(4,:));
    m_plot(regions.Ionian(:,1),regions.Ionian(:,2),':','LineWidth',4,'Color',cmap.regions(5,:));
    m_plot(regions.Tunisian(:,1),regions.Tunisian(:,2),':','LineWidth',4,'Color',cmap.regions(6,:));
    m_plot(regions.Aegean(:,1),regions.Aegean(:,2),':','LineWidth',4,'Color',cmap.regions(7,:));
    m_plot(regions.Levantine(:,1),regions.Levantine(:,2),':','LineWidth',4,'Color',cmap.regions(8,:));

    %% Plot SSM positions of tuna colored by month.

    tmp = SSM;
    tmp = tmp(tmp.Region ~= 0,:);

    % Plot each tag.
    for j = 1:length(MM)
        if i == 2 && (j == 12 || j == 1 || j == 2)
            m(j) = m_plot(tmp.Longitude(MM(j) == month(tmp.Date)),...
                tmp.Latitude(MM(j) == month(tmp.Date)),...
                'ko','MarkerFaceColor',cmap.month(j,:),'MarkerEdgeColor','k','MarkerSize',5,'LineStyle','none','LineWidth',1);
            hold on
        else
            m(j) = m_plot(-100,100,'o','MarkerFaceColor',cmap.month(j,:),'MarkerEdgeColor','k','MarkerSize',5);
        end
        if i == 3 && (j == 3 || j == 4 || j == 5)
            m(j) = m_plot(tmp.Longitude(MM(j) == month(tmp.Date)),...
                tmp.Latitude(MM(j) == month(tmp.Date)),...
                'ko','MarkerFaceColor',cmap.month(j,:),'MarkerEdgeColor','k','MarkerSize',5,'LineStyle','none','LineWidth',1);
            hold on
        else
            m(j) = m_plot(-100,100,'o','MarkerFaceColor',cmap.month(j,:),'MarkerEdgeColor','k','MarkerSize',5);
        end

        if i == 4 && (j == 6 || j == 7 || j == 8)
            m(j) = m_plot(tmp.Longitude(MM(j) == month(tmp.Date)),...
                tmp.Latitude(MM(j) == month(tmp.Date)),...
                'ko','MarkerFaceColor',cmap.month(j,:),'MarkerSize',5,'MarkerEdgeColor','k','LineStyle','none','LineWidth',1);
            hold on
        else
            m(j) = m_plot(-100,100,'o','MarkerFaceColor',cmap.month(j,:),'MarkerEdgeColor','k','MarkerSize',5);
        end

        if i == 1 && (j == 9 || j == 10 || j == 11)
            m(j) = m_plot(tmp.Longitude(MM(j) == month(tmp.Date)),...
                tmp.Latitude(MM(j) == month(tmp.Date)),...
                'ko','MarkerFaceColor',cmap.month(j,:),'MarkerSize',5,'MarkerEdgeColor','k','LineStyle','none','LineWidth',1);
            hold on
        else
            m(j) = m_plot(-100,100,'o','MarkerFaceColor',cmap.month(j,:),'MarkerEdgeColor','k','MarkerSize',5);
        end
    end
    clear j

    %% Create figure border.

    m_grid('linewi',2,'tickdir','in','linest','none','fontsize',18);

    %% Add north arrow and scale bar.

    m_northarrow(-3.9,43.6,2,'type',2,'linewi',2);
    m_ruler([.04 .24],.125,2,'fontsize',16,'ticklength',0.01);

    %% Set location of figure to match bin_map

    set(gca,'Position',[0.1300 0.1100 0.7750 0.8150]);

    %% Save figure.

    cd([fdir '/figures']);
    if i == 2
        exportgraphics(gcf,'seasonal_map_winter_IL.png','Resolution',300);
    elseif i == 3
        exportgraphics(gcf,'seasonal_map_spring_IL.png','Resolution',300);
    elseif i == 4
        exportgraphics(gcf,'seasonal_map_summer_IL.png','Resolution',300);
    elseif i == 1
        exportgraphics(gcf,'seasonal_map_fall_IL.png','Resolution',300);
    end

    %% Add Legend

    if i == 4

        [~,icon] = legend(m,{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'},...
            'FontSize',14,'Location','eastoutside');
        icons = findobj(icon, 'type', 'line');
        set(icons,'MarkerSize',12);
        clear MM
        clear icon*

        exportgraphics(gcf,'monthly_legend_IL.png','Resolution',300);

    end

    %% Clear

    clear ax* h* m MM *LIMS
    clear cs ch
    clear ans

    close gcf

end
clear i
clear tmp