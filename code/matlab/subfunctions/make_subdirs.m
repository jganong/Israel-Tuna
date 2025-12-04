for subdir = {
	'/data/minmax'
	'/data/shp/adriatic'
	'/data/shp/aegean'
	'/data/shp/alboran'
	'/data/shp/black'
	'/data/shp/ionian'
	'/data/shp/levantine'
	'/data/shp/tunisian'
	'/data/shp/westernmed'
	'/figures'
	'/figures/Figure_4'
	'/figures/Figure_S5'
	'/figures/Figure_S6'
	'/figures/individual_tracks'
	'/figures/timeseries'
	'/lib/cdt/CDT-master/cdt'
	'/data/mld'
}'
	mkdir([fdir subdir{:}]);
end

