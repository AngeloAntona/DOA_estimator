%% --------------------------------------------------
% ULAConfig Test
clc;
clearvars;
close all;

% Test values from the assignment
microphone_count = 16;
array_length_cm = 45;
sound_speed = 343;
sampling_frequency = 8000;

% Create an instance of the ULAConfig class
ula_config = ULAConfig(microphone_count, array_length_cm, sound_speed, sampling_frequency);

% Display the properties to ensure they are set correctly
disp(ula_config);


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
disp('First 100 samples from the first channel:');
disp(audio_data.Data(1:100, 1));

% Normalize the audio data
audio_data = audio_data.normalize();

% Display some information about the data after normalization
disp('Audio data info after normalization:');
disp(['Max value: ', num2str(max(abs(audio_data.Data), [], 'all'))]);
disp('First 100 samples from the first channel after normalization:');
disp(audio_data.Data(1:100, 1));

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

% % Genera un segnale di test
% fs = 2000; % Frequenza di campionamento
% t = 0:1/fs:1; % Tempo
% x = sin(2*pi*100*t) + sin(2*pi*200*t) + randn(size(t)); % Segnale di test

filepath = 'AudioFiles/array_recordings.wav';
% Create an instance of the AudioData class
audio_data = AudioData(filepath);
x = audio_data.Data(:,1);
fs = audio_data.SampleRate;

% Parametri della STFT
window = hamming(256); % Finestra di Hamming
overlap = 0.5; % Sovrapposizione del 50%
nfft = 512; % Numero di punti della FFT

% Calcola la STFT con la nostra implementazione
[S_custom, f_custom, t_custom] = STFTProcessor(x, fs, window, overlap, nfft);

% Calcola la STFT con la funzione stft standard di MATLAB
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
    disp('I risultati coincidono.');
else
    disp('I risultati non coincidono.');
end

%% --------------------------------------------------

% Beamformer test 1

clc;
clearvars;
close all;

% Define ULA Configuration
microphone_count = 16;
array_length_cm = 45; % Total length of the array in cm
sound_speed = 343; % Speed of sound in m/s
sampling_frequency = 8000; % Sampling frequency in Hz

% Create an instance of ULAConfig
ulaConfig = ULAConfig(microphone_count, array_length_cm, sound_speed, sampling_frequency);

% Load Audio Data
filepath = 'AudioFiles/array_recordings.wav'; % Specify the path to your multichannel audio file
audioData = AudioData(filepath);

% Normalize audio data (optional, if required)
audioData = audioData.normalize();

% Specify the direction of arrival of the sound in degrees
direction = 30; % Example: 30 degrees

% Call the Beamformer function
beamformed_output = Beamformer(audioData, ulaConfig, direction);

% Plot the results
figure;
subplot(2, 1, 1);
plot(audioData.Data);
title('Original Audio Signals');
xlabel('Sample Number');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(beamformed_output);
title(['Beamformed Output for Direction ', num2str(direction), ' degrees']);
xlabel('Sample Number');
ylabel('Amplitude');

% Display the plot
sgtitle('Comparison of Original and Beamformed Audio Signals');

%% --------------------------------------------------

% Beamformer test2

clc;
clearvars;
close all;

% Define ULA Configuration
microphone_count = 16;
array_length_cm = 45; % Total length of the array in cm
sound_speed = 343; % Speed of sound in m/s
sampling_frequency = 8000; % Sampling frequency in Hz

ulaConfig = ULAConfig(microphone_count, array_length_cm, sound_speed, sampling_frequency);

% Example Test with Synthetic Data
fs = 8000; % Sampling frequency
t = 0:1/fs:1-1/fs; % Time vector
f = 1000; % Frequency of the tone
theta_test = 30; % Direction for test signal in degrees

% Simulate a plane wave arriving at theta_test
test_signal = sin(2 * pi * f * (t - (ulaConfig.ArrayLength * sin(deg2rad(theta_test)) / ulaConfig.SoundSpeed)));

