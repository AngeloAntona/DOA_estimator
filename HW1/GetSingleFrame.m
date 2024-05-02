function GetSingleFrame(doaFrame, d, MicrophoneCount, frameNo, outputPath)
    % Define the ULA geometry
    d=d*10;
    x_coords = 0:d:(MicrophoneCount-1)*d; % X coordinates of the array elements
    y_coords = zeros(1, MicrophoneCount); % Y coordinates of the array elements

    % Convert DOA from degrees to radians
    doaRad = deg2rad(doaFrame);

    % Calculate the arrow components
    % Arrow starts from the geometric center of the array
    center_x = mean(x_coords); % Calculate the geometric center of the array
    center_y = 0; % Since y_coords are all zero

    arrow_length = 1; % Length of the arrow can be adjusted
    % Rotate the arrow left by 90 degrees
    u = -arrow_length * sin(doaRad); % Horizontal component
    v = arrow_length * cos(doaRad);  % Vertical component

    % Create figure
    figure(4);
    hold on;
    grid on;
    axis equal;
    
       
    % Draw the ULA as a line using a hexadecimal color code for gray color
    line(x_coords([1 end]), [0 0], 'Color', '#808080', 'LineWidth', 2, 'DisplayName', 'ULA Line');

    % Plot the microphones as dots on the array
    plot(x_coords, y_coords, 'ko', 'MarkerFaceColor', 'k', 'DisplayName', 'Microphones');

    % Plot the DOA as an arrow
    quiver(center_x, center_y, u, v, 'k', 'LineWidth', 2, 'MaxHeadSize', 2, 'DisplayName', 'Estimated DOA');

    % Set plot limits and labels
    title(sprintf('ULA Setup and Estimated DOA - Frame %d', frameNo));

    % Optionally add a legend
    legend show;

    % Save the current frame as an image
    filename = sprintf('%sFrame_%04d.png', outputPath, frameNo);
    saveas(gcf, filename);

    % Turn off the hold
    hold off;
end
