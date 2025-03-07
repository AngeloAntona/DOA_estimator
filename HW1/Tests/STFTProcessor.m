
function [S, f, t] = STFTProcessor(x, fs, window, overlap, nfft)
    % Computes the STFT using the FFT function.
    % Inputs:
    % - x: input signal
    % - fs: sampling frequency
    % - window: temporal window
    % - overlap: overlap between frames
    % - nfft: number of FFT points
    % Outputs:
    % S : STFT matrix
    % f : frequency vector
    % t : time vector

    % Calculate the length of the window
    window_length = length(window);
    
    % Calculate the number of overlapping samples
    overlap_length = round(overlap * window_length);
    
    % Calculate the number of FFT points
    if isempty(nfft)
        nfft = max(256, 2^nextpow2(window_length));
    end
    
    % Calculate the number of frames
    num_frames = 1 + floor((length(x) - window_length) / overlap_length);
    
    % Initialize the STFT matrix
    num_freqs = floor(nfft / 2) + 1;  % Calculate the number of positive frequencies
    S = zeros(num_freqs, num_frames);
    
    % Apply the STFT to each frame
    for i = 1:num_frames
        % Indices of the samples corresponding to the current frame
        idx = (i - 1) * overlap_length + (1:window_length);
        
        % Apply the window to the current frame
        frame = x(idx) .* window;

        % Zero-pad the frame to the next power of two (customFFT
        % can only handle signals with a length of 2^n)
        padded_frame = [frame', zeros(1, nfft - window_length)];
        
        % Compute the FFT of the zero-padded frame
        X = customFFT(padded_frame);
        
        % Keep only the positive half of the frequency spectrum
        S(:, i) = X(1:num_freqs);
    end
    
    % Compute the frequency axis (positive half only)
    f = linspace(0, fs/2, num_freqs);
    
    % Compute the time axis
    t = (window_length / 2 + overlap_length * (0:num_frames - 1)) / fs;
end

