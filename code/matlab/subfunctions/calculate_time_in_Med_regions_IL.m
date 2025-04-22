%% calculate_time_in_Med_regions_IL.m
% Sub-function of IsraelTuna.m; computes statistics on time in 
% each region of the Med.

% Hotspots
% 0 = Outside of the Ionian
% 1 = Alboran Sea
% 2 = Western Med
% 3 = Adriatic Sea
% 4 = Ionian Sea
% 5 = Tunisian Plateau/Gulf of Sidra
% 6 = Aegean Sea
% 7 = Levantine Sea

%% Number of Days in Each Hotspot

stats.daysperhotspot.Counts = groupcounts(SSM,{'TOPPID','Region'},'IncludeEmptyGroups',true);

% Alboran Sea

% # of days
t = stats.daysperhotspot.Counts.GroupCount(stats.daysperhotspot.Counts.Region == 1);
stats.daysperhotspot.Alboran.nodays.mean = mean(t);
stats.daysperhotspot.Alboran.nodays.std = std(t);
stats.daysperhotspot.Alboran.nodays.min = min(t);
stats.daysperhotspot.Alboran.nodays.max = max(t);

% % of total deployment
d = groupcounts(SSM,'TOPPID');
stats.daysperhotspot.Alboran.prctdays.mean = mean((t./d.GroupCount)*100);
stats.daysperhotspot.Alboran.prctdays.std = std((t./d.GroupCount)*100);
stats.daysperhotspot.Alboran.prctdays.min = min((t./d.GroupCount)*100);
stats.daysperhotspot.Alboran.prctdays.max = max((t./d.GroupCount)*100);

clear t

% Western Ionian

% # of days
t = stats.daysperhotspot.Counts.GroupCount(stats.daysperhotspot.Counts.Region == 2);
stats.daysperhotspot.WesternMed.nodays.mean = mean(t);
stats.daysperhotspot.WesternMed.nodays.std = std(t);
stats.daysperhotspot.WesternMed.nodays.min = min(t);
stats.daysperhotspot.WesternMed.nodays.max = max(t);

% % of total deployment
stats.daysperhotspot.WesternMed.prctdays.mean = mean((t./d.GroupCount)*100);
stats.daysperhotspot.WesternMed.prctdays.std = std((t./d.GroupCount)*100);
stats.daysperhotspot.WesternMed.prctdays.min = min((t./d.GroupCount)*100);
stats.daysperhotspot.WesternMed.prctdays.max = max((t./d.GroupCount)*100);

clear t

% Ionian Sea

% # of days
t = stats.daysperhotspot.Counts.GroupCount(stats.daysperhotspot.Counts.Region == 4);
stats.daysperhotspot.Ionian.nodays.mean = mean(t);
stats.daysperhotspot.Ionian.nodays.std = std(t);
stats.daysperhotspot.Ionian.nodays.min = min(t);
stats.daysperhotspot.Ionian.nodays.max = max(t);

% % of total deployment
stats.daysperhotspot.Ionian.prctdays.mean = mean((t./d.GroupCount)*100);
stats.daysperhotspot.Ionian.prctdays.std = std((t./d.GroupCount)*100);
stats.daysperhotspot.Ionian.prctdays.min = min((t./d.GroupCount)*100);
stats.daysperhotspot.Ionian.prctdays.max = max((t./d.GroupCount)*100);

clear t

% Tunisian Plateau/Gulf of Sidra

% # of days
t = stats.daysperhotspot.Counts.GroupCount(stats.daysperhotspot.Counts.Region == 5);
stats.daysperhotspot.TunisianSidra.nodays.mean = mean(t);
stats.daysperhotspot.TunisianSidra.nodays.std = std(t);
stats.daysperhotspot.TunisianSidra.nodays.min = min(t);
stats.daysperhotspot.TunisianSidra.nodays.max = max(t);

% % of total deployment
stats.daysperhotspot.TunisianSidra.prctdays.mean = mean((t./d.GroupCount)*100);
stats.daysperhotspot.TunisianSidra.prctdays.std = std((t./d.GroupCount)*100);
stats.daysperhotspot.TunisianSidra.prctdays.min = min((t./d.GroupCount)*100);
stats.daysperhotspot.TunisianSidra.prctdays.max = max((t./d.GroupCount)*100);

clear t

% Aegean Sea

% # of days
t = stats.daysperhotspot.Counts.GroupCount(stats.daysperhotspot.Counts.Region == 6);
stats.daysperhotspot.Aegean.nodays.mean = mean(t);
stats.daysperhotspot.Aegean.nodays.std = std(t);
stats.daysperhotspot.Aegean.nodays.min = min(t);
stats.daysperhotspot.Aegean.nodays.max = max(t);

% % of total deployment
stats.daysperhotspot.Aegean.prctdays.mean = mean((t./d.GroupCount)*100);
stats.daysperhotspot.Aegean.prctdays.std = std((t./d.GroupCount)*100);
stats.daysperhotspot.Aegean.prctdays.min = min((t./d.GroupCount)*100);
stats.daysperhotspot.Aegean.prctdays.max = max((t./d.GroupCount)*100);

clear t

% Levantine Sea

% # of days
t = stats.daysperhotspot.Counts.GroupCount(stats.daysperhotspot.Counts.Region == 7);
stats.daysperhotspot.Levantine.nodays.mean = mean(t);
stats.daysperhotspot.Levantine.nodays.std = std(t);
stats.daysperhotspot.Levantine.nodays.min = min(t);
stats.daysperhotspot.Levantine.nodays.max = max(t);

% % of total deployment
stats.daysperhotspot.Levantine.prctdays.mean = mean((t./d.GroupCount)*100);
stats.daysperhotspot.Levantine.prctdays.std = std((t./d.GroupCount)*100);
stats.daysperhotspot.Levantine.prctdays.min = min((t./d.GroupCount)*100);
stats.daysperhotspot.Levantine.prctdays.max = max((t./d.GroupCount)*100);

clear t

%% Clear

clear d
clear id

clear toppIDs
