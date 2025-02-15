# SASP_HW1

## Overview
This project aims to implement Direction of Arrival (DOA) estimation using audio signal processing techniques. The source localization involves a multichannel recording acquired using a uniform linear microphone array (ULA) composed of 16 MEMS microphones spaced along a 45 cm length. This array captures audio data via an Audio-over-IP connection at a sampling rate of 8 kHz. The acoustic scene features a moving sound source in front of the ULA, and the speed of sound is established at 343 m/s.
Our objective is to implement a delay-and-sum beamformer tailored for localizing wide-band sources. Given the narrow-band nature of spatial filtering, the project handles each frequency band independently and performs spatial filtering frame by frame to accommodate the source's time-varying nature. 

##	Developement and testins approach
The development strategy follows a bottom-up approach, starting with fundamental components and progressively integrating and testing higher-level functions. Each component is validated through dedicated test cases (included in the MainTest.m script) that verify its performance individually before proceeding to system-level integration.
The flow of usage for the classes/functions is illustrated in the figure below.
![Alt text](/ReadmeFiles/MainDiagram.png)

In the next section, each of these classes will be analyzed individually.

## Component Descriptions and Tests
### 2.1 AudioData Class
- **Functionality**: Handles audio data loading, storage, and normalization.
- **Properties**: 
  - `Data`: Stores audio samples loaded from a file.
  - `SampleRate`: Stores the sample rate of the audio data.
- **Methods**:
  - `AudioData(filepath)`: Constructor, loads audio data from a specified file.
  - `normalize()`: Normalizes the audio data.
- **Test**: MainTest verifies correct loading and normalization.

### 2.2 CustomFFT Function
- **Functionality**: Implements recursive Fast Fourier Transform (FFT) tailored for input lengths that are powers of two.
- **Input/Output**: `x` (time-domain signal) ➔ `X` (frequency-domain spectrum).
- **Implementation Details**: Utilizes Cooley-Tukey algorithm.
- **Test**: Compares output against MATLAB's fft function.
![Alt text](/ReadmeFiles/Test_FFT.png)

### 2.3 STFTProcessor Function
- **Functionality**: Calculates Short-Time Fourier Transform (STFT) for a single-channel signal.
- **Inputs/Outputs**: `x` (input signal), `fs` (sampling frequency), `window`, `overlap`, `nfft` ➔ `S` (STFT matrix), `f` (frequency axis), `t` (time axis).
- **Implementation Details**: Handles windowing, overlapping, and FFT computation.
- **Test**: Validates correctness against MATLAB's spectrogram function.
![Alt text](/ReadmeFiles/Test_STFT.png)

### 2.4 AllChannelSTFT Function
- **Functionality**: Extends STFTProcessor to handle multichannel audio data.
- **Inputs/Outputs**: `signal`, `fs`, `window`, `overlap`, `nfft`, `MicrophoneCount` ➔ `S_multi` (STFT results), `f`, `t`.
- **Implementation Details**: Processes each channel independently.
- **Test**: Ensures accurate processing of each microphone channel.
![Alt text](/ReadmeFiles/Test_AllChannelSTFT.png)

### 2.5 GetCovMatrix Function
- **Functionality**: Computes spatial covariance matrix of signals captured by microphone arrays.
- **Input/Output**: `S_time` (STFT results) ➔ `R` (covariance matrix).
- **Implementation Details**: Processes each frequency band individually.
- **Test**: Validates Hermitian property of matrices.

### 2.6 GetSteeringVector Function
- **Functionality**: Generates steering vector for microphone array beamforming.
- **Inputs/Output**: `theta`, `d`, `c`, `numMics`, `freq` ➔ `a` (steering vector).
- **Implementation Details**: Calculates wavenumber and phase shift for each microphone.
  
### 2.7 Beamform Function
- **Functionality**: Implements beamforming to enhance signal from a specific direction.
- **Inputs/Output**: `S`, `d`, `c`, `Fs`, `numMics`, `theta_range` ➔ `p_theta_time` (beamforming power).
- **Implementation Details**: Computes spatial covariance matrix and beamforming power.
- **Test**: Implicitly validated through DOAEstimator tests.

### 2.8 DOAEstimator Function
- **Functionality**: Determines DOA of sound based on beamforming output.
- **Inputs/Output**: `p_theta_time`, `theta_range` ➔ `doa_estimates`.
- **Implementation Details**: Analyzes power distribution across angles.
- **Test**: Integrates tests for related functions.
![Alt text](/ReadmeFiles/Test_DOAEstimator.png)


### 2.9 Visualization Functions
- **Functions**: `visualizePseudospectrum` and `visualizeDOAEstimates`.
- **Purpose**: Graphically represent pseudospectrum and DOA estimates.

### 2.10 Video Generation Functions
- **Functions**: `getSingleFrame`, `framesGenerator`, `videoGenerator`.
- **Purpose**: Generate visual frames and compile into a video.

## 3. Main Script Functionality
- Orchestrates components for DOA estimation.
- Loads audio data, performs STFT, beamforming, DOA estimation, and visualization.

## 4. Results Analysis
- **Pseudospectrum Analysis**: Visualizes power distribution across angles over time.
![Alt text](/ReadmeFiles/Pseudospectrum.png)
- **DOA Estimates Analysis**: Tracks movement of sound source and estimates DOA.
![Alt text](/ReadmeFiles/DOAs_over_time.png)
![Alt text](/ReadmeFiles/ArrowSequence.jpg)

- **Conclusion**: In conclusion, the analysis results affirm the effectiveness of the designed acoustic source localization system.

## 5. Conclusion
This system provides a comprehensive framework for estimating the direction of arrival of sound sources, with thorough analysis capabilities and visualization tools.



## Development Status

| Class/Function Name       | Status          |
|---------------------------|-----------------|
| Main                      | :green_circle:  |
| Audiodata                 | :green_circle:  |
| AllChannelSTFT            | :green_circle:  |
| STFTProcessor             | :green_circle:  |
| customFFT                 | :green_circle:  |
| Beamform                  | :green_circle:  |
| GetCovMatrix              | :green_circle:  |
| GetSteeringVector         | :green_circle:  |
| VisualizePseudospectrum   | :green_circle:  |
| VisualizeDOAEstimates     | :green_circle:  |
| GetSingleFrame            | :green_circle:  |
| FramesGenerator           | :green_circle:  |
| VideoGenerator            | :green_circle:  |
| DOAEstimator              | :green_circle:  |


## Legend

- :green_circle: Complete.
- :yellow_circle: In Progress.
- :red_circle: Not Implemented.
