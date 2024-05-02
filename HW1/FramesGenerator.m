function FramesGenerator(doa_estimates, d, MicrophoneCount, outputPath)
    % Check and create the output directory if it does not exist
    if ~exist(outputPath, 'dir')
        mkdir(outputPath);
    end

    % Create a figure for plotting the frames
    figure;
    hold on;
    grid on;
    axis equal;

    % Generate and save frames
    for k = 1:length(doa_estimates)
        GetSingleFrame(doa_estimates(k), d, MicrophoneCount, k, outputPath);
        clf; % Clears the current figure for the next frame
    end

    % Release resources
    hold off;
    close;
end
