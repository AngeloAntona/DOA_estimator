function [S_multi, f, t] = AllChannelSTFT(signal, fs, window, overlap, nfft, MicrophoneCount)
% This function calculates the STFT for each channel of a multichannel signal.
%
% Inputs:
% - signal: multichannel signal, where each column is the signal from one microphone
% - fs: sampling frequency
% - window: window function applied to each frame of the STFT
% - overlap: proportion of overlap between consecutive frames
% - nfft: number of FFT points
% - MicrophoneCount: number of channels/microphones
%
% Outputs:
% - S_multi: 3D array containing STFTs for each channel (frequency x time x channel)
% - f: frequency axis for STFT
% - t: time axis for STFT

% Verify the size of the signal to ensure it has the correct number of channels
if size(signal, 2) ~= MicrophoneCount
    error('The number of channels in the signal does not match MicrophoneCount.');
end

% Initialize the output STFT array
S_multi = []; % Will be initialized after the first call to STFTProcessor

% Process each channel individually
for mic = 1:MicrophoneCount
    [S, f, t] = STFTProcessor(signal(:, mic), fs, window, overlap, nfft);

    % If this is the first microphone, initialize the 3D STFT array
    if isempty(S_multi)
        S_multi = zeros(size(S, 1), size(S, 2), MicrophoneCount);
    end

    % Store the result in the corresponding "slice" of the 3D array
    S_multi(:, :, mic) = S;
end

end