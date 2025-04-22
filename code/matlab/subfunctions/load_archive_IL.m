%% load_archive_IL
% Sub-function of IsraelTuna.m; loads data from recovered tags.

%% Go to folder.

cd([fdir '/data/dc']);

%% Get list of files.

files = dir('*DC*.csv');

%% Loop through files.

for i = 1:length(files)

    disp(i)

    if ismember(str2double(files(i).name(1:7)),META.toppID) == 0
        continue
    end

    if exist('PSAT','var') == 0

        %% Load data.

        PSAT = readtable(files(i).name);
        PSAT = PSAT(:,[3:4 6 8:13]);

        PSAT.Properties.VariableNames = {'Depth' 'LightLevel' 'Temperature',...
            'Year' 'Month' 'Day' 'Hour' 'Min' 'Sec'};

        PSAT.DateTime = datetime(PSAT.Year,PSAT.Month,PSAT.Day,...
            PSAT.Hour,PSAT.Min,PSAT.Sec);
        PSAT(:,4:9) = [];
        PSAT = movevars(PSAT, 'DateTime', 'Before', 'Depth');

        PSAT.TOPPID = str2double(files(i).name(1:7))*ones(size(PSAT,1),1);
        PSAT = movevars(PSAT, 'TOPPID', 'Before', 'DateTime');

        %% Remove data before deployment date.

        PSAT(PSAT.DateTime <= META.taggingdate(META.toppID == PSAT.TOPPID(1)),:) = [];

        %% Remove data after first date of "last" or manual.

        date_rm = min([META.popdate(META.toppID == PSAT.TOPPID(1)),...
            META.recdate(META.toppID == PSAT.TOPPID(1)), ...
            META.date_last_depth(META.toppID == PSAT.TOPPID(1)), ...
            META.date_last_light(META.toppID == PSAT.TOPPID(1)), ...
            META.date_last_lon(META.toppID == PSAT.TOPPID(1)), ...
            META.manual_cut_date(META.toppID == PSAT.TOPPID(1))]);

        PSAT(PSAT.DateTime >= date_rm,:) = [];

        clear date_rm

        %% Remove data after last SSM date.

        PSAT(PSAT.DateTime > max(SSM.Date(SSM.TOPPID == PSAT.TOPPID(1))),:) = [];

        %% Time Zone Correction
 
        if META.timezone_correction(META.toppID == PSAT.TOPPID(1)) >= 0
            tz = ['+0' num2str(META.timezone_correction(META.toppID == PSAT.TOPPID(1))) ':00'];
        else
            tz = ['-0' num2str(abs(META.timezone_correction(META.toppID == PSAT.TOPPID(1)))) ':00'];
        end
        PSAT.DateTime.TimeZone = tz;
        clear tz

        PSAT.DateTime.TimeZone = 'UTC';

        PSAT.Date = datetime(year(PSAT.DateTime),month(PSAT.DateTime),day(PSAT.DateTime));
        PSAT = movevars(PSAT, 'Date', 'Before', 'Depth');

        %% Interpolate SSM positions to match PSAT data.

        PSAT.Longitude = interp1(datenum(SSM.Date(SSM.TOPPID == PSAT.TOPPID(1))),...
            SSM.Longitude(SSM.TOPPID == PSAT.TOPPID(1)),datenum(PSAT.DateTime));

        PSAT.Latitude = interp1(datenum(SSM.Date(SSM.TOPPID == PSAT.TOPPID(1))),...
            SSM.Latitude(SSM.TOPPID == PSAT.TOPPID(1)),datenum(PSAT.DateTime));

        %% Remove values outside of the Med.

        ind = PSAT.Longitude <= -5.6061;
        PSAT(ind,:) = [];

        ind = PSAT.Latitude >= 46;
        PSAT(ind,:) = [];

        %% Determine season.

        % 1 = Fall which includes September, October and November.
        % 2 = Winter which includes December, January and February.
        % 3 = Spring which includes March, April and May.
        % 4 = Summer which includes June, July and August.

        PSAT.Season = zeros(length(PSAT.Latitude),1);
        PSAT.Season(month(PSAT.DateTime) == 9 | month(PSAT.DateTime) == 10 | month(PSAT.DateTime) == 11) = 1;
        PSAT.Season(month(PSAT.DateTime) == 12 | month(PSAT.DateTime) == 1 | month(PSAT.DateTime) == 2) = 2;
        PSAT.Season(month(PSAT.DateTime) == 3 | month(PSAT.DateTime) == 4 | month(PSAT.DateTime) == 5) = 3;
        PSAT.Season(month(PSAT.DateTime) == 6 | month(PSAT.DateTime) == 7 | month(PSAT.DateTime) == 8) = 4;

        %% Determine hotspot.

        PSAT.Region = zeros(height(PSAT.TOPPID),1);
        PSAT.Region(inpolygon(PSAT.Longitude,PSAT.Latitude,regions.Alboran(:,1),regions.Alboran(:,2))) = 1;
        PSAT.Region(inpolygon(PSAT.Longitude,PSAT.Latitude,regions.WesternMed(:,1),regions.WesternMed(:,2))) = 2;
        PSAT.Region(inpolygon(PSAT.Longitude,PSAT.Latitude,regions.Adriatic(:,1),regions.Adriatic(:,2))) = 3;
        PSAT.Region(inpolygon(PSAT.Longitude,PSAT.Latitude,regions.Ionian(:,1),regions.Ionian(:,2))) = 4;
        PSAT.Region(inpolygon(PSAT.Longitude,PSAT.Latitude,regions.Tunisian(:,1),regions.Tunisian(:,2))) = 5;
        PSAT.Region(inpolygon(PSAT.Longitude,PSAT.Latitude,regions.Aegean(:,1),regions.Aegean(:,2))) = 6;
        PSAT.Region(inpolygon(PSAT.Longitude,PSAT.Latitude,regions.Levantine(:,1),regions.Levantine(:,2))) = 7;

    else

        %% Load data.

        tmp = readtable(files(i).name);
        tmp = tmp(:,[3:4 6 8:13]);

        tmp.Properties.VariableNames = {'Depth' 'LightLevel' 'Temperature',...
            'Year' 'Month' 'Day' 'Hour' 'Min' 'Sec'};

        tmp.DateTime = datetime(tmp.Year,tmp.Month,tmp.Day,...
            tmp.Hour,tmp.Min,tmp.Sec);
        tmp(:,4:9) = [];
        tmp = movevars(tmp, 'DateTime', 'Before', 'Depth');

        tmp.TOPPID = str2double(files(i).name(1:7))*ones(size(tmp,1),1);
        tmp = movevars(tmp, 'TOPPID', 'Before', 'DateTime');

        %% Remove data before deployment date.

        tmp(tmp.DateTime <= META.taggingdate(META.toppID == tmp.TOPPID(1)),:) = [];

        %% Remove data after first date of "last" or manual.

        date_rm = min([META.popdate(META.toppID == tmp.TOPPID(1)),...
            META.recdate(META.toppID == tmp.TOPPID(1)), ...
            META.date_last_depth(META.toppID == tmp.TOPPID(1)), ...
            META.date_last_light(META.toppID == tmp.TOPPID(1)), ...
            META.date_last_lon(META.toppID == tmp.TOPPID(1)), ...
            META.manual_cut_date(META.toppID == tmp.TOPPID(1))]);

        tmp(tmp.DateTime >= date_rm,:) = [];

        clear date_rm

        %% Remove data after last SSM date.

        tmp(tmp.DateTime > max(SSM.Date(SSM.TOPPID == tmp.TOPPID(1))),:) = [];

        %% Time Zone Correction
 
        if META.timezone_correction(META.toppID == tmp.TOPPID(1)) >= 0
            tz = ['+0' num2str(META.timezone_correction(META.toppID == tmp.TOPPID(1))) ':00'];
        else
            tz = ['-0' num2str(abs(META.timezone_correction(META.toppID == tmp.TOPPID(1)))) ':00'];
        end
        tmp.DateTime.TimeZone = tz;
        clear tz

        tmp.DateTime.TimeZone = 'UTC';

        tmp.Date = datetime(year(tmp.DateTime),month(tmp.DateTime),day(tmp.DateTime));
        tmp = movevars(tmp, 'Date', 'Before', 'Depth');

        %% Interpolate SSM positions to match PSAT data.

        tmp.Longitude = interp1(datenum(SSM.Date(SSM.TOPPID == tmp.TOPPID(1))),...
            SSM.Longitude(SSM.TOPPID == tmp.TOPPID(1)),datenum(tmp.DateTime));

        tmp.Latitude = interp1(datenum(SSM.Date(SSM.TOPPID == tmp.TOPPID(1))),...
            SSM.Latitude(SSM.TOPPID == tmp.TOPPID(1)),datenum(tmp.DateTime));

        %% Remove values outside of the Med.

        ind = tmp.Longitude <= -5.6061;
        tmp(ind,:) = [];

        ind = tmp.Latitude >= 46;
        tmp(ind,:) = [];

        %% Determine season.

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

        %% Combine tables.

        PSAT = [PSAT; tmp];

        clear tmp
    end

    clear TOPPID

