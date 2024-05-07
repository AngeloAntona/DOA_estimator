function [p_theta_time] = Beamform(S, d, c, Fs, numMics, theta_range)
    % Inputs:
    % S - 3D matrix of STFT results [frequency x time x channel (microphone)]
    % d - microphone spacing in meters
    % c - speed of sound in m/s
    % Fs - sampling frequency
    % numMics - number of microphones in the array
    % theta_range - array of angles to compute DOA estimates

    % Output:
    % p_theta_time : 2D matrix where each element represents the computed power for a specific angle and time frame

    [numFreqs, numTimeFrames, ~] = size(S);
    p_theta_time = zeros(length(theta_range), numTimeFrames);
    freqs = linspace(0, Fs/2, numFreqs); % Frequency vector outside the loop

    for timeIdx = 1:numTimeFrames
        % Extract the slice for the current time frame across all frequencies and microphones
        S_time = squeeze(S(:, timeIdx, :)); % S_time has dimensions [numFreqs x numMics]

        % Calculate the covariance matrix for this time frame
        R = GetCovMatrix(S_time);

        for i = 1:length(theta_range)
            for f = 1:numFreqs
                % Compute the steering vector for the current angle and frequency
                a = GetSteeringVector(theta_range(i), d, c, numMics, freqs(f));
                % Beamforming power accumulation
                p_theta_time(i, timeIdx) = p_theta_time(i, timeIdx) + abs(a' * R(:,:,f) * a);
            end
            % Normalize the accumulated power by the number of microphones squared
            p_theta_time(i, timeIdx) = p_theta_time(i, timeIdx) / numMics^2;
        end
    end

    % Normalize the output power over all time frames
    max_p = max(p_theta_time(:));
    if max_p > 0
        p_theta_time = p_theta_time / max_p;
    end
end
