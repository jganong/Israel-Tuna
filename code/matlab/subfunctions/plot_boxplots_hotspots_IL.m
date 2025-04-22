%% plot_boxplots_hotspots_IL %%
% Sub-function of IsraelTuna.m; plots boxplots of vertical diving behavior
% and environmental variables by hotspots.

%% Speed (m/s)

B.speed.Region = zeros(height(B.speed.TOPPID),1);
B.speed.Region(inpolygon(B.speed.Longitude,B.speed.Latitude,regions.Alboran(:,1),regions.Alboran(:,2))) = 1;
B.speed.Region(inpolygon(B.speed.Longitude,B.speed.Latitude,regions.WesternMed(:,1),regions.WesternMed(:,2))) = 2;
B.speed.Region(inpolygon(B.speed.Longitude,B.speed.Latitude,regions.Ionian(:,1),regions.Ionian(:,2))) = 4;
B.speed.Region(inpolygon(B.speed.Longitude,B.speed.Latitude,regions.Tunisian(:,1),regions.Tunisian(:,2))) = 5;
B.speed.Region(inpolygon(B.speed.Longitude,B.speed.Latitude,regions.Aegean(:,1),regions.Aegean(:,2))) = 6;
B.speed.Region(inpolygon(B.speed.Longitude,B.speed.Latitude,regions.Levantine(:,1),regions.Levantine(:,2))) = 7;

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(B.speed.Region == i),1),B.speed.Speed_m_per_s(B.speed.Region == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('Speed (m/s)','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([0 3]);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_speed_hotspot_IL.png','Resolution',300);

[~,~,tmp] = kruskalwallis(B.speed.Speed_m_per_s,B.speed.Region);
figure; c = multcompare(tmp);
stats.dive.hotspot.p_speed = c(:,[1:2 6]);

close all
clear b
clear tmp
clear ylab

%% Dive Frequency (no./day)

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(SSM.Region == i),1),SSM.DivesPerDay(SSM.Region == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('Dive Frequency (no./day)','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([0 80]);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_diveF_hotspot_IL.png','Resolution',300);

[~,~,tmp] = kruskalwallis(SSM.DivesPerDay,SSM.Region);
figure; c = multcompare(tmp);
stats.dive.hotspot.p_diveF = c(:,[1:2 6]);

close all
clear b
clear tmp
clear ylab

%% Duration (hours)

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(B.dives.hotspot == i),1),B.dives.duration(B.dives.hotspot == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('Dive Duration (hours)','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([0 2]);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_duration_hotspot_IL.png','Resolution',300);

[~,~,tmp] = kruskalwallis(B.dives.duration,B.dives.hotspot);
figure; c = multcompare(tmp);
stats.dive.hotspot.p_duration = c(:,[1:2 6]);

close all
clear b
clear ylab

%% Descent Rate (m/s)

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(B.dives.hotspot == i),1),B.dives.max_descent(B.dives.hotspot == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('Descent Rate (m/s)','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([0 4]);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_descent_hotspot_IL.png','Resolution',300);

[~,~,tmp] = kruskalwallis(B.dives.max_descent,B.dives.hotspot);
figure; c = multcompare(tmp);
stats.dive.hotspot.p_descentrate = c(:,[1:2 6]);

close all
clear b
clear ylab

%% Median Day Depth (m)

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(SSM.Region == i),1),SSM.MedDayDepth(SSM.Region == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('Median Day Depth (m)','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([0 500]);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_meddayD_hotspot_IL.png','Resolution',300);

[~,~,tmp] = kruskalwallis(SSM.MedDayDepth,SSM.Region);
figure; c = multcompare(tmp);
stats.dive.hotspot.p_medDaydepth = c(:,[1:2 6]);

close all
clear b
clear ylab

%% Median Night Depth (m)

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(SSM.Region == i),1),SSM.MedNigDepth(SSM.Region == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('Median Night Depth (m)','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([0 80]);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_mednightD_hotspot_IL.png','Resolution',300);

[~,~,tmp] = kruskalwallis(SSM.MedNigDepth,SSM.Region);
figure; c = multcompare(tmp);
stats.dive.hotspot.p_medNightdepth = c(:,[1:2 6]);

close all
clear b
clear ylab

%% Daily Maximum Depth (m)

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(SSM.Region == i),1),SSM.max_Depth(SSM.Region == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('Daily Max Depth (m)','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([0 700]);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_maxD_hotspot_IL.png','Resolution',300);

[~,~,tmp] = kruskalwallis(SSM.max_Depth,SSM.Region);
figure; c = multcompare(tmp);
stats.dive.hotspot.p_dailymaxdepth = c(:,[1:2 6]);

close all
clear b
clear ylab

%% % Time in Mesopelagic

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(SSM.Region == i),1),SSM.TimeinMeso(SSM.Region == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('% Time in Mesopelagic','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([0 50]);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_meso_hotspot_IL.png','Resolution',300);

[~,~,tmp] = kruskalwallis(SSM.TimeinMeso,SSM.Region);
figure; c = multcompare(tmp);
stats.dive.hotspot.p_timeinmeso = c(:,[1:2 6]);

close all
clear b
clear ylab

%% MLD

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(oce.region == i),1),oce.mld(oce.region == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('Mixed Layer Depth (m)','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([0 125]); yticks(0:25:125);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_mld_hotspot_IL.png','Resolution',300);

close all
clear b
clear ylab

%% T @ MLD

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(oce.region == i),1),oce.T_at_mld(oce.region == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('Temp at MLD (^oC)','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([12 30]);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_t_at_mld_hotspot_IL.png','Resolution',300);

close all
clear b
clear ylab

%% SST

figure('Position',[476 516 787 350]);

cnt = 1;
for i = [1:2 4:7]
    b = boxchart(cnt*ones(sum(oce.region == i),1),oce.SST(oce.region == i),"Notch","on");
    b.BoxFaceColor = cmap.regions(i+1,:);
    b.WhiskerLineColor = cmap.regions(i+1,:);
    b.MarkerColor = cmap.regions(i+1,:);
    b.MarkerStyle = 'none';

    hold on

    cnt = cnt + 1;

    if i == 5
        box on
        set(gca,'XTickLabel',{'Alboran','Western Med','Ionian','Tunisian/Sidra','Aegean','Levantine'},'FontSize',14);
        xlabel('Hotspot','FontSize',24,'FontWeight','Bold');
        ylab = ylabel('SST (^oC)','FontSize',24,'FontWeight','Bold');
        xlim([0 7]); xticks(1:1:6);
        ylim([12 32]);
    end
end
clear i
ylab.Position(1) = -0.45;

cd([fdir '/figures']);
exportgraphics(gcf,'boxplot_sst_hotspot_IL.png','Resolution',300);

close all
clear b
clear ylab