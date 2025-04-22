%% load_tseries_IL
% Sub-function of IsraelTuna.m; loads series data from transmitted tags.

%% Go to folder.

cd([fdir '/data/tseries']);

%% Get list of files.

files = dir('*Series.csv');

%% Loop through files.

for i = 1:length(files)

    disp(i)

    if ismember(str2double(files(i).name(1:7)),META.toppID) == 0
        continue
    end

    if exist('TSERIES','var') == 0

        %% Set up the import options
        opts = delimitedTextImportOptions("NumVariables", 14);

        % Specify range and delimiter
        opts.DataLines = [2, Inf];
        opts.Delimiter = ",";

        % Specify column names and types
        opts.VariableNames = ["ptt", "Var2", "Var3", "Var4", "Var5", "Day", "Time", "Var8", "Var9", "Var10", "Depth", "DRange", "Temperature", "TRange"];
        opts.SelectedVariableNames = ["ptt", "Day", "Time", "Depth", "DRange", "Temperature", "TRange"];
        opts.VariableTypes = ["double", "char", "char", "char", "char", "datetime", "datetime", "char", "char", "char", "double", "double", "double", "double"];

        % Specify file level properties
        opts.ExtraColumnsRule = "ignore";
        opts.EmptyLineRule = "read";

        % Specify variable properties
        opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var8", "Var9", "Var10"], "WhitespaceRule", "preserve");
        opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var8", "Var9", "Var10"], "EmptyFieldRule", "auto");
        opts = setvaropts(opts, "Day", "InputFormat", "dd-MMM-yyyy");
        opts = setvaropts(opts, "Time", "InputFormat", "HH:mm:ss");

        %% Load data.

        TSERIES = readtable(files(i).name,opts);

        TSERIES.DateTime = datetime(year(TSERIES.Day),month(TSERIES.Day),day(TSERIES.Day),...
            hour(TSERIES.Time),minute(TSERIES.Time),second(TSERIES.Time));
        TSERIES(:,2:3) = [];
        TSERIES = movevars(TSERIES, 'DateTime', 'Before', 'Depth');

        TSERIES.TOPPID = str2double(files(i).name(1:7))*ones(size(TSERIES,1),1);
        TSERIES = movevars(TSERIES, 'TOPPID', 'Before', 'DateTime');

        %% Remove data before deployment date.

        TSERIES(TSERIES.DateTime <= META.taggingdate(META.toppID == TSERIES.TOPPID(1)),:) = [];

        %% Remove data after first date of "last" or manual.

        date_rm = min([META.popdate(META.toppID == TSERIES.TOPPID(1)),...
            META.recdate(META.toppID == TSERIES.TOPPID(1)), ...
            META.date_last_depth(META.toppID == TSERIES.TOPPID(1)), ...
            META.date_last_light(META.toppID == TSERIES.TOPPID(1)), ...
            META.date_last_lon(META.toppID == TSERIES.TOPPID(1)), ...
            META.manual_cut_date(META.toppID == TSERIES.TOPPID(1))]);

        TSERIES(TSERIES.DateTime >= date_rm,:) = [];

        clear date_rm

        %% Remove data after last SSM date.

        TSERIES(TSERIES.DateTime > max(SSM.Date(SSM.TOPPID == TSERIES.TOPPID(1))),:) = [];

        %% Time Zone Correction

        if isnan(META.timezone_correction(META.toppID == TSERIES.TOPPID(1)))
            tz = '+00:00';
        elseif META.timezone_correction(META.toppID == TSERIES.TOPPID(1)) >= 0 
            tz = ['+0' num2str(META.timezone_correction(META.toppID == TSERIES.TOPPID(1))) ':00'];
        else
            tz = ['-0' num2str(abs(META.timezone_correction(META.toppID == TSERIES.TOPPID(1)))) ':00'];
        end
        TSERIES.DateTime.TimeZone = tz;
        clear tz

        TSERIES.DateTime.TimeZone = 'UTC';

        TSERIES.Date = datetime(year(TSERIES.DateTime),month(TSERIES.DateTime),day(TSERIES.DateTime));
        TSERIES = movevars(TSERIES, 'Date', 'Before', 'Depth');

        %% Interpolate SSM positions to match TSERIES data.

        TSERIES.Longitude = interp1(datenum(SSM.Date(SSM.TOPPID == TSERIES.TOPPID(1))),...
            SSM.Longitude(SSM.TOPPID == TSERIES.TOPPID(1)),datenum(TSERIES.DateTime));

        TSERIES.Latitude = interp1(datenum(SSM.Date(SSM.TOPPID == TSERIES.TOPPID(1))),...
            SSM.Latitude(SSM.TOPPID == TSERIES.TOPPID(1)),datenum(TSERIES.DateTime));

        %% Remove values outside of the Med.

        ind = TSERIES.Longitude <= -5.6061;
        TSERIES(ind,:) = [];

        ind = TSERIES.Latitude >= 46;
        TSERIES(ind,:) = [];

        %% Determine season.

        % 1 = Fall which includes September, October and November.
        % 2 = Winter which includes December, January and February.
        % 3 = Spring which includes March, April and May.
        % 4 = Summer which includes June, July and August.

        TSERIES.Season = zeros(length(TSERIES.Latitude),1);
        TSERIES.Season(month(TSERIES.DateTime) == 9 | month(TSERIES.DateTime) == 10 | month(TSERIES.DateTime) == 11) = 1;
        TSERIES.Season(month(TSERIES.DateTime) == 12 | month(TSERIES.DateTime) == 1 | month(TSERIES.DateTime) == 2) = 2;
        TSERIES.Season(month(TSERIES.DateTime) == 3 | month(TSERIES.DateTime) == 4 | month(TSERIES.DateTime) == 5) = 3;
        TSERIES.Season(month(TSERIES.DateTime) == 6 | month(TSERIES.DateTime) == 7 | month(TSERIES.DateTime) == 8) = 4;

        %% Determine hotspot.

        TSERIES.Region = zeros(height(TSERIES.TOPPID),1);
        TSERIES.Region(inpolygon(TSERIES.Longitude,TSERIES.Latitude,regions.Alboran(:,1),regions.Alboran(:,2))) = 1;
        TSERIES.Region(inpolygon(TSERIES.Longitude,TSERIES.Latitude,regions.WesternMed(:,1),regions.WesternMed(:,2))) = 2;
        TSERIES.Region(inpolygon(TSERIES.Longitude,TSERIES.Latitude,regions.Adriatic(:,1),regions.Adriatic(:,2))) = 3;
        TSERIES.Region(inpolygon(TSERIES.Longitude,TSERIES.Latitude,regions.Ionian(:,1),regions.Ionian(:,2))) = 4;
        TSERIES.Region(inpolygon(TSERIES.Longitude,TSERIES.Latitude,regions.Tunisian(:,1),regions.Tunisian(:,2))) = 5;
        TSERIES.Region(inpolygon(TSERIES.Longitude,TSERIES.Latitude,regions.Aegean(:,1),regions.Aegean(:,2))) = 6;
        TSERIES.Region(inpolygon(TSERIES.Longitude,TSERIES.Latitude,regions.Levantine(:,1),regions.Levantine(:,2))) = 7;

    else

        %% Set up the import options
        opts = delimitedTextImportOptions("NumVariables", 14);

        % Specify range and delimiter
        opts.DataLines = [2, Inf];
        opts.Delimiter = ",";

        % Specify column names and types
        opts.VariableNames = ["ptt", "Var2", "Var3", "Var4", "Var5", "Day", "Time", "Var8", "Var9", "Var10", "Depth", "DRange", "Temperature", "TRange"];
        opts.SelectedVariableNames = ["ptt", "Day", "Time", "Depth", "DRange", "Temperature", "TRange"];
        opts.VariableTypes = ["double", "char", "char", "char", "char", "datetime", "datetime", "char", "char", "char", "double", "double", "double", "double"];

        % Specify file level properties
        opts.ExtraColumnsRule = "ignore";
        opts.EmptyLineRule = "read";

        % Specify variable properties
        opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var8", "Var9", "Var10"], "WhitespaceRule", "preserve");
        opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var8", "Var9", "Var10"], "EmptyFieldRule", "auto");
        opts = setvaropts(opts, "Day", "InputFormat", "dd-MMM-yyyy");
        opts = setvaropts(opts, "Time", "InputFormat", "HH:mm:ss");

        %% Load data.

        tmp = readtable(files(i).name,opts);

        tmp.DateTime = datetime(year(tmp.Day),month(tmp.Day),day(tmp.Day),...
            hour(tmp.Time),minute(tmp.Time),second(tmp.Time));
        tmp(:,2:3) = [];
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

        if isnan(META.timezone_correction(META.toppID == tmp.TOPPID(1)))
            tz = '+00:00';
        elseif META.timezone_correction(META.toppID == tmp.TOPPID(1)) >= 0 
            tz = ['+0' num2str(META.timezone_correction(META.toppID == tmp.TOPPID(1))) ':00'];
        else
            tz = ['-0' num2str(abs(META.timezone_correction(META.toppID == tmp.TOPPID(1)))) ':00'];
        end
        tmp.DateTime.TimeZone = tz;
        clear tz

        tmp.DateTime.TimeZone = 'UTC';

        tmp.Date = datetime(year(tmp.DateTime),month(tmp.DateTime),day(tmp.DateTime));
        tmp = movevars(tmp, 'Date', 'Before', 'Depth');

        %% Interpolate SSM positions to match tmp data.

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

        %% Combine tables.

        TSERIES = [TSERIES; tmp];

        clear tmp
    end

    clear TOPPID

