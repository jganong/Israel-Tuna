%% plot_seasonal_Figure_5_IL.m
% Sub-function of IsraelTuna.m; plots habitat envelopes in 6 regions
% during each season.

% Seasons
% 1 = Fall which includes September, October and November.
% 2 = Winter which includes December, January and February.
% 3 = Spring which includes March, April and May.
% 4 = Summer which includes June, July and August.

% Hotspots
% 0 = Outside of the Med
% 1 = Alboran Sea
% 2 = Western Med
% 3 = Adriatic Sea
% 4 = Ionian Sea
% 5 = Tunisian Plateau/Gulf of Sidra
% 6 = Aegean Sea
% 7 = Levantine Sea

ALL = [PSAT(:,[1 3 4 6 9 10]); TSERIES(:,[2 4 5 7 11 12])];

%% Plot habitat envelopes by region and season.

cnt = 0;
for i = 1:length(fieldnames(regions))+1
    for j = 1:length(unique(ALL.Season))

        binned.Temp = 0:0.5:30; % 0.5 deg C bins
        binned.Depth = 0:2:1200; % 2 m bins

        [binned.N,binned.Temp,binned.Depth,binned.binT,binned.binD] = ...
            histcounts2(ALL.Temperature(ALL.Region == i-1 & ALL.Season == j),...
            ALL.Depth(ALL.Region == i-1 & ALL.Season == j),...
            binned.Temp, binned.Depth);
        binned.N(binned.N == 0) = NaN;

        figure('Position',[476 446 283 420]);

        imagescn(binned.Temp,binned.Depth,log(binned.N).');

        shading flat

        set(gca,'ydir','reverse','FontSize',18,'linewidth',2);
        xlabel('Temperature (^oC)','FontSize',20); ylabel('Depth (m)','FontSize',20);

        xlim([binned.Temp(1) binned.Temp(end)]);
        ylim([binned.Depth(1) binned.Depth(end)]);

        colormap(turbo);
        caxis([0 12]);
        
        N = length(unique(ALL.TOPPID(ALL.Season == j & ALL.Region == i-1)));
        text(1,1155,['n = ' num2str(N)],'FontSize',20,'FontWeight','bold');

        cnt = cnt + 1;
        cd([fdir '/figures/Figure_4']);
        exportgraphics(gcf,['habitat_envelope_' num2str(i-1) '_' num2str(j) '.png'],'Resolution',300);

        clear N
        clear binned
        
        if i == 8 && j == 4
            h = colorbar('eastoutside'); ylabel(h,'ln(Frequency of Occurence)','FontSize',14);
            exportgraphics(gcf,'habitat_envelope_legend.png','Resolution',300);
        end

        close gcf

    end
end
clear i
clear j
clear tmp
clear cnt
clear h
