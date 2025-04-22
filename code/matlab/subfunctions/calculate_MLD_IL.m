%% calculate_MLD_IL.m
% Sub-function of IsraelTuna; calculates mixed layer depth and sea surface
% temperature every day by (1) averaging data into 1-m bins, (2) vertically
% interpolating data onto a 1-m regular grid, (3) smoothed with a 20-m
% window and (4) computes MLD using threshold definition from
% Boyer Montégut et al (2004).

% Requires Climate Data Toolbox (http://www.chadagreene.com/CDT/CDT_Contents.html)

%% Loop through each tag.

toppID = unique(PSAT.TOPPID);

oce = struct();
for i = 1:length(toppID)

    disp(toppID(i));

    %% Create daily datetime vector.

    t = PSAT.Date(PSAT.TOPPID == toppID(i));
    t = unique(t);

    %% Create 1-m bin averaged, interpolated, daily profiles.

    for j = 1:length(t)

        tmp = PSAT(PSAT.TOPPID == toppID(i) & PSAT.Date == t(j),:);

        % Average temperature data in 1-m bins.
        bins.d_bin = floor(min(tmp.Depth)):1:ceil(max(tmp.Depth))+1; % create 1-m bins between minimum and maximum depth
        bins.d_cat = discretize(tmp.Depth,bins.d_bin.'); % determine which bin each depth-temperature measurement was made in

        bins.t_avg = accumarray(bins.d_cat,tmp.Temperature,[],@mean); % take average of all temperatures in 1-m bin
        bins.t_binned = bins.t_avg(bins.t_avg ~= 0); bins.d_binned = bins.d_bin(bins.t_avg ~= 0); % remove empty bins between minimum and maximum depth

        if length(bins.t_binned) >= 4

            % Interpolate onto a 1-m regular grid between minimum and maximum depth.
            interp.d = min(bins.d_bin):1:max(bins.d_bin);
            interp.t = gsw_t_interp(bins.t_binned,bins.d_binned,interp.d);
    
            % Remove NaNs.
            interp.d = interp.d(~isnan(interp.t));
            interp.t = interp.t(~isnan(interp.t));
    
            % Smooth profile applying moving median with a window 20 m window.
            pfl.Depth = interp.d.';
            pfl.Temperature = smoothdata(interp.t,'movmedian',20);
    
            % Add NaNs from 0 to minimum depth if profile does not start at 0 m.
            if min(bins.d_bin) ~= 0
                pfl.Depth = [transpose(0:min(bins.d_bin)-1); pfl.Depth];
                pfl.Temperature = [NaN(length(0:min(bins.d_bin)-1),1); pfl.Temperature];
            end

        else

            pfl.Depth = NaN(1500,1);
            pfl.Temperature = NaN(1500,1);

        end

        %% Calculate mixed layer depth using threshold definition from Boyer Montégut et al (2004).
        % Δ_T = 0.2 deg C greater than the temperature at 10 m depth
        % Also compute temperature at the MLD, depth of the temperature
        % mininum and max depth of profiles.

        if length(pfl.Depth(~isnan(pfl.Temperature))) <= 25 % must have a profile spanning at least 25 meters to compute MLD

            oce(i).mld(j) = NaN;
            oce(i).T_at_mld(j) = NaN;
            oce(i).SST(j) = median(pfl.Temperature(~isnan(pfl.Temperature) & pfl.Depth <= 5));

        elseif min(pfl.Depth(~isnan(pfl.Temperature))) <= 10 % must have a mininmum depth less than 10 m

            oce(i).mld(j) = mld(pfl.Depth(~isnan(pfl.Temperature)),pfl.Temperature(~isnan(pfl.Temperature)),'metric','threshold','tthresh',0.2); % m
            oce(i).T_at_mld(j) = interp1(pfl.Depth(~isnan(pfl.Temperature)),pfl.Temperature(~isnan(pfl.Temperature)),oce(i).mld(j));
            oce(i).SST(j) = median(pfl.Temperature(~isnan(pfl.Temperature) & pfl.Depth <= 5));

            if oce(i).mld(j) == 0 % mixed layer depth is not 0 m anywhere
                oce(i).mld(j) = NaN;
                oce(i).T_at_mld(j) = NaN;
            end

        else

            oce(i).mld(j) = NaN;
            oce(i).T_at_mld(j) = NaN;
            oce(i).SST(j) = median(pfl.Temperature(~isnan(pfl.Temperature) & pfl.Depth <= 5));

        end

        oce(i).toppID(j) = toppID(i);

        %% Clear

        clear tmp
        clear bins
        clear interp
        clear pfl

    end
    clear j

    oce(i).t = t;

    oce(i).lat = NaN(length(t),1);
    oce(i).lon = NaN(length(t),1);
    for j = 1:length(t)
        ind_time = find(SSM.Date == t(j));
        ind_topp = find(SSM.TOPPID == toppID(i));

        ind = intersect(ind_time,ind_topp);

        oce(i).lat(j) = SSM.Latitude(ind);
        oce(i).lon(j) = SSM.Longitude(ind);
    end
    clear j
    clear ind*

    oce(i).region = NaN(length(t),1);
    for j = 1:length(t)
        ind_time = find(SSM.Date == t(j));
        ind_topp = find(SSM.TOPPID == toppID(i));

        ind = intersect(ind_time,ind_topp);

        oce(i).region(j) = SSM.Region(ind);
    end
    clear j
    clear ind*

    oce(i).season = NaN(length(t),1);
    for j = 1:length(t)
        ind_time = find(SSM.Date == t(j));
        ind_topp = find(SSM.TOPPID == toppID(i));

        ind = intersect(ind_time,ind_topp);

        oce(i).season(j) = SSM.Season(ind);
    end
    clear j
    clear ind*

    clear t

end
clear i
clear toppID

%% Reshape

tmp.mld = [oce.mld].';
tmp.T_at_mld = [oce.T_at_mld].';
tmp.SST = [oce.SST].';
tmp.lat = vertcat(oce.lat).';
tmp.lon = vertcat(oce.lon).';
tmp.region = vertcat(oce.region).';
tmp.season = vertcat(oce.season).';
tmp.t = vertcat(oce.t).';
tmp.toppID = [oce.toppID].';

oce = tmp;
oce.lat = oce.lat.';
oce.lon = oce.lon.';
oce.region = oce.region.';
oce.season = oce.season.';
oce.t = oce.t.';
clear tmp

oce = struct2table(oce);

cd([fdir '/data/mld']);
writetable(oce,'IsraelTuna_MLD.csv')