%% calculate_stats_dive_IL.m
% Sub-function of IsraelTuna.m; computes statistics on dives.

%% Speed

stats.dive.hotspot.speed.median_Alboran = median(B.speed.Speed_m_per_s(B.speed.Region == 1),'omitnan');
stats.dive.hotspot.speed.mad_Alboran = mad(B.speed.Speed_m_per_s(B.speed.Region == 1),1);
stats.dive.hotspot.speed.N_Alboran = sum(B.speed.Region == 1);

stats.dive.hotspot.speed.median_WestMed = median(B.speed.Speed_m_per_s(B.speed.Region == 2),'omitnan');
stats.dive.hotspot.speed.mad_WestMed = mad(B.speed.Speed_m_per_s(B.speed.Region == 2),1);
stats.dive.hotspot.speed.N_WestMed = sum(B.speed.Region == 2);

stats.dive.hotspot.speed.median_Ionian = median(B.speed.Speed_m_per_s(B.speed.Region == 4),'omitnan');
stats.dive.hotspot.speed.mad_Ionian = mad(B.speed.Speed_m_per_s(B.speed.Region == 4),1);
stats.dive.hotspot.speed.N_Ionian = sum(B.speed.Region == 4);

stats.dive.hotspot.speed.median_Tunisia = median(B.speed.Speed_m_per_s(B.speed.Region == 5),'omitnan');
stats.dive.hotspot.speed.mad_Tunisia = mad(B.speed.Speed_m_per_s(B.speed.Region == 5),1);
stats.dive.hotspot.speed.N_Tunisia = sum(B.speed.Region == 5);

stats.dive.hotspot.speed.median_Aegean = median(B.speed.Speed_m_per_s(B.speed.Region == 6),'omitnan');
stats.dive.hotspot.speed.mad_Aegean = mad(B.speed.Speed_m_per_s(B.speed.Region == 6),1);
stats.dive.hotspot.speed.N_Aegean = sum(B.speed.Region == 6);

stats.dive.hotspot.speed.median_Levantine = median(B.speed.Speed_m_per_s(B.speed.Region == 7),'omitnan');
stats.dive.hotspot.speed.mad_Levantine = mad(B.speed.Speed_m_per_s(B.speed.Region == 7),1);
stats.dive.hotspot.speed.N_Levantine = sum(B.speed.Region == 7);

%% Dive Frequency

stats.dive.hotspot.diveF.median_Alboran = median(SSM.DivesPerDay(SSM.Region == 1),'omitnan');
stats.dive.hotspot.diveF.mad_Alboran = mad(SSM.DivesPerDay(SSM.Region == 1),1);
stats.dive.hotspot.diveF.N_Alboran = sum(SSM.Region == 1);

stats.dive.hotspot.diveF.median_WestMed = median(SSM.DivesPerDay(SSM.Region == 2),'omitnan');
stats.dive.hotspot.diveF.mad_WestMed = mad(SSM.DivesPerDay(SSM.Region == 2),1);
stats.dive.hotspot.diveF.N_WestMed = sum(SSM.Region == 2);

stats.dive.hotspot.diveF.median_Ionian = median(SSM.DivesPerDay(SSM.Region == 4),'omitnan');
stats.dive.hotspot.diveF.mad_Ionian = mad(SSM.DivesPerDay(SSM.Region == 4),1);
stats.dive.hotspot.diveF.N_Ionian = sum(SSM.Region == 4);

stats.dive.hotspot.diveF.median_Tunisia = median(SSM.DivesPerDay(SSM.Region == 5),'omitnan');
stats.dive.hotspot.diveF.mad_Tunisia = mad(SSM.DivesPerDay(SSM.Region == 5),1);
stats.dive.hotspot.diveF.N_Tunisia = sum(SSM.Region == 5);

stats.dive.hotspot.diveF.median_Aegean = median(SSM.DivesPerDay(SSM.Region == 6),'omitnan');
stats.dive.hotspot.diveF.mad_Aegean = mad(SSM.DivesPerDay(SSM.Region == 6),1);
stats.dive.hotspot.diveF.N_Aegean = sum(SSM.Region == 6);

stats.dive.hotspot.diveF.median_Levantine = median(SSM.DivesPerDay(SSM.Region == 7),'omitnan');
stats.dive.hotspot.diveF.mad_Levantine = mad(SSM.DivesPerDay(SSM.Region == 7),1);
stats.dive.hotspot.diveF.N_Levantine = sum(SSM.Region == 7);

