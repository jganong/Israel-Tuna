function [mz, counts] = twodmed(lon, lat, values, lonEdges, latEdges)
    % TWODMED Compute 2D binned median values and counts
    %
    % Inputs:
    %   lon, lat   - coordinate vectors
    %   values     - values to compute median for
    %   lonEdges   - longitude bin edges
    %   latEdges   - latitude bin edges
    %
    % Outputs:
    %   mz         - median values in each bin (nLon x nLat)
    %   counts     - number of points in each bin

    % Get bin dimensions
    nLonBins = length(lonEdges) - 1;
    nLatBins = length(latEdges) - 1;
    
    % Initialize output
    mz = NaN(nLonBins, nLatBins);
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
        for j = 1%nLatBins
            mask = (indLon == i) & (indLat == j);
            if any(mask)
                mz(i, j) = median(values(mask), 'omitnan');
            end
        end
    end
end
