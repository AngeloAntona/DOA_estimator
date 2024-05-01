function PlotDOA(doa_estimates, d, MicrophoneCount)
    % Definisci le posizioni dei microfoni nell'array ULA
    x = (0:MicrophoneCount-1) * d;
    y = zeros(1, MicrophoneCount);

    % Prepara la figura per la visualizzazione
    fig = figure;
    axis equal;
    hold on;
    grid on;
    xlabel('Posizione x (metri)');
    ylabel('Posizione y (metri)');
    title('Visualizzazione ULA e DOA');

    % Disegna i microfoni come punti
    plot(x, y, 'ko', 'MarkerFaceColor', 'k');
    xlim([min(x) max(x)]);
    ylim([-1 1]);  % Imposta i limiti per y per evitare il ridimensionamento automatico

    % Prepara un oggetto video writer per salvare l'animazione
    v = VideoWriter('doa_estimation.avi');
    open(v);

    % Calcola il numero di frame temporali
    numFrames = size(doa_estimates, 2);

    % Loop attraverso ciascun frame temporale
    for frame = 1:numFrames
        % Ottieni le stime DOA per questo frame
        angles = doa_estimates(:, frame);

        % Calcola componenti x e y per le frecce basate sugli angoli DOA
        u = cosd(angles);
        v = sind(angles);

        % Pulisci le frecce precedenti e ridisegna i microfoni
        cla;
        plot(x, y, 'ko', 'MarkerFaceColor', 'k');

        % Disegna le frecce per ogni stima DOA
        quiver(x(end/2)*ones(size(angles)), y(end/2)*ones(size(angles)), u, v, 'r');

        % Aggiorna il grafico
        drawnow;

        % Cattura il frame corrente
        frameImage = getframe(fig);
        writeVideo(v, frameImage.cdata);  % Scrivi il frame nel video
    end

    % Chiudi il video writer
    close(v);
    hold off;
end
