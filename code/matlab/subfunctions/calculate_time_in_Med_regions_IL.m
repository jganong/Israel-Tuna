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
% 8 = Black Sea

%% Number of Days in Each Hotspot

region_names= fieldnames(regions);

for region_index = 1 : length(region_names)

	region = region_names{region_index};

	% note that even with IncludeEmptyGroups = true,
	% if there is no data in a region there will be no entry!
	stats.daysperhotspot.Counts = groupcounts(SSM,{'TOPPID','Region'},'IncludeEmptyGroups',true);
	d = groupcounts(SSM,'TOPPID');
	t = [];
	for toppid_index = 1 : height(d)
		toppid = d.TOPPID(toppid_index);
		toppid_mask = (stats.daysperhotspot.Counts.TOPPID == toppid);

		% # of days
		region_mask = (stats.daysperhotspot.Counts.Region == region_index);

		toppid_and_region_mask = toppid_mask & region_mask;


		count= sum(toppid_and_region_mask);

		if count 
			% there is some data in this region for this toppid
			t(toppid_index) = stats.daysperhotspot.Counts.GroupCount(toppid_and_region_mask);
		else
			% if there is no data for this fish in this region make it 0 rather than empty
			t(toppid_index) = 0;
		end
	end
	stats.daysperhotspot.(region).nodays.mean = mean(t);
	stats.daysperhotspot.(region).nodays.std = std(t);
	stats.daysperhotspot.(region).nodays.min = min(t);
	stats.daysperhotspot.(region).nodays.max = max(t);


	% % of total deployment
	% Error using ./
	% Arrays have incompatible sizes for this operation.
	% the problem appears to be the t has entries for each fish in each region,
	% but we want to compare it to d, which only has entries for each fish.
	% i think what we need is a loop, and do one fish at a time

	stats.daysperhotspot.(region).prctdays.mean = mean((t ./ d.GroupCount)*100);
	stats.daysperhotspot.(region).prctdays.std = std((t ./ d.GroupCount)*100);
	stats.daysperhotspot.(region).prctdays.min = min((t ./ d.GroupCount)*100);
	stats.daysperhotspot.(region).prctdays.max = max((t ./ d.GroupCount)*100);

end

clear d
clear id

clear toppIDs
