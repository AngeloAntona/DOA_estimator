function [S, f, t] = STFTProcessor(x, fs, window, overlap, nfft)
    % Calcola la STFT utilizzando la funzione fft.
    % Parametri:
    % - x: segnale di input
    % - fs: frequenza di campionamento
    % - window: finestra temporale
    % - overlap: sovrapposizione tra finestre
    % - nfft: numero di punti della FFT
    
    % Calcola la lunghezza della finestra
    window_length = length(window);
    
    % Calcola il numero di campioni sovrapposti
    overlap_length = round(overlap * window_length);
    
    % Calcola il numero di punti della FFT
    if isempty(nfft)
        nfft = max(256, 2^nextpow2(window_length));
    end
    
    % Calcola il numero di frame
    num_frames = 1 + floor((length(x) - window_length) / overlap_length);
    
    % Inizializza la matrice STFT
    S = zeros(nfft, num_frames);
    
    % Applica la STFT a ogni frame
    for i = 1:num_frames
        % Indici dei campioni corrispondenti al frame corrente
        idx = (i - 1) * overlap_length + (1:window_length);
        
        % Applica la finestra al frame corrente
        frame = x(idx) .* window;
        
        % Zero-pad il frame alla successiva potenza di due (la customFFT
        % può gestire solo segnali che hanno una lunghezza di 2^n)
        padded_frame = [frame, zeros(1, nfft - window_length)];
        
        % Compute the custom FFT of the padded frame and store it in the STFT matrix
        S(:, i) = customFFT(padded_frame);
    end
    
    % Calcola l'asse delle frequenze
    f = linspace(0, fs, nfft);
    
    % Calcola l'asse temporale
    t = (window_length/2 + overlap_length * (0:num_frames-1)) / fs;
end
