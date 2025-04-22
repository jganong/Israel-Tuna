%% plot_transmitted_timeseries_IL.m
% Sub-function of IsraelTuna.m; plots temperature-depth timeseries with 
% hotspots location for transmitted tags.

%% Loop through each tag

toppID = unique(TSERIES.TOPPID);

for i = 1:length(toppID)

    %% Create figure.

    figure('Position',[112 219 1272 532]);

    %% Plot timeseries.

    plot(TSERIES.DateTime(TSERIES.TOPPID == toppID(i)),TSERIES.Depth(TSERIES.TOPPID == toppID(i)),...
        'o','MarkerFaceColor',[0.5 0.5 0.5],'Color',[0.5 0.5 0.5]);

    hold on

    scatter(TSERIES.DateTime(TSERIES.TOPPID == toppID(i)),...
        TSERIES.Depth(TSERIES.TOPPID == toppID(i)),...
        50,TSERIES.Temperature(TSERIES.TOPPID == toppID(i)),'filled');

    set(gca,'ydir','reverse','FontSize',36,'LineWidth',3);
    xlabel('Date','FontSize',42); ylabel('Depth (m)','FontSize',42);

    %% Set colormap for timeseries.

    colormap(getPyPlot_cMap('Spectral_r'));
    h = colorbar; ylabel(h,'Temperature (^oC)','FontSize',40);
    h.FontSize = 38;
    caxis([0 30]); h.Ticks = 0:5:30;

    clear h

    %% Set axes.

    tmp = TSERIES.DateTime(TSERIES.TOPPID == toppID(i));
    xlimit = [datetime(double(year(tmp(1))),05,30) datetime(double(year(tmp(1)))+1,05,30)];
    xlimit.TimeZone = 'UTC';
    xlim(xlimit);

    ylim([-50 1000]);

    box on;

    hold on

    clear xlimit

    %% Plot hotspot.

    tmp = TSERIES(TSERIES.TOPPID == toppID(i),:);

    ind = ischange(tmp.Region(tmp.TOPPID == toppID(i)));
    ind = [1; find(ind); length(tmp.Region(tmp.TOPPID == toppID(i)))];

    for j = 1:length(ind)-1
        p(j) = patch([tmp.DateTime(ind(j)) tmp.DateTime(ind(j)) ...
            tmp.DateTime(ind(j+1)-1) tmp.DateTime(ind(j+1)-1) tmp.DateTime(ind(j))],...
            [-10 -50 -50 -10 -10],cmap.regions(tmp.Region(ind(j))+1,:),'EdgeColor','none');
    end
    clear j
    clear ind
    clear tmp

    %% Save figure.

    cd([fdir '/figures/timeseries']);
    exportgraphics(gcf,['timeseries_' num2str(toppID(i)) '.png'],'Resolution',300);

    %% Legend

    if i == 1
        for j = 2:length(cmap.regions)
            m(j-1) = patch([-5 -5 -5 -5 -5],...
                [-100 -100 -100 -100 -100],cmap.regions(j,:),'EdgeColor','none');
        end

        legend(m,{'Alboran','Western Med','Adriatic',...
            'Ionian','Tunisian/Sidra','Aegean','Levantine'},...
            'FontSize',30,'Location','northeast');

        exportgraphics(gcf,'regions_transm_timeseries_legend_IL.png','Resolution',300)
    end
    clear j
    clear m

    close gcf

end
clear i
clear toppID
clear l m p