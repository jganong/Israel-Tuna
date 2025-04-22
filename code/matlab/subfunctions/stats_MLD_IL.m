%% stats_MLD_IL.m
% Sub-function of IsraelTuna; calculate statistics for mixed layer depth 
% and sea surface temperature in each region and season.

% Hotspots
% 0 = Outside of the Ionian
% 1 = Alboran Sea
% 2 = Western Med
% 3 = Adriatic Sea
% 4 = Ionian Sea
% 5 = Tunisian Plateau/Gulf of Sidra
% 6 = Aegean Sea
% 7 = Levantine Sea

%% SST

stats.SST.Alboran.Fall.median = median(oce.SST(oce.region == 1 & oce.season == 1),'omitnan');
stats.SST.Alboran.Fall.mad = mad(oce.SST(oce.region == 1 & oce.season == 1),1);
stats.SST.Alboran.Fall.min = min(oce.SST(oce.region == 1 & oce.season == 1));
stats.SST.Alboran.Fall.max = max(oce.SST(oce.region == 1 & oce.season == 1));

stats.SST.Alboran.Winter.median = median(oce.SST(oce.region == 1 & oce.season == 2),'omitnan');
stats.SST.Alboran.Winter.mad = mad(oce.SST(oce.region == 1 & oce.season == 2),1);
stats.SST.Alboran.Winter.min = min(oce.SST(oce.region == 1 & oce.season == 2));
stats.SST.Alboran.Winter.max = max(oce.SST(oce.region == 1 & oce.season == 2));

stats.SST.Alboran.Spring.median = median(oce.SST(oce.region == 1 & oce.season == 3),'omitnan');
stats.SST.Alboran.Spring.mad = mad(oce.SST(oce.region == 1 & oce.season == 3),1);
stats.SST.Alboran.Spring.min = min(oce.SST(oce.region == 1 & oce.season == 3));
stats.SST.Alboran.Spring.max = max(oce.SST(oce.region == 1 & oce.season == 3));

stats.SST.Alboran.Summer.median = median(oce.SST(oce.region == 1 & oce.season == 4),'omitnan');
stats.SST.Alboran.Summer.mad = mad(oce.SST(oce.region == 1 & oce.season == 4),1);
stats.SST.Alboran.Summer.min = min(oce.SST(oce.region == 1 & oce.season == 4));
stats.SST.Alboran.Summer.max = max(oce.SST(oce.region == 1 & oce.season == 4));

stats.SST.WesternMed.Fall.median = median(oce.SST(oce.region == 2 & oce.season == 1),'omitnan');
stats.SST.WesternMed.Fall.mad = mad(oce.SST(oce.region == 2 & oce.season == 1),1);
stats.SST.WesternMed.Fall.min = min(oce.SST(oce.region == 2 & oce.season == 1));
stats.SST.WesternMed.Fall.max = max(oce.SST(oce.region == 2 & oce.season == 1));

stats.SST.WesternMed.Winter.median = median(oce.SST(oce.region == 2 & oce.season == 2),'omitnan');
stats.SST.WesternMed.Winter.mad = mad(oce.SST(oce.region == 2 & oce.season == 2),1);
stats.SST.WesternMed.Winter.min = min(oce.SST(oce.region == 2 & oce.season == 2));
stats.SST.WesternMed.Winter.max = max(oce.SST(oce.region == 2 & oce.season == 2));

stats.SST.WesternMed.Spring.median = median(oce.SST(oce.region == 2 & oce.season == 3),'omitnan');
stats.SST.WesternMed.Spring.mad = mad(oce.SST(oce.region == 2 & oce.season == 3),1);
stats.SST.WesternMed.Spring.min = min(oce.SST(oce.region == 2 & oce.season == 3));
stats.SST.WesternMed.Spring.max = max(oce.SST(oce.region == 2 & oce.season == 3));

stats.SST.WesternMed.Summer.median = median(oce.SST(oce.region == 2 & oce.season == 4),'omitnan');
stats.SST.WesternMed.Summer.mad = mad(oce.SST(oce.region == 2 & oce.season == 4),1);
stats.SST.WesternMed.Summer.min = min(oce.SST(oce.region == 2 & oce.season == 4));
stats.SST.WesternMed.Summer.max = max(oce.SST(oce.region == 2 & oce.season == 4));

stats.SST.Adriatic.Fall.median = median(oce.SST(oce.region == 3 & oce.season == 1),'omitnan');
stats.SST.Adriatic.Fall.mad = mad(oce.SST(oce.region == 3 & oce.season == 1),1);
stats.SST.Adriatic.Fall.min = min(oce.SST(oce.region == 3 & oce.season == 1));
stats.SST.Adriatic.Fall.max = max(oce.SST(oce.region == 3 & oce.season == 1));

stats.SST.Adriatic.Winter.median = median(oce.SST(oce.region == 3 & oce.season == 2),'omitnan');
stats.SST.Adriatic.Winter.mad = mad(oce.SST(oce.region == 3 & oce.season == 2),1);
stats.SST.Adriatic.Winter.min = min(oce.SST(oce.region == 3 & oce.season == 2));
stats.SST.Adriatic.Winter.max = max(oce.SST(oce.region == 3 & oce.season == 2));

stats.SST.Adriatic.Spring.median = median(oce.SST(oce.region == 3 & oce.season == 3),'omitnan');
stats.SST.Adriatic.Spring.mad = mad(oce.SST(oce.region == 3 & oce.season == 3),1);
stats.SST.Adriatic.Spring.min = min(oce.SST(oce.region == 3 & oce.season == 3));
stats.SST.Adriatic.Spring.max = max(oce.SST(oce.region == 3 & oce.season == 3));

stats.SST.Adriatic.Summer.median = median(oce.SST(oce.region == 3 & oce.season == 4),'omitnan');
stats.SST.Adriatic.Summer.mad = mad(oce.SST(oce.region == 3 & oce.season == 4),1);
stats.SST.Adriatic.Summer.min = min(oce.SST(oce.region == 3 & oce.season == 4));
stats.SST.Adriatic.Summer.max = max(oce.SST(oce.region == 3 & oce.season == 4));

