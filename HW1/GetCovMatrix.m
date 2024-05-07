function R = GetCovMatrix(S_time)
    % Inputs:
    % S_time : 2D matrix [numFreqs x numMics]
    % Output:
    % R : covariance matrix

    [numFreqs, numMics] = size(S_time);
    R = zeros(numMics, numMics, numFreqs);

    for f = 1:numFreqs
        % Extract the signals at frequency f for all microphones
        S_f = S_time(f, :).'; % Column vector [numMics x 1]

        % Outer product and accumulation for single time frame
        R(:, :, f) = S_f * S_f';
    end
end
