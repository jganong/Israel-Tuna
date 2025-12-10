%% load_archive_IL
% Sub-function of IsraelTuna.m; loads data from recovered tags.

%
% Go to folder.


%% Get list of files, but instead of using /data/dc, get from /TOPP


PSAT=cell(height(META),1); % empty placeholder cell array to hold tables
for i = 1:height(META)
    row=META(i,:);

    file=strcat('/TOPP/Tuna/ABFT/Recovery/PAT/',string(row.toppID),'_',row.tagnumber, '/processing/',string(row.toppID),'_',row.tagnumber,'DC.csv');


    % file is dervied from META so no need to skip files not in META
    % (there are none)
    % if ismember(str2double(files(i).name(1:7)),META.toppID) == 0
    %     continue
    % end
    %
    % BUT CONVERSELY, THERE ARE SOME ROWS IN META WITH NO DC FILE,
    % SO WE HAVE TO DO THE REVERSE CHECK

    if exist(file,'file') == 0
	continue
    else
	CENSUS.PSAT_FILE(i)=file;
    end



    %% Load data.

    tmp = readtable(file);
    CENSUS.PSAT_RAW(i)=height(tmp);




    tmp = tmp(:,[3:4 6 8:13]);

    tmp.Properties.VariableNames = {'Depth' 'LightLevel' 'Temperature',...
        'Year' 'Month' 'Day' 'Hour' 'Min' 'Sec'};

    tmp.DateTime = datetime(tmp.Year,tmp.Month,tmp.Day,...
        tmp.Hour,tmp.Min,tmp.Sec);
    tmp(:,4:9) = [];
    tmp = movevars(tmp, 'DateTime', 'Before', 'Depth');

    tmp.TOPPID(:) = row.toppID;
    tmp = movevars(tmp, 'TOPPID', 'Before', 'DateTime');

    %% Remove data before deployment date.

    tmp(tmp.DateTime < row.taggingdate,:) = [];

    %% Remove data after first date of "last" or manual.


    date_variable_names = {
        'popdate','recdate','date_last_depth','date_last_light','date_last_lon','manual_cut_date'
        };
    dates =  row(:,date_variable_names);
    dates = table2cell(dates);

    % sometimes they read in as NaN  (class numeric)
    % other times as NaT (class datetime) 
    % this makes them all class datetime
    for j = 1:length(dates)
	    if strcmp(class(dates{j}),'double') && isnan(dates{j})
		    dates{j}=NaT;
	    end
    end
    
    tmp(tmp.DateTime >= date_rm,:) = [];

    %% Remove data after last SSM date.

    tmp(tmp.DateTime > max(SSM.Date(SSM.TOPPID == row.toppID)),:) = [];

    %% Time Zone Correction


    if row.timezone_correction > 0
        tz = ['+0' num2str(row.timezone_correction) ':00'];
    else if row.timezone_correction < 0
		    tz = ['-0' num2str(abs(row.timezone_correction)) ':00'];
	    else
		    tz = 'UTC'; % 0 or NaN
	    end
    end

    tmp.DateTime.TimeZone = tz;

    tmp.Date = datetime(year(tmp.DateTime),month(tmp.DateTime),day(tmp.DateTime));
    tmp = movevars(tmp, 'Date', 'Before', 'Depth');
    if (height(tmp)==  0)
        CENSUS.PSAT_TRIMMED(i)=height(tmp);
        continue % tmp is empty -- probably no SSM? -- skip this deployment
    end
    %% Interpolate SSM positions to match tmp data.

    tmp.Longitude = interp1(datenum(SSM.Date(SSM.TOPPID == row.toppID)),...
        SSM.Longitude(SSM.TOPPID == row.toppID),datenum(tmp.DateTime));

    tmp.Latitude = interp1(datenum(SSM.Date(SSM.TOPPID == row.toppID)),...
        SSM.Latitude(SSM.TOPPID == row.toppID),datenum(tmp.DateTime));

    %% Remove values outside of the Med.

    ind = tmp.Longitude <= -5.6061;
    tmp(ind,:) = [];

    ind = tmp.Latitude >= 46;
    tmp(ind,:) = [];

    %% Determine season.

    % 1 = Fall which includes September, October and November.
    % 2 = Winter which includes December, January and February.
    % 3 = Spring which includes March, April and May.
    % 4 = Summer which includes June, July and August.

    tmp.Season = zeros(length(tmp.Latitude),1);
    tmp.Season(month(tmp.DateTime) == 9 | month(tmp.DateTime) == 10 | month(tmp.DateTime) == 11) = 1;
    tmp.Season(month(tmp.DateTime) == 12 | month(tmp.DateTime) == 1 | month(tmp.DateTime) == 2) = 2;
    tmp.Season(month(tmp.DateTime) == 3 | month(tmp.DateTime) == 4 | month(tmp.DateTime) == 5) = 3;
    tmp.Season(month(tmp.DateTime) == 6 | month(tmp.DateTime) == 7 | month(tmp.DateTime) == 8) = 4;

    %% Determine hotspot.

    tmp.Region = zeros(height(tmp.TOPPID),1);
    tmp.Region(inpolygon(tmp.Longitude,tmp.Latitude,regions.Alboran(:,1),regions.Alboran(:,2))) = 1;
    tmp.Region(inpolygon(tmp.Longitude,tmp.Latitude,regions.WesternMed(:,1),regions.WesternMed(:,2))) = 2;
    tmp.Region(inpolygon(tmp.Longitude,tmp.Latitude,regions.Adriatic(:,1),regions.Adriatic(:,2))) = 3;
    tmp.Region(inpolygon(tmp.Longitude,tmp.Latitude,regions.Ionian(:,1),regions.Ionian(:,2))) = 4;
    tmp.Region(inpolygon(tmp.Longitude,tmp.Latitude,regions.Tunisian(:,1),regions.Tunisian(:,2))) = 5;
    tmp.Region(inpolygon(tmp.Longitude,tmp.Latitude,regions.Aegean(:,1),regions.Aegean(:,2))) = 6;
    tmp.Region(inpolygon(tmp.Longitude,tmp.Latitude,regions.Levantine(:,1),regions.Levantine(:,2))) = 7;
    tmp.Region(inpolygon(tmp.Longitude,tmp.Latitude,regions.Black(:,1),regions.Black(:,2))) = 8;
    CENSUS.PSAT_TRIMMED(i)=height(tmp);
    PSAT{i}=tmp;
    %end