%% Dive Duration

stats.dive.hotspot.dur.median_Alboran = median(B.dives.duration(B.dives.hotspot == 1),'omitnan');
stats.dive.hotspot.dur.mad_Alboran = mad(B.dives.duration(B.dives.hotspot == 1),1);
stats.dive.hotspot.dur.N_Alboran = sum(B.dives.hotspot == 1);

stats.dive.hotspot.dur.median_WestMed = median(B.dives.duration(B.dives.hotspot == 2),'omitnan');
stats.dive.hotspot.dur.mad_WestMed = mad(B.dives.duration(B.dives.hotspot == 2),1);
stats.dive.hotspot.dur.N_WestMed = sum(B.dives.hotspot == 2);

stats.dive.hotspot.dur.median_Ionian = median(B.dives.duration(B.dives.hotspot == 4),'omitnan');
stats.dive.hotspot.dur.mad_Ionian = mad(B.dives.duration(B.dives.hotspot == 4),1);
stats.dive.hotspot.dur.N_Ionian = sum(B.dives.hotspot == 4);

stats.dive.hotspot.dur.median_Tunisia = median(B.dives.duration(B.dives.hotspot == 5),'omitnan');
stats.dive.hotspot.dur.mad_Tunisia = mad(B.dives.duration(B.dives.hotspot == 5),1);
stats.dive.hotspot.dur.N_Tunisia = sum(B.dives.hotspot == 5);

stats.dive.hotspot.dur.median_Aegean = median(B.dives.duration(B.dives.hotspot == 6),'omitnan');
stats.dive.hotspot.dur.mad_Aegean = mad(B.dives.duration(B.dives.hotspot == 6),1);
stats.dive.hotspot.dur.N_Aegean = sum(B.dives.hotspot == 6);

stats.dive.hotspot.dur.median_Levantine = median(B.dives.duration(B.dives.hotspot == 7),'omitnan');
stats.dive.hotspot.dur.mad_Levantine = mad(B.dives.duration(B.dives.hotspot == 7),1);
stats.dive.hotspot.dur.N_Levantine = sum(B.dives.hotspot == 7);

%% Descent Rate

stats.dive.hotspot.descent.median_Alboran = median(B.dives.max_descent(B.dives.hotspot == 1),'omitnan');
stats.dive.hotspot.descent.mad_Alboran = mad(B.dives.max_descent(B.dives.hotspot == 1),1);
stats.dive.hotspot.descent.N_Alboran = sum(B.dives.hotspot == 1);

stats.dive.hotspot.descent.median_WestMed = median(B.dives.max_descent(B.dives.hotspot == 2),'omitnan');
stats.dive.hotspot.descent.mad_WestMed = mad(B.dives.max_descent(B.dives.hotspot == 2),1);
stats.dive.hotspot.descent.N_WestMed = sum(B.dives.hotspot == 2);

stats.dive.hotspot.descent.median_Ionian = median(B.dives.max_descent(B.dives.hotspot == 4),'omitnan');
stats.dive.hotspot.descent.mad_Ionian = mad(B.dives.max_descent(B.dives.hotspot == 4),1);
stats.dive.hotspot.descent.N_Ionian = sum(B.dives.hotspot == 4);

stats.dive.hotspot.descent.median_Tunisia = median(B.dives.max_descent(B.dives.hotspot == 5),'omitnan');
stats.dive.hotspot.descent.mad_Tunisia = mad(B.dives.max_descent(B.dives.hotspot == 5),1);
stats.dive.hotspot.descent.N_Tunisia = sum(B.dives.hotspot == 5);

stats.dive.hotspot.descent.median_Aegean = median(B.dives.max_descent(B.dives.hotspot == 6),'omitnan');
stats.dive.hotspot.descent.mad_Aegean = mad(B.dives.max_descent(B.dives.hotspot == 6),1);
stats.dive.hotspot.descent.N_Aegean = sum(B.dives.hotspot == 6);

stats.dive.hotspot.descent.median_Levantine = median(B.dives.max_descent(B.dives.hotspot == 7),'omitnan');
stats.dive.hotspot.descent.mad_Levantine = mad(B.dives.max_descent(B.dives.hotspot == 7),1);
stats.dive.hotspot.descent.N_Levantine = sum(B.dives.hotspot == 7);