end
clear i

clear files

PSAT.Date.TimeZone = 'UTC';

%% Fix assignment to region.
% Because of the differences in land area used to constrain SSM, there are
% points in the Med that are classified to be outside. Use the following to
% determine region.

ind0 = find(PSAT.Region == 0 & PSAT.Longitude >= -5.6061);
indf = find(PSAT.Region ~= 0 & PSAT.Longitude >= -5.6061);

for i = 1:length(ind0)
    [~,ind] = min(abs(indf-ind0(i)));
    PSAT.Region(ind0(i)) = PSAT.Region(indf(ind));
end
clear i
clear ind*

PSAT.Region(PSAT.Longitude <= -5.6061) = 0;
PSAT.Region(PSAT.Latitude > 46) = 0;

%% Find sunrise and sunset time to determine if observation is day or night.

[SRISE,SSET] = sunrise(PSAT.Latitude,PSAT.Longitude,0,0,PSAT.DateTime);
PSAT.DayNight = zeros(height(PSAT),1);
PSAT.DayNight(PSAT.DateTime > datetime(SRISE,'ConvertFrom','datenum','TimeZone','UTC') & PSAT.DateTime < datetime(SSET,'ConvertFrom','datenum','TimeZone','UTC')) = 1;

clear SRISE
clear SSET
