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

% Genera un segnale di test
fs = 2000; % Frequenza di campionamento
t = 0:1/fs:1; % Tempo
x = sin(2*pi*100*t) + sin(2*pi*200*t) + randn(size(t)); % Segnale di test

% Parametri della STFT
window = hamming(256)'; % Finestra di Hamming
overlap = 0.5; % Sovrapposizione del 50%
nfft = 512; % Numero di punti della FFT

% Calcola la STFT con la nostra implementazione
[S_custom, f_custom, t_custom] = STFTProcessor(x, fs, window, overlap, nfft);

% Calcola la STFT con la funzione stft standard di MATLAB
[S_matlab, f_matlab, t_matlab] = spectrogram(x, window, overlap*length(window), nfft, fs);

S_custom_cropped = S_custom(1:length(S_matlab),:);

% Plot spectrogram from MATLAB's spectrogram function
subplot(1,2,1);
imagesc(t_matlab, f_matlab, abs(S_matlab));
colorbar;
title('MATLAB Spectrogram');
xlabel('Time (s)');
ylabel('Frequency (Hz)');

% Plot spectrogram from custom implementation
subplot(1,2,2);
imagesc(t_custom, f_custom, abs(S_custom_cropped));
colorbar;
title('Custom Spectrogram');
xlabel('Time (s)');
ylabel('Frequency (Hz)');


% Confronta i risultati
max_diff = max(abs(S_custom_cropped - S_matlab));
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

% Assuming ULAConfig and AudioData have been initialized appropriately
ula = ULAConfig(8, 300, 340, 44100); % Example configuration
audio = AudioData('AudioFiles/array_recordings.wav'); % Load audio data

% Call beamformer
[output_signal, output_time] = Beamformer(audio, ula, 30, 44100); % Example: 30 degrees angle of arrival

% Plot output
plot(output_time, abs(output_signal));
xlabel('Time (s)');
ylabel('Amplitude');
title('Beamformed Signal Output');

%% --------------------------------------------------
 
% Beamformer test 2

clc;
clearvars;
close all;

testBeamformer;

%% --------------------------------------------------
% DOAEstimator test

clc;
clearvars;
close all;

testDOAEstimator;


