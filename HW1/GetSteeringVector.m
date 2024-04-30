function a = GetSteeringVector(theta, d, c, numMics, freq)
    % This function returns the steering vector for a given angle theta and frequency freq
    % Inputs:
    %   theta - DOA angle in degrees
    %   d - microphone spacing in meters
    %   c - speed of sound in m/s
    %   numMics - number of microphones in the array
    %   freq - frequency in Hz for which to calculate the steering vector
    
    k = 2 * pi * freq / c;  % Wavenumber for the given frequency
    a = exp(-1i * k * d * sin(deg2rad(theta)) * (0:(numMics-1))).';  % Steering vector, column vector
end
