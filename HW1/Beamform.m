function [p_theta_time] = Beamform(S, d, c, Fs, numMics, theta_range)
    % Inputs:
    % S - 3D matrix of STFT results [frequency x time x channel (microphone)]
    % d - microphone spacing in meters
    % c - speed of sound in m/s
    % Fs - sampling frequency
    % numMics - number of microphones in the array
    % theta_range - array of angles to compute DOA estimates

    % Output:
    % p_theta_time : 3D matrix where each "page" (third dimension) represents a different type of average:
    % Page 1: Arithmetic mean
    % Page 2: Harmonic mean
    % Page 3: Geometric mean

    [numFreqs, numTimeFrames, ~] = size(S);
    p_theta_time_freq = zeros(length(theta_range), numTimeFrames, numFreqs); % Temporary 3D matrix for storing frequency-specific powers
    p_theta_time = zeros(length(theta_range), numTimeFrames, 3); % Initialize the output matrix with an extra dimension for the three means
    freqs = linspace(0, Fs/2, numFreqs);

    for timeIdx = 1:numTimeFrames
        S_time = squeeze(S(:, timeIdx, :)); % [numFreqs x numMics]
        R = GetCovMatrix(S_time);

        for i = 1:length(theta_range)
            for f = 1:numFreqs
                a = GetSteeringVector(theta_range(i), d, c, numMics, freqs(f));
                p_theta_time_freq(i, timeIdx, f) = abs(a' * R(:,:,f) * a) / numMics^2;
            end
        end
    end

    % Compute the average power across frequencies
    p_theta_time(:,:,1) = mean(p_theta_time_freq, 3); % Arithmetic mean

    % Compute the harmonic mean across frequencies
    harmonic_mean_inv = mean(1 ./ p_theta_time_freq, 3);
    p_theta_time(:,:,2) = 1 ./ harmonic_mean_inv; % Harmonic mean

    % Compute the geometric mean across frequencies
    geometric_mean_log = sum(log(p_theta_time_freq + 1e-10), 3) / numFreqs;
    p_theta_time(:,:,3) = exp(geometric_mean_log); % Geometric mean

    % Normalization step
    max_p = max(p_theta_time(:));
    if max_p > 0
        p_theta_time = p_theta_time / max_p;
    end
end
