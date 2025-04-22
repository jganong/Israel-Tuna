%% load_minmax_IL.m
% Sub-function of IsraelTuna.m; loads data from recovered tags.

%% Go to folder.

cd([fdir '/data/minmax']);

%% Get list of files.

files = dir('*MinMaxDepth.csv');

%% Loop through files.

for i = 1:length(files)

    disp(i)

    if ismember(str2double(files(i).name(1:7)),META.toppID) == 0
        continue
    end

    %% Set up the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 14);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Date", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "MaxDepth", "Var13", "Var14"];
    opts.SelectedVariableNames = ["Date", "MaxDepth"];
    opts.VariableTypes = ["char", "char", "char", "char", "datetime", "char", "char", "char", "char", "char", "char", "double", "char", "char"];

    % Specify file level properties
    opts.ImportErrorRule = "omitrow";
    opts.MissingRule = "omitrow";
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var13", "Var14"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var13", "Var14"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "Date", "InputFormat", "MM/dd/yyyy HH:mm:ss");

    %% Load data.

    MINMAX = readtable(files(i).name,opts);
    MINMAX.Date = datetime(year(MINMAX.Date),month(MINMAX.Date),day(MINMAX.Date));
    MINMAX.TOPPID = str2double(files(i).name(1:7))*ones(size(MINMAX,1),1);
    MINMAX.Properties.VariableNames{2} = 'max_Depth';
    MINMAX = movevars(MINMAX, 'TOPPID', 'Before', 'Date');

    MINMAX(MINMAX.Date <= META.taggingdate(META.toppID == MINMAX.TOPPID(1)),:) = [];
    MINMAX(MINMAX.Date >= min(META.popdate(META.toppID == MINMAX.TOPPID(1)),META.recdate(META.toppID == MINMAX.TOPPID(1))),:) = [];
    
    MINMAX.Date.TimeZone = 'UTC';
    MINMAX(MINMAX.Date >= max(SSM.Date(SSM.TOPPID == MINMAX.TOPPID(1))),:) = [];

    %% Merge MinMaxDepth.csv with SSM table.

    ind = (ismember(SSM.Date,MINMAX.Date) + ismember(SSM.TOPPID,MINMAX.TOPPID)) == 2;
    SSM.max_Depth(ind) = MINMAX.max_Depth;

    %% Clear
    
    clear MINMAX
end
clear i
clear ind
clear opts
clear files