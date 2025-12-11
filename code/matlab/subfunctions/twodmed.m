function [binned] = twodmed(lon, lat, values, lonEdges, latEdges)
    % TWODMED Compute 2D binned median values and counts
    %
    % Inputs:
    %   lon, lat   - coordinate vectors
    %   values     - values to compute median for
    %   lonEdges   - longitude bin edges
    %   latEdges   - latitude bin edges
    %
    % Outputs:
    %   binned     - structure containing:
    %       .mz      - median values in each bin (nLon x nLat)
    %       .LONmid  - longitude bin midpoints
    %       .LATmid  - latitude bin midpoints

    % Get bin dimensions
    nLonBins = length(lonEdges) - 1;
    nLatBins = length(latEdges) - 1;
    LONmid = (lonEdges(1:end-1)+lonEdges(2:end))/2;
    LATmid = (latEdges(1:end-1)+latEdges(2:end))/2;

    % Calculate bin midpoints
    binned.LONmid = repmat(LONmid', [1 nLatBins]);
    binned.LATmid = repmat(LATmid, [nLonBins 1]);
    
    % Initialize output
    binned.mz = NaN(nLonBins, nLatBins);
    counts = zeros(nLonBins, nLatBins);
    
    % Bin the data
    [counts, ~, ~, indLon, indLat] = histcounts2(lon, lat, lonEdges, latEdges);
    
    % Remove invalid points (outside bin edges or NaN values)
    valid = (indLon > 0) & (indLat > 0) & ~isnan(values);
    indLon = indLon(valid);
    indLat = indLat(valid);
    values = values(valid);
    
    % Compute median for each bin
    for i = 1:nLonBins
        for j = 1:nLatBins
            mask = (indLon == i) & (indLat == j);
            if any(mask)
                binned.mz(i, j) = median(values(mask), 'omitnan');
            end
        end
    end
end