%% Day Depth

stats.dive.hotspot.dayD.median_Alboran = median(SSM.MedDayDepth(SSM.Region == 1),'omitnan');
stats.dive.hotspot.dayD.mad_Alboran = mad(SSM.MedDayDepth(SSM.Region == 1),1);
stats.dive.hotspot.dayD.N_Alboran = sum(SSM.Region == 1);

stats.dive.hotspot.dayD.median_WestMed = median(SSM.MedDayDepth(SSM.Region == 2),'omitnan');
stats.dive.hotspot.dayD.mad_WestMed = mad(SSM.MedDayDepth(SSM.Region == 2),1);
stats.dive.hotspot.dayD.N_WestMed = sum(SSM.Region == 2);

stats.dive.hotspot.dayD.median_Ionian = median(SSM.MedDayDepth(SSM.Region == 4),'omitnan');
stats.dive.hotspot.dayD.mad_Ionian = mad(SSM.MedDayDepth(SSM.Region == 4),1);
stats.dive.hotspot.dayD.N_Ionian = sum(SSM.Region == 4);

stats.dive.hotspot.dayD.median_Tunisia = median(SSM.MedDayDepth(SSM.Region == 5),'omitnan');
stats.dive.hotspot.dayD.mad_Tunisia = mad(SSM.MedDayDepth(SSM.Region == 5),1);
stats.dive.hotspot.dayD.N_Tunisia = sum(SSM.Region == 5);

stats.dive.hotspot.dayD.median_Aegean = median(SSM.MedDayDepth(SSM.Region == 6),'omitnan');
stats.dive.hotspot.dayD.mad_Aegean = mad(SSM.MedDayDepth(SSM.Region == 6),1);
stats.dive.hotspot.dayD.N_Aegean = sum(SSM.Region == 6);

stats.dive.hotspot.dayD.median_Levantine = median(SSM.MedDayDepth(SSM.Region == 7),'omitnan');
stats.dive.hotspot.dayD.mad_Levantine = mad(SSM.MedDayDepth(SSM.Region == 7),1);
stats.dive.hotspot.dayD.N_Levantine = sum(SSM.Region == 7);

%% Night Depth

stats.dive.hotspot.nightD.median_Alboran = median(SSM.MedNigDepth(SSM.Region == 1),'omitnan');
stats.dive.hotspot.nightD.mad_Alboran = mad(SSM.MedNigDepth(SSM.Region == 1),1);
stats.dive.hotspot.nightD.N_Alboran = sum(SSM.Region == 1);

stats.dive.hotspot.nightD.median_WestMed = median(SSM.MedNigDepth(SSM.Region == 2),'omitnan');
stats.dive.hotspot.nightD.mad_WestMed = mad(SSM.MedNigDepth(SSM.Region == 2),1);
stats.dive.hotspot.nightD.N_WestMed = sum(SSM.Region == 2);

stats.dive.hotspot.nightD.median_Ionian = median(SSM.MedNigDepth(SSM.Region == 4),'omitnan');
stats.dive.hotspot.nightD.mad_Ionian = mad(SSM.MedNigDepth(SSM.Region == 4),1);
stats.dive.hotspot.nightD.N_Ionian = sum(SSM.Region == 4);

stats.dive.hotspot.nightD.median_Tunisia = median(SSM.MedNigDepth(SSM.Region == 5),'omitnan');
stats.dive.hotspot.nightD.mad_Tunisia = mad(SSM.MedNigDepth(SSM.Region == 5),1);
stats.dive.hotspot.nightD.N_Tunisia = sum(SSM.Region == 5);

stats.dive.hotspot.nightD.median_Aegean = median(SSM.MedNigDepth(SSM.Region == 6),'omitnan');
stats.dive.hotspot.nightD.mad_Aegean = mad(SSM.MedNigDepth(SSM.Region == 6),1);
stats.dive.hotspot.nightD.N_Aegean = sum(SSM.Region == 6);

stats.dive.hotspot.nightD.median_Levantine = median(SSM.MedNigDepth(SSM.Region == 7),'omitnan');
stats.dive.hotspot.nightD.mad_Levantine = mad(SSM.MedNigDepth(SSM.Region == 7),1);
stats.dive.hotspot.nightD.N_Levantine = sum(SSM.Region == 7);