stats.SST.Ionian.Fall.median = median(oce.SST(oce.region == 4 & oce.season == 1),'omitnan');
stats.SST.Ionian.Fall.mad = mad(oce.SST(oce.region == 4 & oce.season == 1),1);
stats.SST.Ionian.Fall.min = min(oce.SST(oce.region == 4 & oce.season == 1));
stats.SST.Ionian.Fall.max = max(oce.SST(oce.region == 4 & oce.season == 1));

stats.SST.Ionian.Winter.median = median(oce.SST(oce.region == 4 & oce.season == 2),'omitnan');
stats.SST.Ionian.Winter.mad = mad(oce.SST(oce.region == 4 & oce.season == 2),1);
stats.SST.Ionian.Winter.min = min(oce.SST(oce.region == 4 & oce.season == 2));
stats.SST.Ionian.Winter.max = max(oce.SST(oce.region == 4 & oce.season == 2));

stats.SST.Ionian.Spring.median = median(oce.SST(oce.region == 4 & oce.season == 3),'omitnan');
stats.SST.Ionian.Spring.mad = mad(oce.SST(oce.region == 4 & oce.season == 3),1);
stats.SST.Ionian.Spring.min = min(oce.SST(oce.region == 4 & oce.season == 3));
stats.SST.Ionian.Spring.max = max(oce.SST(oce.region == 4 & oce.season == 3));

stats.SST.Ionian.Summer.median = median(oce.SST(oce.region == 4 & oce.season == 4),'omitnan');
stats.SST.Ionian.Summer.mad = mad(oce.SST(oce.region == 4 & oce.season == 4),1);
stats.SST.Ionian.Summer.min = min(oce.SST(oce.region == 4 & oce.season == 4));
stats.SST.Ionian.Summer.max = max(oce.SST(oce.region == 4 & oce.season == 4));

stats.SST.TunisianSidra.Fall.median = median(oce.SST(oce.region == 5 & oce.season == 1),'omitnan');
stats.SST.TunisianSidra.Fall.mad = mad(oce.SST(oce.region == 5 & oce.season == 1),1);
stats.SST.TunisianSidra.Fall.min = min(oce.SST(oce.region == 5 & oce.season == 1));
stats.SST.TunisianSidra.Fall.max = max(oce.SST(oce.region == 5 & oce.season == 1));

stats.SST.TunisianSidra.Winter.median = median(oce.SST(oce.region == 5 & oce.season == 2),'omitnan');
stats.SST.TunisianSidra.Winter.mad = mad(oce.SST(oce.region == 5 & oce.season == 2),1);
stats.SST.TunisianSidra.Winter.min = min(oce.SST(oce.region == 5 & oce.season == 2));
stats.SST.TunisianSidra.Winter.max = max(oce.SST(oce.region == 5 & oce.season == 2));

stats.SST.TunisianSidra.Spring.median = median(oce.SST(oce.region == 5 & oce.season == 3),'omitnan');
stats.SST.TunisianSidra.Spring.mad = mad(oce.SST(oce.region == 5 & oce.season == 3),1);
stats.SST.TunisianSidra.Spring.min = min(oce.SST(oce.region == 5 & oce.season == 3));
stats.SST.TunisianSidra.Spring.max = max(oce.SST(oce.region == 5 & oce.season == 3));

stats.SST.TunisianSidra.Summer.median = median(oce.SST(oce.region == 5 & oce.season == 4),'omitnan');
stats.SST.TunisianSidra.Summer.mad = mad(oce.SST(oce.region == 5 & oce.season == 4),1);
stats.SST.TunisianSidra.Summer.min = min(oce.SST(oce.region == 5 & oce.season == 4));
stats.SST.TunisianSidra.Summer.max = max(oce.SST(oce.region == 5 & oce.season == 4));

stats.SST.Aegean.Fall.median = median(oce.SST(oce.region == 6 & oce.season == 1),'omitnan');
stats.SST.Aegean.Fall.mad = mad(oce.SST(oce.region == 6 & oce.season == 1),1);
stats.SST.Aegean.Fall.min = min(oce.SST(oce.region == 6 & oce.season == 1));
stats.SST.Aegean.Fall.max = max(oce.SST(oce.region == 6 & oce.season == 1));

stats.SST.Aegean.Winter.median = median(oce.SST(oce.region == 6 & oce.season == 2),'omitnan');
stats.SST.Aegean.Winter.mad = mad(oce.SST(oce.region == 6 & oce.season == 2),1);
stats.SST.Aegean.Winter.min = min(oce.SST(oce.region == 6 & oce.season == 2));
stats.SST.Aegean.Winter.max = max(oce.SST(oce.region == 6 & oce.season == 2));

stats.SST.Aegean.Spring.median = median(oce.SST(oce.region == 6 & oce.season == 3),'omitnan');
stats.SST.Aegean.Spring.mad = mad(oce.SST(oce.region == 6 & oce.season == 3),1);
stats.SST.Aegean.Spring.min = min(oce.SST(oce.region == 6 & oce.season == 3));
stats.SST.Aegean.Spring.max = max(oce.SST(oce.region == 6 & oce.season == 3));

stats.SST.Aegean.Summer.median = median(oce.SST(oce.region == 6 & oce.season == 4),'omitnan');
stats.SST.Aegean.Summer.mad = mad(oce.SST(oce.region == 6 & oce.season == 4),1);
stats.SST.Aegean.Summer.min = min(oce.SST(oce.region == 6 & oce.season == 4));
stats.SST.Aegean.Summer.max = max(oce.SST(oce.region == 6 & oce.season == 4));

stats.SST.Levantine.Fall.median = median(oce.SST(oce.region == 7 & oce.season == 1),'omitnan');
stats.SST.Levantine.Fall.mad = mad(oce.SST(oce.region == 7 & oce.season == 1),1);
stats.SST.Levantine.Fall.min = min(oce.SST(oce.region == 7 & oce.season == 1));
stats.SST.Levantine.Fall.max = max(oce.SST(oce.region == 7 & oce.season == 1));

