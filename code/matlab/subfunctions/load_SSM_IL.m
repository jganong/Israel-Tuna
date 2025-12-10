%% load_SSM_IL.m
% Sub-function of IsraelTuna.m; load SSM tracks.

%% Go To Folder


%% Get List of Files

%% Load Files

SSM=cell(height(META),1); % empty placeholder cell array to hold tables

for i = 1:height(META)
	row=META(i,:);

 % note that the Turkey tags are not double tagged, so the filename always ends in 00SSM.txt

    file=[ '/TOPP/Tuna/ABFT/Recovery/SSM/version10/csv/' num2str(row.toppID) '00SSM.txt'];

    if exist(file,'file') == 0
        continue
    else
	    CENSUS.SSM_FILE(i)=file;
    end

    tmp = readtable(file);
        CENSUS.SSM_RAW(i)=height(tmp);

    tmp = tmp(:,1:3);
    tmp.Properties.VariableNames = {'Date' 'Longitude' 'Latitude'};

    tmp.TOPPID(:) = row.toppID;

    tmp.Date = datetime(year(tmp.Date),month(tmp.Date),day(tmp.Date));

    date_variable_names = {
        'popdate','recdate','date_last_depth','date_last_light','date_last_lon','manual_cut_date'
        };
    dates =  row(:,date_variable_names);
    dates = table2cell(dates);

    for j = 1:length(dates)
	    if strcmp(class(dates{j}),'double') && isnan(dates{j})
		    dates{j}=NaT;
	    end
    end


    date_rm = min(cell2mat(dates));

    tmp(tmp.Date >= date_rm,:) = [];
    SSM{i}=tmp;
        CENSUS.SSM_TRIMMED(i)=height(tmp);
end
SSM=cat(1,SSM{:});


%% Define hotspots.

% 0 = Outside of the Med
% 1 = Alboran Sea
% 2 = Western Med
% 3 = Adriatic Sea
% 4 = Ionian Sea
% 5 = Tunisian Plateau/Gulf of Sidra
% 6 = Aegean Sea
% 7 = Levantine Sea


% How the shape files for each sea were gathered
%
% For each Sea:
%
% Open 'https://marineregions.org/gazetteer.php?p=search' using
% a web browser eg firefox. This opens the Gazetter Search Page.
% Manually enter name of the Sea, eg 'Alboran Sea'.
% Select the link which is annotated 'MEOW'.
% Set format to 'Shapefile'.
% Press 'Download' button.
% This will download a file called 'iho.zip' file to the Downloads dir.
% From the command line type the command:  'unzip Downloads/iho.zip'.
% This produces a series of files, but only 'iho.shp' is needed.
% Rename 'iho.shp' to reflect the Sea name eg 'alboran.shp'

% the file 

% Alboran Sea
cd([fdir '/data/shp/alboran'])
tmp = shaperead('alboran.shp');
regions.Alboran = [tmp.X.', tmp.Y.'];
clear tmp

% Western Med
cd([fdir '/data/shp/westernmed'])
tmp = shaperead('westernmed.shp');
regions.Alboran = [tmp.X.', tmp.Y.'];
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

% Black Sea
cd([fdir '/data/shp/black'])
tmp = shaperead('black.shp');
ind = find(isnan(tmp.X));
regions.Black = [tmp.X(1:ind(1)).', tmp.Y(1:ind(1)).'];
clear tmp

SSM.Region(:) = 0;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Alboran(:,1),regions.Alboran(:,2))) = 1;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.WesternMed(:,1),regions.WesternMed(:,2))) = 2;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Adriatic(:,1),regions.Adriatic(:,2))) = 3;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Ionian(:,1),regions.Ionian(:,2))) = 4;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Tunisian(:,1),regions.Tunisian(:,2))) = 5;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Aegean(:,1),regions.Aegean(:,2))) = 6;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Levantine(:,1),regions.Levantine(:,2))) = 7;
SSM.Region(inpolygon(SSM.Longitude,SSM.Latitude,regions.Black(:,1),regions.Black(:,2))) = 8;

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
