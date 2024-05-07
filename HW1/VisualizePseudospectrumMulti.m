function VisualizePseudospectrumMulti(p_theta_time, theta_range, time_steps, figNumber)
    % Initialize the figure
    figure(figNumber); 
    subplot(1,3,1);
    % Convert p_theta_time to dB
    dB_p_theta_time_1 = 10 * log10(p_theta_time(:,:,1) + eps);  % Convert to dB, eps prevents log(0)
    
    % Use imagesc to display the data
    imagesc(time_steps, theta_range, dB_p_theta_time_1);
    colorbar;  % Add a colorbar to indicate the scale of values
    clim([-40 0]);  % Set color axis scaling if necessary
    
    % Labeling the axes and title
    xlabel('Time (seconds)');
    ylabel('DOA Angle (degrees)');
    title('Pseudospectrum for DOA Estimation (Aritmetic mean)');
    
    % Set y-axis to have correct orientation and labeling
    set(gca, 'YDir', 'normal');
    
    % Grid and other visual enhancements
    grid on;

    %----------------------------------

    subplot(1,3,2); 
    
    % Convert p_theta_time to dB
    dB_p_theta_time_2 = 10 * log10(p_theta_time(:,:,2) + eps);  % Convert to dB, eps prevents log(0)
    
    % Use imagesc to display the data
    imagesc(time_steps, theta_range, dB_p_theta_time_2);
    colorbar;  % Add a colorbar to indicate the scale of values
    clim([-40 0]);  % Set color axis scaling if necessary
    
    % Labeling the axes and title
    xlabel('Time (seconds)');
    ylabel('DOA Angle (degrees)');
    title('Pseudospectrum for DOA Estimation (Armonic Mean)');
    
    % Set y-axis to have correct orientation and labeling
    set(gca, 'YDir', 'normal');
    
    % Grid and other visual enhancements
    grid on;

    %----------------------------------

    subplot(1,3,3);    
    
    % Convert p_theta_time to dB
    dB_p_theta_time_3 = 10 * log10(p_theta_time(:,:,3) + eps);  % Convert to dB, eps prevents log(0)
    
    % Use imagesc to display the data
    imagesc(time_steps, theta_range, dB_p_theta_time_3);
    colorbar;  % Add a colorbar to indicate the scale of values
    clim([-40 0]);  % Set color axis scaling if necessary
    
    % Labeling the axes and title
    xlabel('Time (seconds)');
    ylabel('DOA Angle (degrees)');
    title('Pseudospectrum for DOA Estimation (Geometric Mean)');
    
    % Set y-axis to have correct orientation and labeling
    set(gca, 'YDir', 'normal');
    
    % Grid and other visual enhancements
    grid on;

end