end
clear i
clear opts

clear files

TSERIES.Date.TimeZone = 'UTC';

%% Fix assignment to region.
% Because of the differences in land area used to constrain SSM, there are
% points in the Med that are classified to be outside. Use the following to
% determine region.

ind0 = find(TSERIES.Region == 0 & TSERIES.Longitude >= -5.6061);
indf = find(TSERIES.Region ~= 0 & TSERIES.Longitude >= -5.6061);

for i = 1:length(ind0)
    [~,ind] = min(abs(indf-ind0(i)));
    TSERIES.Region(ind0(i)) = TSERIES.Region(indf(ind));
end
clear i
clear ind*

TSERIES.Region(TSERIES.Longitude <= -5.6061) = 0;
TSERIES.Region(TSERIES.Latitude > 46) = 0;

%% Find sunrise and sunset time to determine if observation is day or night.

[SRISE,SSET] = sunrise(TSERIES.Latitude,TSERIES.Longitude,0,0,TSERIES.DateTime);
TSERIES.DayNight = zeros(height(TSERIES),1);
TSERIES.DayNight(TSERIES.DateTime > datetime(SRISE,'ConvertFrom','datenum','TimeZone','UTC') & TSERIES.DateTime < datetime(SSET,'ConvertFrom','datenum','TimeZone','UTC')) = 1;

clear SRISE
clear SSET