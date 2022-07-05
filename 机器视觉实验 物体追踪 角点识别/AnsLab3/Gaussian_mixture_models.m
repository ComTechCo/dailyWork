clear all
close all 

% read the video
source = VideoReader('car-tracking.mp4');  

% create and open the object to write the results
output = VideoWriter('gmm_output8.mp4', 'MPEG-4');
open(output);

% create foreground detector object
n_frames = 2;   % a parameter to vary
n_gaussians = 2;   % a parameter to vary
% NumTrainingFrames 训练背景模型的初始视频帧数，指定为整数。
% NumGaussians 为正整数。 通常，您会将此值设置为 3、4 或 5。
% 将该值设置为 3 或更大，以便能够对多种背景模式进行建模。
detector = vision.ForegroundDetector('NumTrainingFrames', n_frames, ...
    'NumGaussians', n_gaussians);

% --------------------- process frames -----------------------------------
% loop all the frames
while hasFrame(source)
    fr = readFrame(source);     % read in frame
    
    fgMask = step(detector, fr);    % compute the foreground mask by Gaussian mixture models
    
    % create frame with foreground detection
    fg = uint8(zeros(size(fr, 1), size(fr, 2)));
    fg(fgMask) = 255;
    
    % visualise the results
    figure(1),subplot(2,1,1), imshow(fr)
    subplot(2,1,2), imshow(fg)
    drawnow   
    writeVideo(output, fg);           % save frame into the output video
end


close(output); % save video