stats.SST.Levantine.Winter.median = median(oce.SST(oce.region == 7 & oce.season == 2),'omitnan');
stats.SST.Levantine.Winter.mad = mad(oce.SST(oce.region == 7 & oce.season == 2),1);
stats.SST.Levantine.Winter.min = min(oce.SST(oce.region == 7 & oce.season == 2));
stats.SST.Levantine.Winter.max = max(oce.SST(oce.region == 7 & oce.season == 2));

stats.SST.Levantine.Spring.median = median(oce.SST(oce.region == 7 & oce.season == 3),'omitnan');
stats.SST.Levantine.Spring.mad = mad(oce.SST(oce.region == 7 & oce.season == 3),1);
stats.SST.Levantine.Spring.min = min(oce.SST(oce.region == 7 & oce.season == 3));
stats.SST.Levantine.Spring.max = max(oce.SST(oce.region == 7 & oce.season == 3));

stats.SST.Levantine.Summer.median = median(oce.SST(oce.region == 7 & oce.season == 4),'omitnan');
stats.SST.Levantine.Summer.mad = mad(oce.SST(oce.region == 7 & oce.season == 4),1);
stats.SST.Levantine.Summer.min = min(oce.SST(oce.region == 7 & oce.season == 4));
stats.SST.Levantine.Summer.max = max(oce.SST(oce.region == 7 & oce.season == 4));

%% MLD

stats.mld.Alboran.Fall.median = median(oce.mld(oce.region == 1 & oce.season == 1),'omitnan');
stats.mld.Alboran.Fall.mad = mad(oce.mld(oce.region == 1 & oce.season == 1),1);
stats.mld.Alboran.Fall.min = min(oce.mld(oce.region == 1 & oce.season == 1));
stats.mld.Alboran.Fall.max = max(oce.mld(oce.region == 1 & oce.season == 1));

stats.mld.Alboran.Winter.median = median(oce.mld(oce.region == 1 & oce.season == 2),'omitnan');
stats.mld.Alboran.Winter.mad = mad(oce.mld(oce.region == 1 & oce.season == 2),1);
stats.mld.Alboran.Winter.min = min(oce.mld(oce.region == 1 & oce.season == 2));
stats.mld.Alboran.Winter.max = max(oce.mld(oce.region == 1 & oce.season == 2));

stats.mld.Alboran.Spring.median = median(oce.mld(oce.region == 1 & oce.season == 3),'omitnan');
stats.mld.Alboran.Spring.mad = mad(oce.mld(oce.region == 1 & oce.season == 3),1);
stats.mld.Alboran.Spring.min = min(oce.mld(oce.region == 1 & oce.season == 3));
stats.mld.Alboran.Spring.max = max(oce.mld(oce.region == 1 & oce.season == 3));

stats.mld.Alboran.Summer.median = median(oce.mld(oce.region == 1 & oce.season == 4),'omitnan');
stats.mld.Alboran.Summer.mad = mad(oce.mld(oce.region == 1 & oce.season == 4),1);
stats.mld.Alboran.Summer.min = min(oce.mld(oce.region == 1 & oce.season == 4));
stats.mld.Alboran.Summer.max = max(oce.mld(oce.region == 1 & oce.season == 4));

stats.mld.WesternMed.Fall.median = median(oce.mld(oce.region == 2 & oce.season == 1),'omitnan');
stats.mld.WesternMed.Fall.mad = mad(oce.mld(oce.region == 2 & oce.season == 1),1);
stats.mld.WesternMed.Fall.min = min(oce.mld(oce.region == 2 & oce.season == 1));
stats.mld.WesternMed.Fall.max = max(oce.mld(oce.region == 2 & oce.season == 1));

stats.mld.WesternMed.Winter.median = median(oce.mld(oce.region == 2 & oce.season == 2),'omitnan');
stats.mld.WesternMed.Winter.mad = mad(oce.mld(oce.region == 2 & oce.season == 2),1);
stats.mld.WesternMed.Winter.min = min(oce.mld(oce.region == 2 & oce.season == 2));
stats.mld.WesternMed.Winter.max = max(oce.mld(oce.region == 2 & oce.season == 2));

stats.mld.WesternMed.Spring.median = median(oce.mld(oce.region == 2 & oce.season == 3),'omitnan');
stats.mld.WesternMed.Spring.mad = mad(oce.mld(oce.region == 2 & oce.season == 3),1);
stats.mld.WesternMed.Spring.min = min(oce.mld(oce.region == 2 & oce.season == 3));
stats.mld.WesternMed.Spring.max = max(oce.mld(oce.region == 2 & oce.season == 3));

stats.mld.WesternMed.Summer.median = median(oce.mld(oce.region == 2 & oce.season == 4),'omitnan');
stats.mld.WesternMed.Summer.mad = mad(oce.mld(oce.region == 2 & oce.season == 4),1);
stats.mld.WesternMed.Summer.min = min(oce.mld(oce.region == 2 & oce.season == 4));
stats.mld.WesternMed.Summer.max = max(oce.mld(oce.region == 2 & oce.season == 4));

stats.mld.Adriatic.Fall.median = median(oce.mld(oce.region == 3 & oce.season == 1),'omitnan');
stats.mld.Adriatic.Fall.mad = mad(oce.mld(oce.region == 3 & oce.season == 1),1);
stats.mld.Adriatic.Fall.min = min(oce.mld(oce.region == 3 & oce.season == 1));
stats.mld.Adriatic.Fall.max = max(oce.mld(oce.region == 3 & oce.season == 1));

stats.mld.Adriatic.Winter.median = median(oce.mld(oce.region == 3 & oce.season == 2),'omitnan');
stats.mld.Adriatic.Winter.mad = mad(oce.mld(oce.region == 3 & oce.season == 2),1);
stats.mld.Adriatic.Winter.min = min(oce.mld(oce.region == 3 & oce.season == 2));
stats.mld.Adriatic.Winter.max = max(oce.mld(oce.region == 3 & oce.season == 2));

stats.mld.Adriatic.Spring.median = median(oce.mld(oce.region == 3 & oce.season == 3),'omitnan');
stats.mld.Adriatic.Spring.mad = mad(oce.mld(oce.region == 3 & oce.season == 3),1);
stats.mld.Adriatic.Spring.min = min(oce.mld(oce.region == 3 & oce.season == 3));
stats.mld.Adriatic.Spring.max = max(oce.mld(oce.region == 3 & oce.season == 3));

