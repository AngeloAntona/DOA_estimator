function VisualizeDOAestimatesMulti(doa_estimates, thetaRange, t, figNumber)
    % Inputs:
    %    doa_estimates - Vector of DOA estimates over time.
    %    thetaRange - Vector of possible DOA angles (for setting y-axis limits).
    %    t - Vector of time instances corresponding to the entries in doa_estimates.
    % Create a new figure or clear the existing one
    figure(figNumber);
    clf; % Clear the figure to ensure clean plotting area

    %------------------------------------------------------------------------
    subplot(1,3,1);

    % Plot DOA estimates over time
    plot(t, doa_estimates(1,:), 'LineWidth', 2);

    % Set the plot title and axes labels
    title('Estimated DOAs over Time (Aritmetic Mean)');
    xlabel('Time (seconds)');
    ylabel('DOA (degrees)');

    % Set axis limits to encompass all data and possible angle values
    xlim([min(t), max(t)]);
    ylim([min(thetaRange), max(thetaRange)]);

    % Enable grid for better readability
    grid on;

    %------------------------------------------------------------------------
    subplot(1,3,2);
    % Plot DOA estimates over time
    plot(t, doa_estimates(2,:), 'LineWidth', 2);

    % Set the plot title and axes labels
    title('Estimated DOAs over Time (Armonic Mean)');
    xlabel('Time (seconds)');
    ylabel('DOA (degrees)');

    % Set axis limits to encompass all data and possible angle values
    xlim([min(t), max(t)]);
    ylim([min(thetaRange), max(thetaRange)]);

    % Enable grid for better readability
    grid on;

    %------------------------------------------------------------------------
    subplot(1,3,3);

    % Plot DOA estimates over time
    plot(t, doa_estimates(3,:), 'LineWidth', 2);

    % Set the plot title and axes labels
    title('Estimated DOAs over Time (Geometric Mean)');
    xlabel('Time (seconds)');
    ylabel('DOA (degrees)');

    % Set axis limits to encompass all data and possible angle values
    xlim([min(t), max(t)]);
    ylim([min(thetaRange), max(thetaRange)]);

    % Enable grid for better readability
    grid on;
end
