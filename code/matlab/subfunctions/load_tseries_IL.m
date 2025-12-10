%% load_tseries_IL
% Sub-function of IsraelTuna.m; loads series data from transmitted tags.

%
% Go to folder.




%% Get list of files, but instead of using /data/dc, get from /TOPP




TSERIES=cell(height(META),1); % empty placeholder cell array to hold tables

for i = 1:height(META)
    row=META(i,:);

    file=strcat('/TOPP/Tuna/ABFT/Recovery/PAT/',string(row.toppID),'_',row.tagnumber, '/processing/',string(row.toppID),'_',row.tagnumber,'-Series.csv');

    % file is dervied from META so no need to skip files not in META
    % (there are none, because we are starting from META))
    %
    % BUT CONVERSELY, THERE ARE SOME ROWS IN META WITH NO DC FILE,
    % SO WE HAVE TO DO THE REVERSE CHECK

    if exist(file,'file')
	CENSUS.TSERIES_FILE(i) = file;
    else
        continue
    end



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

        tmp = readtable(file,opts);
	CENSUS.TSERIES_RAW(i) = height(tmp);

        tmp.DateTime = datetime(year(tmp.Day),month(tmp.Day),day(tmp.Day),...
            hour(tmp.Time),minute(tmp.Time),second(tmp.Time));
        tmp(:,2:3) = [];
        tmp = movevars(tmp, 'DateTime', 'Before', 'Depth');

        tmp.TOPPID(:) = row.toppID;
        tmp = movevars(tmp, 'TOPPID', 'Before', 'DateTime');

        %% Remove data before deployment date.

        tmp(tmp.DateTime <= row.taggingdate,:) = [];

        %% Remove data after first date of "last" or manual.


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

        tmp(tmp.DateTime >= date_rm,:) = [];


        %% Remove data after last SSM date.

        tmp(tmp.DateTime > max(SSM.Date(SSM.TOPPID == row.toppID)),:) = [];

        %% Time Zone Correction

        if isnan(row.timezone_correction)
            tz = '+00:00';
        elseif row.timezone_correction >= 0 
            tz = ['+0' num2str(row.timezone_correction)   ':00'];
        else
            tz = ['-0' num2str(abs(row.timezone_correction)) ':00'];
        end
        tmp.DateTime.TimeZone = tz;
        clear tz

        tmp.DateTime.TimeZone = 'UTC';

        tmp.Date = datetime(year(tmp.DateTime),month(tmp.DateTime),day(tmp.DateTime));
        tmp = movevars(tmp, 'Date', 'Before', 'Depth');

        %% Interpolate SSM positions to match tmp data.
	mask = SSM.TOPPID == row.toppID;
	CENSUS.TSERIES_TRIMMED(i) = height(tmp); % in case we bail out 
	if sum(mask) < 2
		disp([ num2str(row.toppID) 'cannot interpolate with less than 2 SSM locations']);
		continue;
	end
        tmp.Longitude = interp1(datenum(SSM.Date(mask)),...
            SSM.Longitude(mask),datenum(tmp.DateTime));

        tmp.Latitude = interp1(datenum(SSM.Date(mask)),...
            SSM.Latitude(mask), datenum(tmp.DateTime));

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

	CENSUS.TSERIES_TRIMMED(i) = height(tmp);
        TSERIES{i} = tmp;

end
% combine separate tables into one table, dropping empty tables
TSERIES = cat(1,TSERIES{:});

if isempty(TSERIES)
	disp('no TSERIES found') % warning() does not work here
	return
end

TSERIES.Date.TimeZone = 'UTC';

%% Fix assignment to region.
% Because of the differences in land area used to constrain SSM, there are
% points in the Med that are classified to be outside. Use the following to
% determine region.
% This version uses nearest neighbor interpolation for speed
ind0 = find(TSERIES.Region == 0 & TSERIES.Longitude >= -5.6061);
indf = find(TSERIES.Region ~= 0 & TSERIES.Longitude >= -5.6061);
rf = TSERIES.Region(indf);
r0 = interp1(indf, rf, ind0,'nearest');
TSERIES.Region(ind0) = r0;

TSERIES.Region(TSERIES.Longitude <= -5.6061) = 0;
TSERIES.Region(TSERIES.Latitude > 46) = 0;

%% Find sunrise and sunset time to determine if observation is day or night.

[SRISE,SSET] = sunrise(TSERIES.Latitude,TSERIES.Longitude,0,0,TSERIES.DateTime);
TSERIES.DayNight = zeros(height(TSERIES),1);
TSERIES.DayNight(TSERIES.DateTime > datetime(SRISE,'ConvertFrom','datenum','TimeZone','UTC') & TSERIES.DateTime < datetime(SSET,'ConvertFrom','datenum','TimeZone','UTC')) = 1;