stats.mld.Adriatic.Summer.median = median(oce.mld(oce.region == 3 & oce.season == 4),'omitnan');
stats.mld.Adriatic.Summer.mad = mad(oce.mld(oce.region == 3 & oce.season == 4),1);
stats.mld.Adriatic.Summer.min = min(oce.mld(oce.region == 3 & oce.season == 4));
stats.mld.Adriatic.Summer.max = max(oce.mld(oce.region == 3 & oce.season == 4));

stats.mld.Ionian.Fall.median = median(oce.mld(oce.region == 4 & oce.season == 1),'omitnan');
stats.mld.Ionian.Fall.mad = mad(oce.mld(oce.region == 4 & oce.season == 1),1);
stats.mld.Ionian.Fall.min = min(oce.mld(oce.region == 4 & oce.season == 1));
stats.mld.Ionian.Fall.max = max(oce.mld(oce.region == 4 & oce.season == 1));

stats.mld.Ionian.Winter.median = median(oce.mld(oce.region == 4 & oce.season == 2),'omitnan');
stats.mld.Ionian.Winter.mad = mad(oce.mld(oce.region == 4 & oce.season == 2),1);
stats.mld.Ionian.Winter.min = min(oce.mld(oce.region == 4 & oce.season == 2));
stats.mld.Ionian.Winter.max = max(oce.mld(oce.region == 4 & oce.season == 2));

stats.mld.Ionian.Spring.median = median(oce.mld(oce.region == 4 & oce.season == 3),'omitnan');
stats.mld.Ionian.Spring.mad = mad(oce.mld(oce.region == 4 & oce.season == 3),1);
stats.mld.Ionian.Spring.min = min(oce.mld(oce.region == 4 & oce.season == 3));
stats.mld.Ionian.Spring.max = max(oce.mld(oce.region == 4 & oce.season == 3));

stats.mld.Ionian.Summer.median = median(oce.mld(oce.region == 4 & oce.season == 4),'omitnan');
stats.mld.Ionian.Summer.mad = mad(oce.mld(oce.region == 4 & oce.season == 4),1);
stats.mld.Ionian.Summer.min = min(oce.mld(oce.region == 4 & oce.season == 4));
stats.mld.Ionian.Summer.max = max(oce.mld(oce.region == 4 & oce.season == 4));

stats.mld.TunisianSidra.Fall.median = median(oce.mld(oce.region == 5 & oce.season == 1),'omitnan');
stats.mld.TunisianSidra.Fall.mad = mad(oce.mld(oce.region == 5 & oce.season == 1),1);
stats.mld.TunisianSidra.Fall.min = min(oce.mld(oce.region == 5 & oce.season == 1));
stats.mld.TunisianSidra.Fall.max = max(oce.mld(oce.region == 5 & oce.season == 1));

stats.mld.TunisianSidra.Winter.median = median(oce.mld(oce.region == 5 & oce.season == 2),'omitnan');
stats.mld.TunisianSidra.Winter.mad = mad(oce.mld(oce.region == 5 & oce.season == 2),1);
stats.mld.TunisianSidra.Winter.min = min(oce.mld(oce.region == 5 & oce.season == 2));
stats.mld.TunisianSidra.Winter.max = max(oce.mld(oce.region == 5 & oce.season == 2));

stats.mld.TunisianSidra.Spring.median = median(oce.mld(oce.region == 5 & oce.season == 3),'omitnan');
stats.mld.TunisianSidra.Spring.mad = mad(oce.mld(oce.region == 5 & oce.season == 3),1);
stats.mld.TunisianSidra.Spring.min = min(oce.mld(oce.region == 5 & oce.season == 3));
stats.mld.TunisianSidra.Spring.max = max(oce.mld(oce.region == 5 & oce.season == 3));

stats.mld.TunisianSidra.Summer.median = median(oce.mld(oce.region == 5 & oce.season == 4),'omitnan');
stats.mld.TunisianSidra.Summer.mad = mad(oce.mld(oce.region == 5 & oce.season == 4),1);
stats.mld.TunisianSidra.Summer.min = min(oce.mld(oce.region == 5 & oce.season == 4));
stats.mld.TunisianSidra.Summer.max = max(oce.mld(oce.region == 5 & oce.season == 4));

stats.mld.Aegean.Fall.median = median(oce.mld(oce.region == 6 & oce.season == 1),'omitnan');
stats.mld.Aegean.Fall.mad = mad(oce.mld(oce.region == 6 & oce.season == 1),1);
stats.mld.Aegean.Fall.min = min(oce.mld(oce.region == 6 & oce.season == 1));
stats.mld.Aegean.Fall.max = max(oce.mld(oce.region == 6 & oce.season == 1));

stats.mld.Aegean.Winter.median = median(oce.mld(oce.region == 6 & oce.season == 2),'omitnan');
stats.mld.Aegean.Winter.mad = mad(oce.mld(oce.region == 6 & oce.season == 2),1);
stats.mld.Aegean.Winter.min = min(oce.mld(oce.region == 6 & oce.season == 2));
stats.mld.Aegean.Winter.max = max(oce.mld(oce.region == 6 & oce.season == 2));

stats.mld.Aegean.Spring.median = median(oce.mld(oce.region == 6 & oce.season == 3),'omitnan');
stats.mld.Aegean.Spring.mad = mad(oce.mld(oce.region == 6 & oce.season == 3),1);
stats.mld.Aegean.Spring.min = min(oce.mld(oce.region == 6 & oce.season == 3));
stats.mld.Aegean.Spring.max = max(oce.mld(oce.region == 6 & oce.season == 3));

stats.mld.Aegean.Summer.median = median(oce.mld(oce.region == 6 & oce.season == 4),'omitnan');
stats.mld.Aegean.Summer.mad = mad(oce.mld(oce.region == 6 & oce.season == 4),1);
stats.mld.Aegean.Summer.min = min(oce.mld(oce.region == 6 & oce.season == 4));
stats.mld.Aegean.Summer.max = max(oce.mld(oce.region == 6 & oce.season == 4));

