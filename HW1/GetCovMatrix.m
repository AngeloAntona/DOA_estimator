function R = GetCovMatrix(S)
    % S è un array 3D dove S(:,:,m) è la matrice STFT del m-esimo microfono
    % numFreqs è il numero di frequenze (righe di S)
    % numFrames è il numero di frame temporali (colonne di S)
    % numMics è il numero di microfoni (profondità di S, la terza dimensione)

    [numFreqs, numFrames, numMics] = size(S);
    R = zeros(numMics, numMics, numFreqs);

    for f = 1:numFreqs
        for m1 = 1:numMics
            for m2 = 1:numMics
                % Estrai l'STFT alla frequenza f per i microfoni m1 e m2
                S_m1 = squeeze(S(f, :, m1));  % STFT alla frequenza f per il microfono m1
                S_m2 = squeeze(S(f, :, m2));  % STFT alla frequenza f per il microfono m2

                % Calcola la media del prodotto elemento per elemento dei due segnali
                % ed inseriscilo nell'elemento (m1, m2) della matrice di covarianza
                R(m1, m2, f) = mean(S_m1 .* conj(S_m2));
            end
        end
    end
end