% Use this test signal in place of actual microphone data to check beamforming
test_audioData = AudioData('');
test_audioData.Data = repmat(test_signal, 16, 1)'; % Simulate multi-channel data
test_audioData.SampleRate = fs;

% Beamform using the test signal
test_output = Beamformer(test_audioData, ulaConfig, theta_test);

% Plot the results
figure;
subplot(2, 1, 1);
plot(test_audioData.Data);
title('Original Audio Signals');
xlabel('Sample Number');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(test_output);
title(['Beamformed Output for Direction ', num2str(direction), ' degrees']);
xlabel('Sample Number');
ylabel('Amplitude');

% Display the plot
sgtitle('Comparison of Original and Beamformed Audio Signals');


%% --------------------------------------------------
% DOAEstimator test

clc;
clearvars;
close all;

% Define the ULA Configuration
microphone_count = 16;                % Number of microphones in the ULA
array_length_cm = 45;                 % Total length of the array in cm
sound_speed = 343;                    % Speed of sound in m/s
sampling_frequency = 8000;            % Sampling frequency in Hz

% Create an instance of ULAConfig
ulaConfig = ULAConfig(microphone_count, array_length_cm, sound_speed, sampling_frequency);

% Parameters for the STFT and DOA estimation
frameLength = 1024;                   % Length of each frame for STFT
frameOverlap = 512;                   % Overlap between frames
directionRange = [-90, 90];           % Range of directions to search for DOA
stepSize = 1;                         % Step size in degrees for the DOA estimation

% Path to the audio file
audioFilePath = 'AudioFiles/array_recordings.wav';

% Function to track and estimate the DOA of a moving source
trackMovingSource(audioFilePath, ulaConfig, frameLength, frameOverlap, directionRange, stepSize);

% Note: Ensure that all functions like trackMovingSource, STFTProcessor,
% DOAEstimator, and necessary classes are properly defined and implemented
% as discussed in previous messages.

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


% Numero di frequenze, frame e microfoni
numFreqs = 10;
numFrames = 100;
numMics = 3;

% Genera dati STFT sintetici per i microfoni
% Assumiamo che ogni elemento sia complesso
S = rand(numFreqs, numFrames, numMics) + 1i * rand(numFreqs, numFrames, numMics);

% Chiama la funzione GetCovMatrix
R = GetCovMatrix(S);

% Stampa le matrici di covarianza per ogni frequenza
for f = 1:numFreqs
    fprintf('Matrice di covarianza per la frequenza %d:\n', f);
    disp(R(:,:,f));
end

% Verifica la correttezza del calcolo verificando proprietà come l'hermitianità
for f = 1:numFreqs
    if ishermitian(R(:,:,f))
        fprintf('La matrice di covarianza alla frequenza %d è hermitiana.\n', f);
    else
        fprintf('Errore: la matrice di covarianza alla frequenza %d non è hermitiana.\n', f);
    end
end

%% --------------------------------------------------
% GetCovMatrix test

clc;
clearvars;
close all;

filepath = 'AudioFiles/array_recordings.wav';
% Create an instance of the AudioData class
audio_data = AudioData(filepath);
audio_data.normalize;
multichannel_signal = audio_data.Data;
fs = audio_data.SampleRate;

window = hann(256); % example window function
overlap = 0.5; % 50% overlap
nfft = 512; % number of FFT points
MicrophoneCount = 16; % number of microphones

thetaRange = linspace(-90,90,180);
d=0.45/15;

[S_multi, f, t] = AllChannelSTFT(multichannel_signal, fs, window, overlap, nfft, MicrophoneCount);
disp("Fine STFT, inizio BeamForm");
p_theta_time = Beamform(S_multi, d, 343, fs, MicrophoneCount, thetaRange);
disp("Fine Beanform, inizio VisualizePseudospectrum");
VisualizePseudospectrum(p_theta_time, thetaRange, t);