%% Daily Max Depth

stats.dive.hotspot.maxD.median_Alboran = median(SSM.max_Depth(SSM.Region == 1),'omitnan');
stats.dive.hotspot.maxD.mad_Alboran = mad(SSM.max_Depth(SSM.Region == 1),1);
stats.dive.hotspot.maxD.N_Alboran = sum(SSM.Region == 1);

stats.dive.hotspot.maxD.median_WestMed = median(SSM.max_Depth(SSM.Region == 2),'omitnan');
stats.dive.hotspot.maxD.mad_WestMed = mad(SSM.max_Depth(SSM.Region == 2),1);
stats.dive.hotspot.maxD.N_WestMed = sum(SSM.Region == 2);

stats.dive.hotspot.maxD.median_Ionian = median(SSM.max_Depth(SSM.Region == 4),'omitnan');
stats.dive.hotspot.maxD.mad_Ionian = mad(SSM.max_Depth(SSM.Region == 4),1);
stats.dive.hotspot.maxD.N_Ionian = sum(SSM.Region == 4);

stats.dive.hotspot.maxD.median_Tunisia = median(SSM.max_Depth(SSM.Region == 5),'omitnan');
stats.dive.hotspot.maxD.mad_Tunisia = mad(SSM.max_Depth(SSM.Region == 5),1);
stats.dive.hotspot.maxD.N_Tunisia = sum(SSM.Region == 5);

stats.dive.hotspot.maxD.median_Aegean = median(SSM.max_Depth(SSM.Region == 6),'omitnan');
stats.dive.hotspot.maxD.mad_Aegean = mad(SSM.max_Depth(SSM.Region == 6),1);
stats.dive.hotspot.maxD.N_Aegean = sum(SSM.Region == 6);

stats.dive.hotspot.maxD.median_Levantine = median(SSM.max_Depth(SSM.Region == 7),'omitnan');
stats.dive.hotspot.maxD.mad_Levantine = mad(SSM.max_Depth(SSM.Region == 7),1);
stats.dive.hotspot.maxD.N_Levantine = sum(SSM.Region == 7);

%% % Time in Depth

stats.dive.hotspot.meso.median_Alboran = median(SSM.TimeinMeso(SSM.Region == 1),'omitnan');
stats.dive.hotspot.meso.mad_Alboran = mad(SSM.TimeinMeso(SSM.Region == 1),1);
stats.dive.hotspot.meso.N_Alboran = sum(SSM.Region == 1);

stats.dive.hotspot.meso.median_WestMed = median(SSM.TimeinMeso(SSM.Region == 2),'omitnan');
stats.dive.hotspot.meso.mad_WestMed = mad(SSM.TimeinMeso(SSM.Region == 2),1);
stats.dive.hotspot.meso.N_WestMed = sum(SSM.Region == 2);

stats.dive.hotspot.meso.median_Ionian = median(SSM.TimeinMeso(SSM.Region == 4),'omitnan');
stats.dive.hotspot.meso.mad_Ionian = mad(SSM.TimeinMeso(SSM.Region == 4),1);
stats.dive.hotspot.meso.N_Ionian = sum(SSM.Region == 4);

stats.dive.hotspot.meso.median_Tunisia = median(SSM.TimeinMeso(SSM.Region == 5),'omitnan');
stats.dive.hotspot.meso.mad_Tunisia = mad(SSM.TimeinMeso(SSM.Region == 5),1);
stats.dive.hotspot.meso.N_Tunisia = sum(SSM.Region == 5);

stats.dive.hotspot.meso.median_Aegean = median(SSM.TimeinMeso(SSM.Region == 6),'omitnan');
stats.dive.hotspot.meso.mad_Aegean = mad(SSM.TimeinMeso(SSM.Region == 6),1);
stats.dive.hotspot.meso.N_Aegean = sum(SSM.Region == 6);

stats.dive.hotspot.meso.median_Levantine = median(SSM.TimeinMeso(SSM.Region == 7),'omitnan');
stats.dive.hotspot.meso.mad_Levantine = mad(SSM.TimeinMeso(SSM.Region == 7),1);
stats.dive.hotspot.meso.N_Levantine = sum(SSM.Region == 7);