stats.mld.Levantine.Fall.median = median(oce.mld(oce.region == 7 & oce.season == 1),'omitnan');
stats.mld.Levantine.Fall.mad = mad(oce.mld(oce.region == 7 & oce.season == 1),1);
stats.mld.Levantine.Fall.min = min(oce.mld(oce.region == 7 & oce.season == 1));
stats.mld.Levantine.Fall.max = max(oce.mld(oce.region == 7 & oce.season == 1));

stats.mld.Levantine.Winter.median = median(oce.mld(oce.region == 7 & oce.season == 2),'omitnan');
stats.mld.Levantine.Winter.mad = mad(oce.mld(oce.region == 7 & oce.season == 2),1);
stats.mld.Levantine.Winter.min = min(oce.mld(oce.region == 7 & oce.season == 2));
stats.mld.Levantine.Winter.max = max(oce.mld(oce.region == 7 & oce.season == 2));

stats.mld.Levantine.Spring.median = median(oce.mld(oce.region == 7 & oce.season == 3),'omitnan');
stats.mld.Levantine.Spring.mad = mad(oce.mld(oce.region == 7 & oce.season == 3),1);
stats.mld.Levantine.Spring.min = min(oce.mld(oce.region == 7 & oce.season == 3));
stats.mld.Levantine.Spring.max = max(oce.mld(oce.region == 7 & oce.season == 3));

stats.mld.Levantine.Summer.median = median(oce.mld(oce.region == 7 & oce.season == 4),'omitnan');
stats.mld.Levantine.Summer.mad = mad(oce.mld(oce.region == 7 & oce.season == 4),1);
stats.mld.Levantine.Summer.min = min(oce.mld(oce.region == 7 & oce.season == 4));
stats.mld.Levantine.Summer.max = max(oce.mld(oce.region == 7 & oce.season == 4));

%% T @ MLD

stats.T_at_mld.Alboran.Fall.median = median(oce.T_at_mld(oce.region == 1 & oce.season == 1),'omitnan');
stats.T_at_mld.Alboran.Fall.mad = mad(oce.T_at_mld(oce.region == 1 & oce.season == 1),1);
stats.T_at_mld.Alboran.Fall.min = min(oce.T_at_mld(oce.region == 1 & oce.season == 1));
stats.T_at_mld.Alboran.Fall.max = max(oce.T_at_mld(oce.region == 1 & oce.season == 1));

stats.T_at_mld.Alboran.Winter.median = median(oce.T_at_mld(oce.region == 1 & oce.season == 2),'omitnan');
stats.T_at_mld.Alboran.Winter.mad = mad(oce.T_at_mld(oce.region == 1 & oce.season == 2),1);
stats.T_at_mld.Alboran.Winter.min = min(oce.T_at_mld(oce.region == 1 & oce.season == 2));
stats.T_at_mld.Alboran.Winter.max = max(oce.T_at_mld(oce.region == 1 & oce.season == 2));

stats.T_at_mld.Alboran.Spring.median = median(oce.T_at_mld(oce.region == 1 & oce.season == 3),'omitnan');
stats.T_at_mld.Alboran.Spring.mad = mad(oce.T_at_mld(oce.region == 1 & oce.season == 3),1);
stats.T_at_mld.Alboran.Spring.min = min(oce.T_at_mld(oce.region == 1 & oce.season == 3));
stats.T_at_mld.Alboran.Spring.max = max(oce.T_at_mld(oce.region == 1 & oce.season == 3));

stats.T_at_mld.Alboran.Summer.median = median(oce.T_at_mld(oce.region == 1 & oce.season == 4),'omitnan');
stats.T_at_mld.Alboran.Summer.mad = mad(oce.T_at_mld(oce.region == 1 & oce.season == 4),1);
stats.T_at_mld.Alboran.Summer.min = min(oce.T_at_mld(oce.region == 1 & oce.season == 4));
stats.T_at_mld.Alboran.Summer.max = max(oce.T_at_mld(oce.region == 1 & oce.season == 4));

stats.T_at_mld.WesternMed.Fall.median = median(oce.T_at_mld(oce.region == 2 & oce.season == 1),'omitnan');
stats.T_at_mld.WesternMed.Fall.mad = mad(oce.T_at_mld(oce.region == 2 & oce.season == 1),1);
stats.T_at_mld.WesternMed.Fall.min = min(oce.T_at_mld(oce.region == 2 & oce.season == 1));
stats.T_at_mld.WesternMed.Fall.max = max(oce.T_at_mld(oce.region == 2 & oce.season == 1));

stats.T_at_mld.WesternMed.Winter.median = median(oce.T_at_mld(oce.region == 2 & oce.season == 2),'omitnan');
stats.T_at_mld.WesternMed.Winter.mad = mad(oce.T_at_mld(oce.region == 2 & oce.season == 2),1);
stats.T_at_mld.WesternMed.Winter.min = min(oce.T_at_mld(oce.region == 2 & oce.season == 2));
stats.T_at_mld.WesternMed.Winter.max = max(oce.T_at_mld(oce.region == 2 & oce.season == 2));

stats.T_at_mld.WesternMed.Spring.median = median(oce.T_at_mld(oce.region == 2 & oce.season == 3),'omitnan');
stats.T_at_mld.WesternMed.Spring.mad = mad(oce.T_at_mld(oce.region == 2 & oce.season == 3),1);
stats.T_at_mld.WesternMed.Spring.min = min(oce.T_at_mld(oce.region == 2 & oce.season == 3));
stats.T_at_mld.WesternMed.Spring.max = max(oce.T_at_mld(oce.region == 2 & oce.season == 3));

stats.T_at_mld.WesternMed.Summer.median = median(oce.T_at_mld(oce.region == 2 & oce.season == 4),'omitnan');
stats.T_at_mld.WesternMed.Summer.mad = mad(oce.T_at_mld(oce.region == 2 & oce.season == 4),1);
stats.T_at_mld.WesternMed.Summer.min = min(oce.T_at_mld(oce.region == 2 & oce.season == 4));
stats.T_at_mld.WesternMed.Summer.max = max(oce.T_at_mld(oce.region == 2 & oce.season == 4));

