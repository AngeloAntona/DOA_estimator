%% --------------------------------------------------
% AudioData Test

clc;
clearvars;
close all;

% Path to the audio file within the 'AudioFiles' directory
filepath = 'AudioFiles/array_recordings.wav';

% Verify that the file exists before trying to read
if ~isfile(filepath)
    error('The specified audio file does not exist at the given path.');
end

% Create an instance of the AudioData class
audio_data = AudioData(filepath);

% Display some information about the data before normalization
disp('Audio data info before normalization:');
disp(['Sample Rate: ', num2str(audio_data.SampleRate)]);
disp(['Number of Samples: ', num2str(size(audio_data.Data, 1))]);
disp(['Number of Channels: ', num2str(size(audio_data.Data, 2))]);
disp('9 samples from the first channel:');
disp(audio_data.Data(40000:40009, 1)');

% Normalize the audio data
audio_data = audio_data.normalize();

% Display some information about the data after normalization
disp('Audio data info after normalization:');
disp(['Max value: ', num2str(max(abs(audio_data.Data), [], 'all'))]);
disp('Same 9 samples from the first channel after normalization:');
disp(audio_data.Data(40000:40009, 1)');

%% --------------------------------------------------
% costum FFT test

clc;
clearvars;
close all;


% Define a sample vector of length that is a power of two
n = 256;
x = randn(1, n) + 1i * randn(1, n);  % Random complex numbers

% Compute FFT using the custom function
X_custom = customFFT(x);

% Compute FFT using MATLAB's built-in fft function
X_matlab = fft(x);

% Compare the results
difference = norm(X_custom - X_matlab);
fprintf('Norm of the difference between custom and MATLAB FFT: %e\n', difference);

% Plot the magnitude and phase of the FFT outputs
figure;

subplot(2, 2, 1);
plot(abs(X_custom), 'LineWidth', 2);
title('Magnitude of Custom FFT');
xlabel('Frequency Bin');
ylabel('Magnitude');
grid on;

subplot(2, 2, 2);
plot(abs(X_matlab), 'LineWidth', 2);
title('Magnitude of MATLAB FFT');
xlabel('Frequency Bin');
ylabel('Magnitude');
grid on;

subplot(2, 2, 3);
plot(angle(X_custom), 'LineWidth', 2);
title('Phase of Custom FFT');
xlabel('Frequency Bin');
ylabel('Phase');
grid on;

subplot(2, 2, 4);
plot(angle(X_matlab), 'LineWidth', 2);
title('Phase of MATLAB FFT');
xlabel('Frequency Bin');
ylabel('Phase');
grid on;

% Check if the results are the same within a tolerance
assert(all(abs(X_custom - X_matlab) < 1e-6), 'The results differ more than the acceptable tolerance.');
fprintf('The custom FFT implementation matches MATLAB''s fft function within the tolerance.\n');


%% --------------------------------------------------
% STFTProcessor test

clc;
clearvars;
close all;

% Generate a test signal
% fs = 2000; % Sampling frequency
% t = 0:1/fs:1; % Tempo
% x = sin(2*pi*100*t) + sin(2*pi*200*t) + randn(size(t)); % Test signal

filepath = 'AudioFiles/array_recordings.wav';
% Create an instance of the AudioData class
audio_data = AudioData(filepath);
x = audio_data.Data(:,1);
fs = audio_data.SampleRate;

% STFT Parameters
window = hamming(256); % Hamming Window
overlap = 0.5; % overlap 50%
nfft = 512; % number of FFT points

% Calculate our STFT
[S_custom, f_custom, t_custom] = STFTProcessor(x, fs, window, overlap, nfft);

% Calculate the MATLAB's STFT
[S_matlab, f_matlab, t_matlab] = spectrogram(x, window, overlap*length(window), nfft, fs);

disp(size(S_custom));
disp(size(S_matlab));


% Plot spectrogram from MATLAB's spectrogram function
subplot(1,2,1);
imagesc(t_matlab, f_matlab, abs(S_matlab));
colorbar;
title('MATLAB Spectrogram');
xlabel('Time (s)');
ylabel('Frequency (Hz)');

% Plot spectrogram from custom implementation
subplot(1,2,2);
imagesc(t_custom, f_custom, abs(S_custom));
colorbar;
title('Custom Spectrogram');
xlabel('Time (s)');
ylabel('Frequency (Hz)');


% Confronta i risultati
max_diff = max(abs(S_custom - S_matlab));
if max_diff < 1e-10
    disp('The results coincide.');
else
    disp('The results don't coincide.');
end

%% --------------------------------------------------
% AllChannelSTFT test

clc;
clearvars;
close all;

filepath = 'AudioFiles/array_recordings.wav';
% Create an instance of the AudioData class
audio_data = AudioData(filepath);
multichannel_signal = audio_data.Data;
fs = audio_data.SampleRate;

window = hann(256); % example window function
overlap = 0.5; % 50% overlap
nfft = 512; % number of FFT points
MicrophoneCount = 16; % number of microphones

% Calculate the multichannel STFT
[S_multi, f, t] = AllChannelSTFT(multichannel_signal, fs, window, overlap, nfft, MicrophoneCount);

figure('Position', [100, 0, 1000, 800]);    % [left, bottom, width, height]

for m = 1:MicrophoneCount

    subplot(ceil(MicrophoneCount / 4), 4, m); % divide the plot in 4 rows
    spectrogram = abs(S_multi(:, :, m)); % STFT modulus in order to visualize the amplitude
    imagesc(t, f, 20*log10(spectrogram)); % amplitude algorhitm
    axis xy;
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title(['Microphone ', num2str(m)]);
    colorbar;

end

colormap hot;


%% --------------------------------------------------
% GetCovMatrix test

clc;
clearvars;
close all;


% Number of frequencies, frames and microphones
numFreqs = 10;
numFrames = 100;
numMics = 3;

% Generate synthetic STFT data for the microphones 
% Assuming every element is complex
S = rand(numFreqs, numFrames, numMics) + 1i * rand(numFreqs, numFrames, numMics);

% Call GetCovMAtrix
R = GetCovMatrix(S);

% Print the covariance matrices for each frequency
for f = 1:numFreqs
    fprintf('Covariance matrix for the frequency %d:\n', f);
    disp(R(:,:,f));
end

% Verify hermitian property
for f = 1:numFreqs
    if ishermitian(R(:,:,f))
        fprintf('The covariance matrix at frequency %d is hermitian.\n', f);
    else
        fprintf('Error: The covariance matrix at frequency %d is not hermitian.\n', f);
    end
end

%% --------------------------------------------------
% Final test

clc;
clearvars;
close all;

[audio, fs] = audioread('AudioFiles/array_recordings.wav');

% Normalize across all channels
audio = audio / max(abs(audio(:))); % Normalize by dividing by the maximum absolute value

mics_quantity = 16;
d = 45e-2 / (mics_quantity-1); % distance btw 2 mics
c = 343; % speed of sound in m/s

omega_max = ( pi * c ) / d;
freq_max = min(fs/2, omega_max/(2*pi));

% Parameters
f_test = 3000; % Test frequency (Hz)
n_samples = 117864; % Number of samples
initial_angle_deg = -45; % Initial sound angle (degrees)
final_angle_deg = 45; % Final sound angle (degrees)
angle_deg = linspace(initial_angle_deg, final_angle_deg, n_samples); % Angle as a function of time

% Calculate the relative phase for each microphone based on the angle
lambda = c / f_test; % Wavelength (m)

phases = 2 * pi * (0:mics_quantity-1).' * d * sind(angle_deg) / lambda; % Relative phases for each microphone

% Generate sinusoids with relative phase to simulate sound coming from a specific angle
t = (0:n_samples-1) / fs; % Time (s)
test_matrix = zeros(n_samples, mics_quantity); % Initialize the test matrix
for i = 1:mics_quantity
    test_matrix(:, i) = sin(2 * pi * f_test * t + phases(i,:));
end

multichannel_signal=test_matrix;

window = hann(1024); 
overlap = 0.8; 
nfft = 1024; 
MicrophoneCount = 16;
thetaRange = linspace(-90,90,180);

% DOA Estimation.
[S_multi, f, t] = AllChannelSTFT(multichannel_signal, fs, window, overlap, nfft, MicrophoneCount);
p_theta_time = Beamform(S_multi, d, 343, fs, MicrophoneCount, thetaRange);
doa_estimates = DOAEstimator(p_theta_time, thetaRange);

% Display the Results.
VisualizePseudospectrum(p_theta_time, thetaRange, t, 1);
VisualizeDOAestimates(doa_estimates, thetaRange, t, 2);

