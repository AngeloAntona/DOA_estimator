# CMLS_HW1

## Overview
This project implements Direction of Arrival (DOA) estimation for audio signals using a microphone array. The system processes audio data to estimate the direction from which the sound originates, visualizes the results, and compiles them into a video presentation.

## Class and Function Descriptions
![Alt text](/ReadmeFiles/MainDiagram.png)

### Main
Orchestrates the entire process of DOA estimation including audio data handling, signal processing, beamforming, visualization, and video generation.

### AudioData
- **Purpose**: Manages loading and normalizing audio data.
- **Inputs**:
  - `filepath`: Path to the audio file.
- **Outputs**:
  - `Data`: Normalized audio data.
  - `SampleRate`: Sampling rate of the audio data.
- **Methods**:
  - `normalize()`: Normalizes the audio data to ensure consistent amplitude levels across the dataset.

### AllChannelSTFT
- **Purpose**: Calculates the Short-Time Fourier Transform (STFT) for each channel in a multichannel audio signal.
- **Inputs**:
  - `signal`: Multichannel audio signal.
  - `fs`: Sampling frequency.
  - `window`: Window function for STFT.
  - `overlap`: Overlap between consecutive frames.
  - `nfft`: Number of FFT points.
  - `MicrophoneCount`: Number of channels/microphones.
- **Outputs**:
  - `S_multi`: 3D array containing STFT results for each channel.
  - `f`: Frequency axis for STFT.
  - `t`: Time axis for STFT.

### STFTProcessor
- **Purpose**: Processes the Short-Time Fourier Transform of audio signals.
- **Inputs**:
  - Same as AllChannelSTFT.
- **Outputs**:
  - `S`: STFT matrix for a single channel.
  - Detailed frequency and time vectors.

### customFFT
- **Purpose**: Computes the Fast Fourier Transform using a custom implementation.
- **Inputs**:
  - `x`: Signal array.
- **Outputs**:
  - `X`: FFT result as an array.

### Beamform
- **Purpose**: Performs beamforming to estimate power at different DOA angles using the STFT results.
- **Inputs**:
  - `S`: STFT results.
  - `d`: Microphone spacing.
  - `c`: Speed of sound.
  - `Fs`: Sampling frequency.
  - `numMics`: Number of microphones.
  - `theta_range`: Range of DOA angles.
- **Outputs**:
  - `p_theta_time`: Power values for each DOA angle over time.

### GetCovMatrix
- **Purpose**: Computes the covariance matrix from STFT results.
- **Inputs**:
  - `S_time`: STFT results for a specific time frame.
- **Outputs**:
  - `R`: Covariance matrix for the given time frame.

### GetSteeringVector
- **Purpose**: Generates steering vectors for beamforming calculations.
- **Inputs**:
  - `theta`, `d`, `c`, `numMics`, `freq`: DOA angle, microphone spacing, speed of sound, number of microphones, frequency.
- **Outputs**:
  - `a`: Steering vector for the given parameters.

### DOAEstimator
- **Purpose**: Estimates the Direction of Arrival based on the beamformed output for each time frame.
- **Inputs**:
  - `p_theta_time`: Matrix of power values for each angle and time frame.
  - `theta_range`: Range of DOA angles.
- **Outputs**:
  - `doa_estimates`: Array containing the estimated DOA for each time frame.

### VisualizePseudospectrum
- **Purpose**: Visualizes the pseudospectrum of the DOA estimation.
- **Inputs**:
  - `p_theta_time`: Power values for each angle and time frame.
  - `theta_range`: DOA angles.
  - `time_steps`: Time intervals of the data.
- **Outputs**:
  - Generates a plot of the pseudospectrum over time.

### FramesGenerator
- **Purpose**: Generates visual frames representing DOA estimates.
- **Inputs**:
  - `doa_estimates`: Estimated DOA for each time frame.
  - `d`: Microphone spacing.
  - `MicrophoneCount`: Number of microphones.
  - `outputPath`: Directory for storing frames.
- **Outputs**:
  - Saves frames as images in the specified directory.

### GetSingleFrame
- **Purpose**: Generates a single frame showing the DOA estimate using an arrow representation.
- **Inputs**:
  - Same as FramesGenerator plus `frameNo`: the current frame number.
- **Outputs**:
  - Saves the generated frame as an image file.

### VideoGenerator
- **Purpose**: Creates a video from generated image frames.
- **Inputs**:
  - `doa_estimates`: Array of DOA estimates.
  - `outputPath`: Path where images are stored.
  - `videoFilename`: Output filename for the video.
  - `frameRate`: Frame rate for the video.
- **Outputs**:
  - Compiles and saves the final video file.


## Homework Assignment Details
The implementation is guided by a homework assignment on acoustic source localization, which involves:

* Designing a delay-and-sum beamformer for a ULA to localize a time-varying sound source.
* Providing one figure showing the averaged pseudospectrum at different time instants.
* Depicting a ULA setup displaying each sensor and estimated DOAs as arrows pointing in the direction of the source position.
* Creating a video showing the arrows appearing for each time frame.

## Development Status

| Class/Function Name       | Status          |
|---------------------------|-----------------|
| main                      | :green_circle:  |
| audiodata                 | :green_circle:  |
| AllChannelSTFT            | :green_circle:  |
| STFTProcessor             | :green_circle:  |
| customFFT                 | :green_circle:  |
| Beamform                  | :green_circle:  |
| GetCovMatrix              | :green_circle:  |
| GetSteeringVector         | :green_circle:  |
| VisualizePseudospectrum   | :green_circle:  |
| GetSingleFrame            | :green_circle:  |
| FramesGenerator           | :green_circle:  |
| VideoGenerator            | :green_circle:  |
| DOAEstimator              | :green_circle:  |


## Legend

- :green_circle: Complete
- :yellow_circle: In Progress
- :red_circle: Not Implemented
