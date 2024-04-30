function PlotDOA(overallDOA, d, numMics)
    % Define microphone positions for a linear array
    microphonePositions = (0:numMics-1) * d;

    % Create a new figure for plotting
    figure;
    hold on;
    axis equal;
    grid on;

    % Plot each microphone position
    plot(microphonePositions, zeros(1, numMics), 'ko', 'MarkerFaceColor', 'k');

    % Assume all microphones are at y = 0 for a linear array
    y_positions = zeros(1, numMics);

    % Convert overall DOA from degrees to radians
    theta_rad = deg2rad(overallDOA);  
    arrow_length = 0.5; % Length of the arrows
    u = arrow_length * cos(theta_rad); % Horizontal component
    v = arrow_length * sin(theta_rad); % Vertical component

    % Draw arrows for the estimated DOA from each microphone
    for i = 1:numMics
        quiver(microphonePositions(i), y_positions(i), u, v, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.5);
    end

    xlabel('Position (meters)');
    ylabel('DOA Direction');
    title('Microphone Array DOA Estimation');
    hold off;
end
