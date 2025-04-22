%% plot_timeseries_NT.m
% Sub-function of IsraelTuna.m; plots temperature-depth timeseries with hotspots location.

%% Loop through each tag

toppID = unique(PSAT.TOPPID);

for i = 1:length(toppID)

    %% Create figure.

    figure('Position',[112 219 1272 532]);

    %% Plot timeseries.

    scatter(PSAT.DateTime(PSAT.TOPPID == toppID(i)),...
        PSAT.Depth(PSAT.TOPPID == toppID(i)),...
        4,PSAT.Temperature(PSAT.TOPPID == toppID(i)),'filled');

    set(gca,'ydir','reverse','FontSize',36,'LineWidth',3);
    xlabel('Date','FontSize',42); ylabel('Depth (m)','FontSize',42);

    %% Set colormap for timeseries.

    colormap(getPyPlot_cMap('Spectral_r'));
    h = colorbar; ylabel(h,'Temperature (^oC)','FontSize',40);
    h.FontSize = 38;
    caxis([0 30]); h.Ticks = 0:5:30;

    clear h

    %% Set axes.

    tmp = PSAT.DateTime(PSAT.TOPPID == toppID(i));
    xlimit = [datetime(double(year(tmp(1))),05,30) datetime(double(year(tmp(1)))+1,05,30)];
    xlimit.TimeZone = 'UTC';
    xlim(xlimit);

    ylim([-50 1000]);
    %     if i == length(toppID)
    %         ylim([-50 600]);
    %     end

    box on;

    hold on

    if i == length(toppID)
        xlim([datetime(2023,05,06,'TimeZone','UTC') datetime(2023,07,06,'TimeZone','UTC')])
    end

    clear xlimit

    %% Plot hotspot.

    tmp = PSAT(PSAT.TOPPID == toppID(i),:);

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

    %% Plot mixed layer depth.

    m(1) = plot(oce.t(oce.toppID == toppID(i)),oce.mld(oce.toppID == toppID(i)),'k-','LineWidth',2);

    %% Save figure.

    cd([fdir '/figures/timeseries']);
    exportgraphics(gcf,['timeseries_' num2str(toppID(i)) '.png'],'Resolution',300);

    %% Legend

    if i == 1
        for j = 2:length(cmap.regions)
            m(j) = patch([-5 -5 -5 -5 -5],...
                [-100 -100 -100 -100 -100],cmap.regions(j,:),'EdgeColor','none');
        end

        legend(m,{'Mixed Layer Depth','Alboran','Western Med','Adriatic',...
            'Ionian','Tunisian/Sidra','Aegean','Levantine'},...
            'FontSize',30,'Location','northeast');

        exportgraphics(gcf,'regions_timeseries_legend_IL.png','Resolution',300)
    elseif i == length(toppID)
        for j = 2:length(cmap.regions)
            m(j) = patch([-5 -5 -5 -5 -5],...
                [-100 -100 -100 -100 -100],cmap.regions(j,:),'EdgeColor','none');
        end

        legend(m,{'Mixed Layer Depth','Alboran','Western Med','Adriatic',...
            'Ionian','Tunisian/Sidra','Aegean','Levantine'},...
            'FontSize',30,'Location','best','NumColumns',2);

        exportgraphics(gcf,['timeseries_' num2str(toppID(i)) '.png'],'Resolution',300)
    end
    clear j

    close gcf

end
clear i
clear toppID
clear l m p