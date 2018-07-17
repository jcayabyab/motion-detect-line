function outputVideo = cropVideo(inputVideo)
%CROPVIDEO This function crops a video

[~, ~, ~, frames] = size(inputVideo);

prompt = {sprintf(['Note: This video has %d frames.\n'...
                 'First Frame:'], frames), ...
          'Last Frame:'};
title = 'Enter frames for analysis:';
dims = [1 40];
definput = {'1', num2str(frames)};
userInput = inputdlg(prompt, title, dims, definput);

userInput = str2double(userInput);

frame1 = userInput(1);
frame2 = userInput(2);

if (isempty(userInput))
    return;
end

[~, dims] = imcrop(inputVideo(:,:,:,frame1));
xmin = floor(dims(1));
ymin = floor(dims(2));
width = floor(dims(3));
height = floor(dims(4));

xmax = xmin + width;
ymax = ymin + height;
newLength = frame2 - frame1;

vid = zeros(height + 1, width + 1, 3, newLength, 'uint8');

for i = 1:newLength
    j = i + frame1;
    currentFrame = inputVideo(ymin:ymax,xmin:xmax,:,j);
    vid(:,:,:,i) = currentFrame;
end

outputVideo = vid;

end