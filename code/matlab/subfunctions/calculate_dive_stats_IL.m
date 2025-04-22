%% calculate_dive_stats_IL.m
% Sub-function of IsraelTuna.m; computes statistics on dive characteristics
% in each hotspot.

% Hotspots
% 0 = Outside of the Ionian
% 1 = Alboran Sea
% 2 = Western Med
% 3 = Adriatic Sea
% 4 = Ionian Sea
% 5 = Tunisian Plateau/Gulf of Sidra
% 6 = Aegean Sea
% 7 = Levantine Sea

%% Loop through all variables and hotspots

for i = 1:8
    stats.dive.hotspot.speed.median(i) = median(B.speed.Speed_m_per_s(B.speed.Region == i-1),'omitnan');
    stats.dive.hotspot.speed.mad(i) = mad(B.speed.Speed_m_per_s(B.speed.Region == i-1),1);
    stats.dive.hotspot.speed.N(i) = sum(B.speed.Region == i-1);

    stats.dive.hotspot.diveF.median(i) = median(SSM.DivesPerDay(SSM.Region == i-1),'omitnan');
    stats.dive.hotspot.diveF.mad(i) = mad(SSM.DivesPerDay(SSM.Region == i-1),1);
    stats.dive.hotspot.diveF.N(i) = sum(SSM.Region == i-1);

    stats.dive.hotspot.dur.median(i) = median(B.dives.duration(B.dives.hotspot == i-1),'omitnan');
    stats.dive.hotspot.dur.mad(i) = mad(B.dives.duration(B.dives.hotspot == i-1),1);
    stats.dive.hotspot.dur.N(i) = sum(B.dives.hotspot == i-1);

    stats.dive.hotspot.descent.median(i) = median(B.dives.max_descent(B.dives.hotspot == i-1),'omitnan');
    stats.dive.hotspot.descent.mad(i) = mad(B.dives.max_descent(B.dives.hotspot == i-1),1);
    stats.dive.hotspot.descent.N(i) = sum(B.dives.hotspot == i-1);

    stats.dive.hotspot.medDay.median(i) = median(SSM.MedDayDepth(SSM.Region == i-1),'omitnan');
    stats.dive.hotspot.medDay.mad(i) = mad(SSM.MedDayDepth(SSM.Region == i-1),1);
    stats.dive.hotspot.medDay.N(i) = sum(SSM.Region == i-1);

    stats.dive.hotspot.medNight.median(i) = median(SSM.MedNigDepth(SSM.Region == i-1),'omitnan');
    stats.dive.hotspot.medNight.mad(i) = mad(SSM.MedNigDepth(SSM.Region == i-1),1);
    stats.dive.hotspot.medNight.N(i) = sum(SSM.Region == i-1);

    stats.dive.hotspot.maxD.median(i) = median(SSM.max_Depth(SSM.Region == i-1),'omitnan');
    stats.dive.hotspot.maxD.mad(i) = mad(SSM.max_Depth(SSM.Region == i-1),1);
    stats.dive.hotspot.maxD.N(i) = sum(SSM.Region == i-1);

    stats.dive.hotspot.meso.median(i) = median(SSM.TimeinMeso(SSM.Region == i-1),'omitnan');
    stats.dive.hotspot.meso.mad(i) = mad(SSM.TimeinMeso(SSM.Region == i-1),1);
    stats.dive.hotspot.meso.N(i) = sum(SSM.Region == i-1);

end
