%% plot_individual_tracks_IL.m
% Sub-function of IsraelTuna.m; plots SSM tracks of each tags
% colored by month.

%% Get Unique TOPP IDs

toppID = unique(SSM.TOPPID);

%% Loop Through All TOPP IDs

CI = cell(length(toppID),1);

for t = 1:length(toppID)

    %% Create figure and axes for bathymetry.

    figure('Position',[476 334 716 532]);

    %% Set projection of map.

    LATLIMS = [15 50]; LONLIMS = [-85 40];
    if t == length(toppID)
        LATLIMS = [15 70]; LONLIMS = [-85 40];
    end
    m_proj('miller','lon',LONLIMS,'lat',LATLIMS);

    %% Plot bathymetry.

    [cs,ch] = m_etopo2('contourf',-8000:500:0,'edgecolor','none');
    colormap(m_colmap('blue'));

    hold on

    %% Load confidence intervals.

    cd('/Users/cpagniello/Library/CloudStorage/GoogleDrive-cpagniel@stanford.edu/Shared drives/ABFT Med Eyal/data/ssm/raw_output')

    tmp = readmatrix([num2str(toppID(t)) '00_99CI_full.xlsx']);

    %% Plot confidence intervals.

    m_plot(tmp(:,1),tmp(:,2),'k:','LineWidth',2)

    CI{t} = tmp;

    clear tmp

    %% Plot land.

    m_coast('patch',[.7 .7 .7]);

    hold on

    %% Set colormap by month.

    MM = unique(month(SSM.Date));
    cmap.month = [0.122,0.122,1 ; 0,0.773,1; 0.149,0.451,0; 0.298,0.902,0;...
        0.914,1,0.745; 1,1,0; 1,0.666,0; 1,0,0; 0.659,0,0; 0.8,0.745,0.639;...
        0.663,0,0.902; 1,1,1];

    %% Plot SSM Positions

    tmp.lon = SSM.Longitude(SSM.TOPPID == toppID(t));
    tmp.lat = SSM.Latitude(SSM.TOPPID == toppID(t));
    tmp.date = SSM.Date(SSM.TOPPID == toppID(t));

    m_plot(tmp.lon,tmp.lat,'k-');

    hold on

    for j = 1:length(MM)
        if isempty(tmp.lon(MM(j) == month(tmp.date)))
            m(j) = m_plot(-100,100,'o','MarkerFaceColor',cmap.month(j,:),'MarkerEdgeColor','k','MarkerSize',8,'LineWidth',1);
            hold on
        else
            m(j) = m_plot(tmp.lon(MM(j) == month(tmp.date)),...
                tmp.lat(MM(j) == month(tmp.date)),...
                'ko','MarkerFaceColor',cmap.month(j,:),'MarkerEdgeColor','k','MarkerSize',8,'LineWidth',1);
            hold on
        end
    end
    clear j
    clear tmp

    %% Plot ICCAT regions.

    m_line([-45 -45],[15 70],'linewi',2,'color','k','linestyle','--')

    %% Plot box around Med for fish that exit.

    if t == 4 || t == length(toppID)
        m_plot([-5.61 40 40 -5.61 -5.61],[30 30 46 46 30],'k-','LineWidth',2)
    end

    %% Plot Tagging and Pop-Up Locations

    m_plot(META.deploylon(META.toppID == toppID(t)),META.deploylat(META.toppID == toppID(t)),...
        'ks','MarkerFaceColor','w','MarkerEdgeColor','k','MarkerSize',14,'LineStyle','none','LineWidth',1);

    hold on

    if isnan(META.reclon(META.toppID == toppID(t)))
        m_plot(META.poplon(META.toppID == toppID(t)),META.poplat(META.toppID == toppID(t)),...
            'kv','MarkerFaceColor','w','MarkerEdgeColor','k','MarkerSize',12,'LineStyle','none','LineWidth',1);

    hold on

    else

        m_plot(META.reclon(META.toppID == toppID(t)),META.reclat(META.toppID == toppID(t)),...
            'kv','MarkerFaceColor','w','MarkerEdgeColor','k','MarkerSize',12,'LineStyle','none','LineWidth',1);

    end

    %% Create figure border.

    m_grid('linewi',2,'tickdir','in','linest','none','fontsize',18);

    %% Add north arrow and scale bar.

    if t == length(toppID) % for Norway tag with larger latitude range
        m_northarrow(-79,65,4,'type',2,'linewi',2);
        m_ruler([.04 .24],.1,2,'fontsize',16,'ticklength',0.01);
    else
        m_northarrow(-79,45,4,'type',2,'linewi',2);
        m_ruler([.04 .24],.15,2,'fontsize',16,'ticklength',0.01);
    end

    %% Bathymetry Bar

    h1 = m_contfbar([.65 .95],.425,cs,ch,'endpiece','no','FontSize',12);
    xlabel(h1,'Bottom Depth (m)','FontWeight','bold');

    if t == length(toppID)
        h1 = m_contfbar([.65 .95],.27,cs,ch,'endpiece','no','FontSize',12);
        xlabel(h1,'Bottom Depth (m)','FontWeight','bold');
    end

    %% Add TOPP ID

    if t == length(toppID)
        patch([0.72 1.06 1.06 0.72],[1.325 1.325 1.45 1.45],'w');
        text(0.74,1.385,num2str(toppID(t)),'color','k','FontSize',20);
    else
        patch([0.72 1.06 1.06 0.72],[0.8 0.8 0.925 0.925],'w');
        text(0.74,0.86,num2str(toppID(t)),'color','k','FontSize',20);
    end

    %% Save figure.

    cd([fdir '/figures/individual_tracks']);
    exportgraphics(gcf,[num2str(toppID(t)) '.png'],'Resolution',300);

    %% Clear

    clear ax* h* m MM *LIMS
    clear cs ch
    clear ans
    clear p

    close gcf

end
clear t*