stats.T_at_mld.Adriatic.Fall.median = median(oce.T_at_mld(oce.region == 3 & oce.season == 1),'omitnan');
stats.T_at_mld.Adriatic.Fall.mad = mad(oce.T_at_mld(oce.region == 3 & oce.season == 1),1);
stats.T_at_mld.Adriatic.Fall.min = min(oce.T_at_mld(oce.region == 3 & oce.season == 1));
stats.T_at_mld.Adriatic.Fall.max = max(oce.T_at_mld(oce.region == 3 & oce.season == 1));

stats.T_at_mld.Adriatic.Winter.median = median(oce.T_at_mld(oce.region == 3 & oce.season == 2),'omitnan');
stats.T_at_mld.Adriatic.Winter.mad = mad(oce.T_at_mld(oce.region == 3 & oce.season == 2),1);
stats.T_at_mld.Adriatic.Winter.min = min(oce.T_at_mld(oce.region == 3 & oce.season == 2));
stats.T_at_mld.Adriatic.Winter.max = max(oce.T_at_mld(oce.region == 3 & oce.season == 2));

stats.T_at_mld.Adriatic.Spring.median = median(oce.T_at_mld(oce.region == 3 & oce.season == 3),'omitnan');
stats.T_at_mld.Adriatic.Spring.mad = mad(oce.T_at_mld(oce.region == 3 & oce.season == 3),1);
stats.T_at_mld.Adriatic.Spring.min = min(oce.T_at_mld(oce.region == 3 & oce.season == 3));
stats.T_at_mld.Adriatic.Spring.max = max(oce.T_at_mld(oce.region == 3 & oce.season == 3));

stats.T_at_mld.Adriatic.Summer.median = median(oce.T_at_mld(oce.region == 3 & oce.season == 4),'omitnan');
stats.T_at_mld.Adriatic.Summer.mad = mad(oce.T_at_mld(oce.region == 3 & oce.season == 4),1);
stats.T_at_mld.Adriatic.Summer.min = min(oce.T_at_mld(oce.region == 3 & oce.season == 4));
stats.T_at_mld.Adriatic.Summer.max = max(oce.T_at_mld(oce.region == 3 & oce.season == 4));

stats.T_at_mld.Ionian.Fall.median = median(oce.T_at_mld(oce.region == 4 & oce.season == 1),'omitnan');
stats.T_at_mld.Ionian.Fall.mad = mad(oce.T_at_mld(oce.region == 4 & oce.season == 1),1);
stats.T_at_mld.Ionian.Fall.min = min(oce.T_at_mld(oce.region == 4 & oce.season == 1));
stats.T_at_mld.Ionian.Fall.max = max(oce.T_at_mld(oce.region == 4 & oce.season == 1));

stats.T_at_mld.Ionian.Winter.median = median(oce.T_at_mld(oce.region == 4 & oce.season == 2),'omitnan');
stats.T_at_mld.Ionian.Winter.mad = mad(oce.T_at_mld(oce.region == 4 & oce.season == 2),1);
stats.T_at_mld.Ionian.Winter.min = min(oce.T_at_mld(oce.region == 4 & oce.season == 2));
stats.T_at_mld.Ionian.Winter.max = max(oce.T_at_mld(oce.region == 4 & oce.season == 2));

stats.T_at_mld.Ionian.Spring.median = median(oce.T_at_mld(oce.region == 4 & oce.season == 3),'omitnan');
stats.T_at_mld.Ionian.Spring.mad = mad(oce.T_at_mld(oce.region == 4 & oce.season == 3),1);
stats.T_at_mld.Ionian.Spring.min = min(oce.T_at_mld(oce.region == 4 & oce.season == 3));
stats.T_at_mld.Ionian.Spring.max = max(oce.T_at_mld(oce.region == 4 & oce.season == 3));

stats.T_at_mld.Ionian.Summer.median = median(oce.T_at_mld(oce.region == 4 & oce.season == 4),'omitnan');
stats.T_at_mld.Ionian.Summer.mad = mad(oce.T_at_mld(oce.region == 4 & oce.season == 4),1);
stats.T_at_mld.Ionian.Summer.min = min(oce.T_at_mld(oce.region == 4 & oce.season == 4));
stats.T_at_mld.Ionian.Summer.max = max(oce.T_at_mld(oce.region == 4 & oce.season == 4));

stats.T_at_mld.TunisianSidra.Fall.median = median(oce.T_at_mld(oce.region == 5 & oce.season == 1),'omitnan');
stats.T_at_mld.TunisianSidra.Fall.mad = mad(oce.T_at_mld(oce.region == 5 & oce.season == 1),1);
stats.T_at_mld.TunisianSidra.Fall.min = min(oce.T_at_mld(oce.region == 5 & oce.season == 1));
stats.T_at_mld.TunisianSidra.Fall.max = max(oce.T_at_mld(oce.region == 5 & oce.season == 1));

stats.T_at_mld.TunisianSidra.Winter.median = median(oce.T_at_mld(oce.region == 5 & oce.season == 2),'omitnan');
stats.T_at_mld.TunisianSidra.Winter.mad = mad(oce.T_at_mld(oce.region == 5 & oce.season == 2),1);
stats.T_at_mld.TunisianSidra.Winter.min = min(oce.T_at_mld(oce.region == 5 & oce.season == 2));
stats.T_at_mld.TunisianSidra.Winter.max = max(oce.T_at_mld(oce.region == 5 & oce.season == 2));

stats.T_at_mld.TunisianSidra.Spring.median = median(oce.T_at_mld(oce.region == 5 & oce.season == 3),'omitnan');
stats.T_at_mld.TunisianSidra.Spring.mad = mad(oce.T_at_mld(oce.region == 5 & oce.season == 3),1);
stats.T_at_mld.TunisianSidra.Spring.min = min(oce.T_at_mld(oce.region == 5 & oce.season == 3));
stats.T_at_mld.TunisianSidra.Spring.max = max(oce.T_at_mld(oce.region == 5 & oce.season == 3));

