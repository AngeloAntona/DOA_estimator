clc;
clearvars;
close all;

%% Inizialization.
filepath = 'AudioFiles/array_recordings.wav'; % Path of the input audioFile
outputPath = './VideoFrames/'; % Video Frames audio Path

audio_data = AudioData(filepath);
audio_data.normalize;
multichannel_signal = audio_data.Data;

fs = audio_data.SampleRate;
window = hann(1024); 
overlap = 0.8; 
nfft = 1024; 
MicrophoneCount = 16;
thetaRange = linspace(-90,90,180);
d=0.45/15;

%% DOA Estimation.
[S_multi, f, t] = AllChannelSTFT(multichannel_signal, fs, window, overlap, nfft, MicrophoneCount);
p_theta_time = Beamform(S_multi, d, 343, fs, MicrophoneCount, thetaRange);
doa_estimates = DOAEstimator(p_theta_time, thetaRange);

%% Result Visualization.
VisualizePseudospectrum(p_theta_time, thetaRange, t, 1);
VisualizeDOAestimates(doa_estimates, thetaRange, t, 2);

%% Video Generation.
FramesGenerator(doa_estimates, d, MicrophoneCount, outputPath, 3);

videoFilename = 'doa_video.mp4'; % Name of the video file to be created
frameRate = 10; % Desired frame rate for the video
VideoGenerator(doa_estimates, outputPath, videoFilename, frameRate);