end

% combine separate tables into one table, dropping empty tables
PSAT=cat(1,PSAT{:});
if isempty(PSAT)
	disp('no PSAT data found') % warning() does not work here
	return
end

PSAT.Date.TimeZone = 'UTC';

%% Fix assignment to region.
% Because of the differences in land area used to constrain SSM, there are
% points in the Med that are classified to be outside. Use the following to
% determine region.
ind0 = find(PSAT.Region == 0 & PSAT.Longitude >= -5.6061);
indf = find(PSAT.Region ~= 0 & PSAT.Longitude >= -5.6061);
rf = PSAT.Region(indf);
r0 = interp1(indf, rf, ind0,'nearest');
PSAT.Region(ind0) = r0;

PSAT.Region(PSAT.Longitude <= -5.6061) = 0;
PSAT.Region(PSAT.Latitude > 46) = 0;

%% Find sunrise and sunset time to determine if observation is day or night.

[SRISE,SSET] = sunrise(PSAT.Latitude,PSAT.Longitude,0,0,PSAT.DateTime);
PSAT.DayNight = zeros(height(PSAT),1);
PSAT.DayNight(PSAT.DateTime > datetime(SRISE,'ConvertFrom','datenum','TimeZone','UTC') & PSAT.DateTime < datetime(SSET,'ConvertFrom','datenum','TimeZone','UTC')) = 1;

