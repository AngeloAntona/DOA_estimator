function X = customFFT(x)
    N = length(x);
    if N <= 1
        X = x;
        return;
    end
    
    % Check if N is a power of 2
    if mod(N, 2) > 0
        error('Input length must be a power of 2.');
    end
    
    % Recursive FFT computation
    X_even = customFFT(x(1:2:end));
    X_odd  = customFFT(x(2:2:end));
    factor = exp(-2i * pi * (0:N/2-1) / N);
    
    X = [X_even + factor .* X_odd, X_even - factor .* X_odd];
end