stats.T_at_mld.TunisianSidra.Summer.median = median(oce.T_at_mld(oce.region == 5 & oce.season == 4),'omitnan');
stats.T_at_mld.TunisianSidra.Summer.mad = mad(oce.T_at_mld(oce.region == 5 & oce.season == 4),1);
stats.T_at_mld.TunisianSidra.Summer.min = min(oce.T_at_mld(oce.region == 5 & oce.season == 4));
stats.T_at_mld.TunisianSidra.Summer.max = max(oce.T_at_mld(oce.region == 5 & oce.season == 4));

stats.T_at_mld.Aegean.Fall.median = median(oce.T_at_mld(oce.region == 6 & oce.season == 1),'omitnan');
stats.T_at_mld.Aegean.Fall.mad = mad(oce.T_at_mld(oce.region == 6 & oce.season == 1),1);
stats.T_at_mld.Aegean.Fall.min = min(oce.T_at_mld(oce.region == 6 & oce.season == 1));
stats.T_at_mld.Aegean.Fall.max = max(oce.T_at_mld(oce.region == 6 & oce.season == 1));

stats.T_at_mld.Aegean.Winter.median = median(oce.T_at_mld(oce.region == 6 & oce.season == 2),'omitnan');
stats.T_at_mld.Aegean.Winter.mad = mad(oce.T_at_mld(oce.region == 6 & oce.season == 2),1);
stats.T_at_mld.Aegean.Winter.min = min(oce.T_at_mld(oce.region == 6 & oce.season == 2));
stats.T_at_mld.Aegean.Winter.max = max(oce.T_at_mld(oce.region == 6 & oce.season == 2));

stats.T_at_mld.Aegean.Spring.median = median(oce.T_at_mld(oce.region == 6 & oce.season == 3),'omitnan');
stats.T_at_mld.Aegean.Spring.mad = mad(oce.T_at_mld(oce.region == 6 & oce.season == 3),1);
stats.T_at_mld.Aegean.Spring.min = min(oce.T_at_mld(oce.region == 6 & oce.season == 3));
stats.T_at_mld.Aegean.Spring.max = max(oce.T_at_mld(oce.region == 6 & oce.season == 3));

stats.T_at_mld.Aegean.Summer.median = median(oce.T_at_mld(oce.region == 6 & oce.season == 4),'omitnan');
stats.T_at_mld.Aegean.Summer.mad = mad(oce.T_at_mld(oce.region == 6 & oce.season == 4),1);
stats.T_at_mld.Aegean.Summer.min = min(oce.T_at_mld(oce.region == 6 & oce.season == 4));
stats.T_at_mld.Aegean.Summer.max = max(oce.T_at_mld(oce.region == 6 & oce.season == 4));

stats.T_at_mld.Levantine.Fall.median = median(oce.T_at_mld(oce.region == 7 & oce.season == 1),'omitnan');
stats.T_at_mld.Levantine.Fall.mad = mad(oce.T_at_mld(oce.region == 7 & oce.season == 1),1);
stats.T_at_mld.Levantine.Fall.min = min(oce.T_at_mld(oce.region == 7 & oce.season == 1));
stats.T_at_mld.Levantine.Fall.max = max(oce.T_at_mld(oce.region == 7 & oce.season == 1));

stats.T_at_mld.Levantine.Winter.median = median(oce.T_at_mld(oce.region == 7 & oce.season == 2),'omitnan');
stats.T_at_mld.Levantine.Winter.mad = mad(oce.T_at_mld(oce.region == 7 & oce.season == 2),1);
stats.T_at_mld.Levantine.Winter.min = min(oce.T_at_mld(oce.region == 7 & oce.season == 2));
stats.T_at_mld.Levantine.Winter.max = max(oce.T_at_mld(oce.region == 7 & oce.season == 2));

stats.T_at_mld.Levantine.Spring.median = median(oce.T_at_mld(oce.region == 7 & oce.season == 3),'omitnan');
stats.T_at_mld.Levantine.Spring.mad = mad(oce.T_at_mld(oce.region == 7 & oce.season == 3),1);
stats.T_at_mld.Levantine.Spring.min = min(oce.T_at_mld(oce.region == 7 & oce.season == 3));
stats.T_at_mld.Levantine.Spring.max = max(oce.T_at_mld(oce.region == 7 & oce.season == 3));

stats.T_at_mld.Levantine.Summer.median = median(oce.T_at_mld(oce.region == 7 & oce.season == 4),'omitnan');
stats.T_at_mld.Levantine.Summer.mad = mad(oce.T_at_mld(oce.region == 7 & oce.season == 4),1);
stats.T_at_mld.Levantine.Summer.min = min(oce.T_at_mld(oce.region == 7 & oce.season == 4));
stats.T_at_mld.Levantine.Summer.max = max(oce.T_at_mld(oce.region == 7 & oce.season == 4));

%% N

stats.N.Alboran.Fall = length(oce.SST(oce.region == 1 & oce.season == 1));
stats.N.Alboran.Winter = length(oce.SST(oce.region == 1 & oce.season == 2));
stats.N.Alboran.Spring = length(oce.SST(oce.region == 1 & oce.season == 3));
stats.N.Alboran.Summer = length(oce.SST(oce.region == 1 & oce.season == 4));

stats.N.WesternMed.Fall = length(oce.SST(oce.region == 2 & oce.season == 1));
stats.N.WesternMed.Winter = length(oce.SST(oce.region == 2 & oce.season == 2));
stats.N.WesternMed.Spring = length(oce.SST(oce.region == 2 & oce.season == 3));
stats.N.WesternMed.Summer = length(oce.SST(oce.region == 2 & oce.season == 4));

stats.N.Adriatic.Fall = length(oce.SST(oce.region == 3 & oce.season == 1));
stats.N.Adriatic.Winter = length(oce.SST(oce.region == 3 & oce.season == 2));
stats.N.Adriatic.Spring = length(oce.SST(oce.region == 3 & oce.season == 3));
stats.N.Adriatic.Summer = length(oce.SST(oce.region == 3 & oce.season == 4));

