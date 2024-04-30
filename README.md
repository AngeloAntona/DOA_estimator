# CMLS_HW1
## Overview
This README provides a comprehensive guide for implementing a Direction of Arrival (DOA) estimator in MATLAB. The implementation follows a structured approach outlined below.

## Approach
The implementation follows a modular design, employing classes to encapsulate different functionalities required for DOA estimation:

* ULAConfig: This class stores configuration details of the Uniform Linear Array (ULA), including parameters such as microphone count, array length, sound speed, and sampling frequency.
* AudioData: Responsible for handling multi-channel audio data, this class provides methods for loading data and performing preprocessing tasks such as normalization.
* STFTProcessor: Short-Time Fourier Transform (STFT) is essential for frequency-domain processing. This class implements STFT functionality, including methods for performing the transform, inverse transform, and computing spectrograms.
* Beamformer: The core of the system, this class implements the delay-and-sum beamforming algorithm. It takes configuration from ULAConfig and processed data from STFTProcessor to apply the beamforming algorithm.
* DOAEstimator: Using the output from the Beamformer class, this class estimates the Direction of Arrival (DOA). It implements methods for DOA estimation, averaging pseudospectrum across frequencies, and visualizing results.
* Visualizer: This class generates static plots and dynamic visualizations of DOA estimates. It includes methods for plotting pseudospectrum, sensor arrays, and creating videos showing DOA changes over time.

## Order of Implementation
To ensure proper functionality and testing, the classes are developed in a sequential manner:

* ULAConfig: Define and test this class to store essential configuration details for the ULA.
* AudioData: Implement methods for loading and preprocessing audio data, ensuring correct data preparation.
* STFTProcessor: Develop STFT functionality and verify transformation accuracy using synthetic data.
* Beamformer: Implement the delay-and-sum beamforming algorithm and independently test its functionality.
* DOAEstimator: Develop methods for DOA estimation, relying on beamformer output, and ensure accurate estimation.
* Visualizer: Implement visualization methods using data from previous classes to generate required plots and videos.

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
| ULAConfig                             | :green_circle:   |
| AudioData                             | :green_circle:   |
| customFFT                             | :green_circle:   |
| STFTProcessor                         | :green_circle:   |
| Beamformer                            | :red_circle:     |
| DOAEstimator                          | :red_circle:     |
| Visualizer                            | :red_circle:     |

## Legend

- :green_circle: Complete
- :yellow_circle: In Progress
- :red_circle: Not Implemented
