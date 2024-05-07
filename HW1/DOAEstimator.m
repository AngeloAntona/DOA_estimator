function doa_estimates = DOAEstimator(p_theta_time, theta_range)
    % DOAEstimator - Estimate the DOA from the beamformed output for each type of mean.
    %
    % Inputs:
    %   p_theta_time - A 3D matrix where each page (third dimension) represents a different type of average:
    %                  Page 1: Arithmetic mean
    %                  Page 2: Harmonic mean
    %                  Page 3: Geometric mean
    %   theta_range - The range of DOA angles corresponding to the rows in p_theta_time.
    %
    % Outputs:
    %   doa_estimates - A 2D matrix containing the estimated DOA for each time frame and each type of mean.
    %                   Each row corresponds to a different mean.

    % Number of types of means (pages in the matrix)
    numMeans = size(p_theta_time, 3);
    numTimeFrames = size(p_theta_time, 2);

    % Initialize the output matrix to store DOA estimates
    doa_estimates = zeros(numMeans, numTimeFrames);

    % Loop through each type of mean
    for meanIdx = 1:numMeans
        % Extract the matrix for the current mean
        current_p_theta_time = p_theta_time(:, :, meanIdx);

        % Loop through each time frame to find the angle with the maximum power
        for timeIdx = 1:numTimeFrames
            % Find the index of the maximum power at this time frame
            [~, maxIdx] = max(current_p_theta_time(:, timeIdx));

            % Store the corresponding angle as the DOA estimate
            doa_estimates(meanIdx, timeIdx) = theta_range(maxIdx);
        end
    end
end
