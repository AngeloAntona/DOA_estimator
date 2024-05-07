function doa_estimates = DOAEstimator(p_theta_time, theta_range)
    % DOAEstimator - Estimate the DOA from the beamformed output for each time frame.
    %
    % Inputs:
    %   p_theta_time - A matrix of size (num_angles x num_time_frames)
    %                  containing power values for each angle and time frame.
    %   theta_range - The range of DOA angles corresponding to the rows in p_theta_time.
    %
    % Outputs:
    %   doa_estimates - An array containing the estimated DOA for each time frame.

    % Initialize the output array to store DOA estimates
    numTimeFrames = size(p_theta_time, 2);
    doa_estimates = zeros(1, numTimeFrames);

    % Loop through each time frame to find the angle with the maximum power
    for timeIdx = 1:numTimeFrames
        % Find the index of the maximum power at this time frame
        [~, maxIdx] = max(p_theta_time(:, timeIdx));

        % Store the corresponding angle as the DOA estimate
        doa_estimates(timeIdx) = theta_range(maxIdx);
    end
end
