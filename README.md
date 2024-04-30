# CMLS_HW1
## Overview
This README provides a comprehensive guide for implementing a Direction of Arrival (DOA) estimator in MATLAB. The implementation follows a structured approach outlined below.

## Functions and Classes

1. **`customFFT(x)`**:
   - Input: Signal `x`
   - Output: FFT of the input signal
   - Description: Computes the Fast Fourier Transform (FFT) of a given signal using a recursive algorithm.

2. **`AllChannelSTFT(signal, fs, window, overlap, nfft, MicrophoneCount)`**:
   - Inputs:
     - `signal`: Multichannel audio signal (each column represents a microphone).
     - `fs`: Sampling frequency of the signal.
     - `window`: Window function applied to each frame of the STFT.
     - `overlap`: Proportion of overlap between consecutive frames.
     - `nfft`: Number of FFT points.
     - `MicrophoneCount`: Number of microphones/channels in the signal.
   - Outputs:
     - `S_multi`: 3D array containing STFTs for each channel (frequency x time x channel).
     - `f`: Frequency axis for the STFT.
     - `t`: Time axis for the STFT.
   - Description: Calculates the STFT for each channel of a multichannel signal.

3. **`GetCovMatrix(S)`**:
   - Input: 3D array `S` representing STFTs for each microphone.
   - Output: Covariance matrix.
   - Description: Computes the covariance matrix for multichannel signals.

4. **`GetSteeringVector(theta, d, c, numMics, freq)`**:
   - Inputs:
     - `theta`: Direction of arrival angle in degrees.
     - `d`: Microphone spacing in meters.
     - `c`: Speed of sound in m/s.
     - `numMics`: Number of microphones.
     - `freq`: Frequency in Hz.
   - Output: Steering vector.
   - Description: Calculates the steering vector for a given angle and frequency.

5. **`Beamform(S, d, c, Fs, numMics, theta_range)`**:
   - Inputs:
     - `S`: 4D matrix representing STFTs for each microphone at different time frames.
     - `d`: Microphone spacing in meters.
     - `c`: Speed of sound in m/s.
     - `Fs`: Sampling frequency.
     - `numMics`: Number of microphones.
     - `theta_range`: Range of DOA angles.
   - Output: Pseudospectrum over time for each DOA angle.
   - Description: Performs beamforming to estimate the DOA using the provided STFT data.

6. **`VisualizePseudospectrum(p_theta_time, theta_range, time_steps)`**:
   - Inputs:
     - `p_theta_time`: Pseudospectrum over time.
     - `theta_range`: Range of DOA angles.
     - `time_steps`: Time steps.
   - Description: Visualizes the time-varying pseudospectrum for DOA estimation.

7. **`AudioData` Class**:
   - Properties:
     - `Data`: Audio data.
     - `SampleRate`: Sampling rate of the audio data.
   - Methods:
     - `normalize()`: Normalizes the audio data.

8. **`ULAConfig` Class**:
   - Properties:
     - `MicrophoneCount`: Number of microphones.
     - `ArrayLength`: Length of the microphone array in meters.
     - `SoundSpeed`: Speed of sound in m/s.
     - `SamplingFrequency`: Sampling frequency in Hz.
   - Description: Defines the configuration of the uniform linear array (ULA) of microphones.

## Workflow
1. Load the multichannel audio data from a file using the `AudioData` class.
2. Normalize the audio data.
3. Perform STFT on the multichannel signal using `AllChannelSTFT`.
4. Compute the covariance matrix using `GetCovMatrix`.
5. Calculate the steering vectors for each angle and frequency.
6. Perform beamforming using `Beamform`.
7. Visualize the pseudospectrum over time using `VisualizePseudospectrum`.

## Homework Assignment Details
The implementation is guided by a homework assignment on acoustic source localization, which involves:

* Designing a delay-and-sum beamformer for a ULA to localize a time-varying sound source.
* Providing one figure showing the averaged pseudospectrum at different time instants.
* Depicting a ULA setup displaying each sensor and estimated DOAs as arrows pointing in the direction of the source position.
* Creating a video showing the arrows appearing for each time frame.

## Theoretical Background
Uniform Linear Arrays (ULA) are commonly used for microphone positioning. They consist of microphones positioned in a linear array with a constant distance between adjacent microphones. The DOA can be derived as a function of the angle θ, where τk represents the time delay for the k-th microphone.

Spatial filtering techniques, such as the delay-and-sum beamformer, aim to enhance signals from a specific direction while attenuating signals from other directions. This technique involves linearly combining microphone signals with specific weights to achieve the desired spatial filtering.

## Development Status

| Class Name                            | Status       |
|---------------------------------------|--------------------------|
| customFFT                             | :green_circle:   |
| STFTProcessor                         | :green_circle:   |
| AllChannelsSTFT                       | :green_circle:   | 
| GetSteeringVector                     | :yellow_circle:  |
| GetCovMatrix                          | :yellow_circle:  |
| Beamform                              | :yellow_circle:  |
| VisualizePseudospectrum               | :yellow_circle:  |
| DOAEstimator                          | :yellow_circle:  |
| PlotDOA                               | :red_circle:     |
| ULAConfig                             | :green_circle:   |
| AudioData                             | :green_circle:   |

## Legend

- :green_circle: Complete
- :yellow_circle: In Progress
- :red_circle: Not Implemented
