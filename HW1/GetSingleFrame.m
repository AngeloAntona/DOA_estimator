function GetSingleFrame(doaFrame, d, MicrophoneCount)
    % Define the ULA geometry
    x_coords = 0:d:(MicrophoneCount-1)*d; % Coordinate X degli elementi dell'array
    y_coords = zeros(1, MicrophoneCount); % Coordinate Y degli elementi dell'array

    % Create figure
    figure;
    hold on;
    grid on;
    axis equal;
    
    % Plot the microphones as dots
    plot(x_coords, y_coords, 'ko', 'MarkerFaceColor', 'k');

    % Convert DOA from degrees to radians
    doaRad = deg2rad(doaFrame);

    % Calculate the arrow components
    % Assuming the arrow starts from the middle microphone (i.e., microphone number 8)
    idxMiddleMic = ceil(MicrophoneCount / 2);
    arrow_length = 1; % Length of the arrow can be adjusted
    % Rotate the arrow left by 90 degrees
    u = -arrow_length * sin(doaRad); % Horizontal component
    v = arrow_length * cos(doaRad);  % Vertical component

    % Plot the DOA as an arrow
    quiver(x_coords(idxMiddleMic), y_coords(idxMiddleMic), u, v, 'r', 'LineWidth', 2, 'MaxHeadSize', 2);
    
    % Set plot limits and labels
    xlim([min(x_coords)-1, max(x_coords)+1]);
    ylim([-1, 1]);
    xlabel('Distance (m)');
    ylabel('Height (m)');
    title('ULA Setup and Estimated DOA');

    % Turn off the hold
    hold off;
end
