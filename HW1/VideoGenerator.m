function VideoGenerator(doa_estimates, outputPath, videoFilename, frameRate)
    % Set up the video file writer with specified parameters
    outputVideo = VideoWriter([outputPath videoFilename], 'MPEG-4');
    outputVideo.FrameRate = frameRate;  % Set the frame rate

    % Open the video file for writing
    open(outputVideo);

    % Read each frame image and write it to the video file
    for k = 1:length(doa_estimates)
        imgFilename = sprintf('%sFrame_%04d.png', outputPath, k);
        img = imread(imgFilename);
        writeVideo(outputVideo, img);
    end

    % Close the video file
    close(outputVideo);
end
