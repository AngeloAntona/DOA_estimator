function VisualizeDOAestimates(doa_estimates, thetaRange, t, figNumber)
    % Inputs:
    %    doa_estimates - Vector of DOA estimates over time.
    %    thetaRange - Vector of possible DOA angles (for setting y-axis limits).
    %    t - Vector of time instances corresponding to the entries in doa_estimates.

    % Create a new figure or clear the existing one
    figure(figNumber);
    clf;

    % Plot DOA estimates over time
    plot(t, doa_estimates, 'LineWidth', 2);

    % Set the plot title and axes labels
    title('Estimated DOAs over Time');
    xlabel('Time (seconds)');
    ylabel('DOA (degrees)');

    % Set axis limits to encompass all data and possible angle values
    xlim([min(t), max(t)]);
    ylim([min(thetaRange), max(thetaRange)]);

    % Enable grid for better readability
    grid on;
end