stats.N.Ionian.Fall = length(oce.SST(oce.region == 4 & oce.season == 1));
stats.N.Ionian.Winter = length(oce.SST(oce.region == 4 & oce.season == 2));
stats.N.Ionian.Spring = length(oce.SST(oce.region == 4 & oce.season == 3));
stats.N.Ionian.Summer = length(oce.SST(oce.region == 4 & oce.season == 4));

stats.N.TunisianSidra.Fall = length(oce.SST(oce.region == 5 & oce.season == 1));
stats.N.TunisianSidra.Winter = length(oce.SST(oce.region == 5 & oce.season == 2));
stats.N.TunisianSidra.Spring = length(oce.SST(oce.region == 5 & oce.season == 3));
stats.N.TunisianSidra.Summer = length(oce.SST(oce.region == 5 & oce.season == 4));

stats.N.Aegean.Fall = length(oce.SST(oce.region == 6 & oce.season == 1));
stats.N.Aegean.Winter = length(oce.SST(oce.region == 6 & oce.season == 2));
stats.N.Aegean.Spring = length(oce.SST(oce.region == 6 & oce.season == 3));
stats.N.Aegean.Summer = length(oce.SST(oce.region == 6 & oce.season == 4));

stats.N.Levantine.Fall = length(oce.SST(oce.region == 7 & oce.season == 1));
stats.N.Levantine.Winter = length(oce.SST(oce.region == 7 & oce.season == 2));
stats.N.Levantine.Spring = length(oce.SST(oce.region == 7 & oce.season == 3));
stats.N.Levantine.Summer = length(oce.SST(oce.region == 7 & oce.season == 4));

%% Kruskal-Wallis

[~,~,tmp] = kruskalwallis(oce.mld,oce.region);
figure; c = multcompare(tmp);
stats.mld.p_hotspot = c(:,[1:2 6]);
close all

[~,~,tmp] = kruskalwallis(oce.T_at_mld,oce.region);
figure; c = multcompare(tmp);
stats.T_at_mld.p_hotspot = c(:,[1:2 6]);
close all

[~,~,tmp] = kruskalwallis(oce.SST,oce.region);
figure; c = multcompare(tmp);
stats.SST.p_hotspot = c(:,[1:2 6]);
close all

[~,~,tmp] = kruskalwallis(oce.mld,oce.season);
figure; c = multcompare(tmp);
stats.mld.p_season = c(:,[1:2 6]);
close all

[~,~,tmp] = kruskalwallis(oce.T_at_mld,oce.season);
figure; c = multcompare(tmp);
stats.T_at_mld.p_season = c(:,[1:2 6]);
close all

[~,~,tmp] = kruskalwallis(oce.SST,oce.season);
figure; c = multcompare(tmp);
stats.SST.p_season = c(:,[1:2 6]);
close all

for i = 1:length(oce.mld)
    if oce.region(i) == 1 && oce.season(i) == 1
        oce.ind(i) = 1;
    elseif oce.region(i) == 1 && oce.season(i) == 2
        oce.ind(i) = 2;
    elseif oce.region(i) == 1 && oce.season(i) == 3
        oce.ind(i) = 3;
    elseif oce.region(i) == 1 && oce.season(i) == 4
        oce.ind(i) = 4;
    elseif oce.region(i) == 2 && oce.season(i) == 1
        oce.ind(i) = 5;
    elseif oce.region(i) == 2 && oce.season(i) == 2
        oce.ind(i) = 6;
    elseif oce.region(i) == 2 && oce.season(i) == 3
        oce.ind(i) = 7;
    elseif oce.region(i) == 2 && oce.season(i) == 4
        oce.ind(i) = 8;
    elseif oce.region(i) == 3 && oce.season(i) == 1
        oce.ind(i) = 9;
    elseif oce.region(i) == 3 && oce.season(i) == 2
        oce.ind(i) = 10;
    elseif oce.region(i) == 3 && oce.season(i) == 3
        oce.ind(i) = 11;
    elseif oce.region(i) == 3 && oce.season(i) == 4
        oce.ind(i) = 12;
    elseif oce.region(i) == 4 && oce.season(i) == 1
        oce.ind(i) = 13;
    elseif oce.region(i) == 4 && oce.season(i) == 2
        oce.ind(i) = 14;
    elseif oce.region(i) == 4 && oce.season(i) == 3
        oce.ind(i) = 15;
    elseif oce.region(i) == 4 && oce.season(i) == 4
        oce.ind(i) = 16;
    elseif oce.region(i) == 5 && oce.season(i) == 1
        oce.ind(i) = 17;
    elseif oce.region(i) == 5 && oce.season(i) == 2
        oce.ind(i) = 18;
    elseif oce.region(i) == 5 && oce.season(i) == 3
        oce.ind(i) = 19;
    elseif oce.region(i) == 5 && oce.season(i) == 4
        oce.ind(i) = 20;
    elseif oce.region(i) == 6 && oce.season(i) == 1
        oce.ind(i) = 21;
    elseif oce.region(i) == 6 && oce.season(i) == 2
        oce.ind(i) = 22;
    elseif oce.region(i) == 6 && oce.season(i) == 3
        oce.ind(i) = 23;
    elseif oce.region(i) == 6 && oce.season(i) == 4
        oce.ind(i) = 24;
    elseif oce.region(i) == 7 && oce.season(i) == 1
        oce.ind(i) = 25;
    elseif oce.region(i) == 7 && oce.season(i) == 2
        oce.ind(i) = 26;
    elseif oce.region(i) == 7 && oce.season(i) == 3
        oce.ind(i) = 27;
    elseif oce.region(i) == 7 && oce.season(i) == 4
        oce.ind(i) = 28;
    end
end
clear i

[~,~,tmp] = kruskalwallis(oce.mld,oce.ind);
figure; c = multcompare(tmp);
stats.mld.p_hotspot_and_season = c(:,[1:2 6]);
close all

[~,~,tmp] = kruskalwallis(oce.T_at_mld,oce.ind);
figure; c = multcompare(tmp);
stats.T_at_mld.p_hotspot_and_season = c(:,[1:2 6]);
close all

[~,~,tmp] = kruskalwallis(oce.SST,oce.ind);
figure; c = multcompare(tmp);
stats.SST.p_hotspot_and_season = c(:,[1:2 6]);
close all

clear tmp
clear c