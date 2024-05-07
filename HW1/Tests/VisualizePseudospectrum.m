
function VisualizePseudospectrum(p_theta_time, theta_range, time_steps, figNumber)
    % Initialize the figure
    figure(figNumber);
    
    % Convert p_theta_time to dB
    dB_p_theta_time = 10 * log10(p_theta_time + eps);  % Convert to dB, eps prevents log(0)
    
    % Use imagesc to display the data
    imagesc(time_steps, theta_range, dB_p_theta_time);
    colorbar;  % Add a colorbar to indicate the scale of values
    clim([-40 0]);  % Set color axis scaling if necessary
    
    % Labeling the axes and title
    xlabel('Time (seconds)');
    ylabel('DOA Angle (degrees)');
    title('Time-Varying Pseudospectrum for DOA Estimation');
    
    % Set y-axis to have correct orientation and labeling
    set(gca, 'YDir', 'normal');
    
    % Grid and other visual enhancements
    grid on;
end
