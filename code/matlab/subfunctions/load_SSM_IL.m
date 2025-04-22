%% load_SSM_IL.m
% Sub-function of IsraelTuna.m; load SSM tracks.

%% Go To Folder

cd([fdir '/data/SSM']);

%% Get List of Files

files = dir('*SSM.txt');

%% Load Files

for i = 1:length(files)

    if ismember(str2double(files(i).name(1:7)),META.toppID) == 0
        continue
    end

    if exist('SSM','var') == 0

        SSM = readtable(files(i).name);
        SSM = SSM(:,1:3);    
        SSM.Properties.VariableNames = {'Date' 'Longitude' 'Latitude'};

        TOPPID = str2double(files(i).name(1:7))*ones(size(SSM,1),1);
        SSM = addvars(SSM,TOPPID,'Before','Date');

        SSM.Date = datetime(year(SSM.Date),month(SSM.Date),day(SSM.Date));

        date_rm = min([META.popdate(META.toppID == TOPPID(1)),...
            META.recdate(META.toppID == TOPPID(1)), ...
            META.date_last_depth(META.toppID == TOPPID(1)), ...
            META.date_last_light(META.toppID == TOPPID(1)), ...
            META.date_last_lon(META.toppID == TOPPID(1)), ...
            META.manual_cut_date(META.toppID == TOPPID(1))]);

        SSM(SSM.Date >= date_rm,:) = [];

        clear date_rm

    else

        tmp = readtable(files(i).name);
        tmp = tmp(:,1:3);    
        tmp.Properties.VariableNames = {'Date' 'Longitude' 'Latitude'};

        TOPPID = str2double(files(i).name(1:7))*ones(size(tmp,1),1);
        tmp = addvars(tmp,TOPPID,'Before','Date');

        tmp.Date = datetime(year(tmp.Date),month(tmp.Date),day(tmp.Date));

        date_rm = min([META.popdate(META.toppID == TOPPID(1)),...
            META.recdate(META.toppID == TOPPID(1)), ...
            META.date_last_depth(META.toppID == TOPPID(1)), ...
            META.date_last_light(META.toppID == TOPPID(1)), ...
            META.date_last_lon(META.toppID == TOPPID(1)), ...
            META.manual_cut_date(META.toppID == TOPPID(1))]);

        tmp(tmp.Date >= date_rm,:) = [];

        SSM = [SSM; tmp];

        clear tmp
        clear date_rm
    end

    clear TOPPID

end
clear i
clear files

%% Define hotspots.

% 0 = Outside of the Med
% 1 = Alboran Sea
% 2 = Western Med
% 3 = Adriatic Sea
% 4 = Ionian Sea
% 5 = Tunisian Plateau/Gulf of Sidra
% 6 = Aegean Sea
% 7 = Levantine Sea

% Alboran Sea
cd([fdir '/data/shp/alboran'])
tmp = shaperead('alboran.shp');
regions.Alboran = [tmp.X.', tmp.Y.'];
clear tmp

% Western Med
cd([fdir '/data/shp/westernmed'])
tmp = shaperead('westernmed.shp');
ind = find(isnan(tmp.X));
regions.WesternMed = [tmp.X(1:ind(1)).', tmp.Y(1:ind(1)).'];
clear ind
clear tmp

% Adriatic Sea
cd([fdir '/data/shp/adriatic'])
tmp = shaperead('adriatic.shp');
regions.Adriatic = [tmp.X.', tmp.Y.'];
clear tmp

% Ionian Sea
cd([fdir '/data/shp/ionian'])
tmp = shaperead('ionian.shp');
regions.Ionian = [tmp.X.', tmp.Y.'];
clear tmp

% Tunisian Plateau/Gulf of Sidra
cd([fdir '/data/shp/tunisian'])
tmp = shaperead('tunisian.shp');
regions.Tunisian = [tmp.X.', tmp.Y.'];
clear tmp

% Aegean Sea
cd([fdir '/data/shp/aegean'])
tmp = shaperead('aegean.shp');
ind = find(isnan(tmp.X));
regions.Aegean = [tmp.X(ind(1):ind(2)).', tmp.Y(ind(1):ind(2)).'];
clear ind
clear tmp

% Levantine Sea
cd([fdir '/data/shp/levantine'])
tmp = shaperead('levantine.shp');
ind = find(isnan(tmp.X));
regions.Levantine = [tmp.X(1:ind(1)).', tmp.Y(1:ind(1)).'];
clear tmp

SSM.Region = zeros(height(SSM.TOPPID),1);
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Alboran(:,1),regions.Alboran(:,2))) = 1;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.WesternMed(:,1),regions.WesternMed(:,2))) = 2;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Adriatic(:,1),regions.Adriatic(:,2))) = 3;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Ionian(:,1),regions.Ionian(:,2))) = 4;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Tunisian(:,1),regions.Tunisian(:,2))) = 5;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Aegean(:,1),regions.Aegean(:,2))) = 6;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Levantine(:,1),regions.Levantine(:,2))) = 7;

% Because of the differences in land area used to constrain SSM, there are
% points in the Med that are classified to be outside. Use the following to
% determine region.

ind0 = find(SSM.Region == 0 & SSM.Longitude >= -5.61);
indf = find(SSM.Region ~= 0 & SSM.Longitude >= -5.61);

for i = 1:length(ind0)
    [~,ind] = min(abs(indf-ind0(i)));
    SSM.Region(ind0(i)) = SSM.Region(indf(ind));
end
clear i
clear ind*

SSM.Region(SSM.Longitude <= -5.61) = 0;
SSM.Region(SSM.Latitude > 46) = 0;

%% Determine season.

% 1 = Fall which includes September, October and November.
% 2 = Winter which includes December, January and February.
% 3 = Spring which includes March, April and May.
% 4 = Summer which includes June, July and August.

season = zeros(height(SSM),1);
season(month(SSM.Date) == 9 | month(SSM.Date) == 10 | month(SSM.Date) == 11) = 1;
season(month(SSM.Date) == 12 | month(SSM.Date) == 1 | month(SSM.Date) == 2) = 2;
season(month(SSM.Date) == 3 | month(SSM.Date) == 4 | month(SSM.Date) == 5) = 3;
season(month(SSM.Date) == 6 | month(SSM.Date) == 7 | month(SSM.Date) == 8) = 4;

SSM.Season = season;

clear season