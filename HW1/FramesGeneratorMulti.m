function FramesGeneratorMulti(doa_estimates, d, MicrophoneCount, outputPath, figNumber)
    % Check and create the output directory if it does not exist
    if ~exist(outputPath, 'dir')
        mkdir(outputPath);
    end

    % Generate and save frames
    for k = 1:length(doa_estimates)
        GetSingleFrameMulti(doa_estimates(:,k), d, MicrophoneCount, k, outputPath, figNumber);
        clf; % Clears the current figure for the next frame
    end

    % Release resources
    hold off;
    close;
end
