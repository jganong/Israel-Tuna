%% plot_individual_tracks_Med_with_regions_IL.m
% Sub-function of IsraelTuna.m; plots SSM tracks of each tags
% colored by month in Med.

%% Get Unique TOPP IDs

toppID = unique(SSM.TOPPID);

%% Loop Through All TOPP IDs

CI = cell(length(toppID),1);

for t = 1:length(toppID)

    %% Create figure and axes for bathymetry.

    figure('Position',[476 334 716 532]);

    %% Set projection of map.

    LATLIMS = [30 46]; LONLIMS = [-5.61 40];
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

    %% Plot patch.

    m_patch([-5.61 5 -5.61 -5.61],[40 46 46 40],'w');

    %% Set colormap by month.

    MM = unique(month(SSM.Date));
    cmap.month = [0.122,0.122,1 ; 0,0.773,1; 0.149,0.451,0; 0.298,0.902,0;...
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

    m_northarrow(-3.9,43.6,2,'type',2,'linewi',2);
    m_ruler([.04 .24],.125,2,'fontsize',16,'ticklength',0.01);

    %% Add TOPP ID

    patch([0.27 0.39 0.39 0.27],[0.81 0.81 0.85 0.85],'w');
    text(0.275,0.83,num2str(toppID(t)),'color','k','FontSize',20);

    patch([0.235 0.39 0.39 0.235],[0.77 0.77 0.81 0.81],'w');
    text(0.24,0.79,['CFL = ' num2str(META.length(META.toppID == toppID(t))) ' cm'],'color','k','FontSize',16);

    %% Save figure.

    cd([fdir '/figures/individual_tracks']);
    exportgraphics(gcf,[num2str(toppID(t)) '_inMed_withregions.png'],'Resolution',300);

    %% Clear

    clear ax* h* m MM *LIMS
    clear cs ch
    clear ans
    clear p

    close gcf

end
clear t*