function [p_theta_time] = Beamform(S, d, c, Fs, numMics, theta_range)
    % Input S is now assumed to be a 4D matrix: [numFreqs, numFrames, numMics, numTimeFrames]

    [numFreqs, numFrames, numMics, numTimeFrames] = size(S);
    p_theta_time = zeros(length(theta_range), numTimeFrames); % Results for each time frame

    for timeIdx = 1:numTimeFrames
        R = GetCovMatrix(S(:,:,:,timeIdx));  % Calculate the covariance matrix for each time frame
        numFreqs = size(R, 3);  % Number of frequency bins from the covariance matrix
        freqs = linspace(0, Fs/2, numFreqs);  % Frequency vector to match the covariance matrix

        for i = 1:length(theta_range)
            for f = 1:numFreqs
                a = GetSteeringVector(theta_range(i), d, c, numMics, freqs(f));  % Get steering vector for each frequency
                p_theta_time(i, timeIdx) = p_theta_time(i, timeIdx) + abs(a' * R(:,:,f) * a);  % Accumulate power
            end
            p_theta_time(i, timeIdx) = p_theta_time(i, timeIdx) / (numMics^2);  % Normalize by number of microphones squared
        end
    end

    % Normalize the output power over all time frames
    max_p = max(p_theta_time(:));
    if max_p > 0
        p_theta_time = p_theta_time / max_p;
    end
end