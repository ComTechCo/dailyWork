% Conversion between different formats
img = imread('YourAnswer.png'); 
% 将图片转换成灰色 Convert the RGB colour image to grey 
I_grey  = rgb2gray(img);
% 接着将图片转换到HSV色域 HSV format
% 注意到I_gray是size*size的，需要更改为size*size*3，故补足两个通道
I_grey3channal = uint8(zeros(588,588,3));
for i = 1:3
    I_grey3channal(:,:,i) = I_grey; 
end
I_hsv = rgb2gray(I_grey3channal);

% 根据Matlab2022文档 im2bw 已被 imbinarize 取代
% Requires R2019b or later 
tiledlayout(2,2)% 定义图形窗口

nexttile
I_bw1 = im2bw(img,0.2);
imshow(I_bw1);
title('level = 0.2')
nexttile
I_bw2 = im2bw(img,200/255);
imshow(I_bw2);
title('level = 200/255')
nexttile
I_bw3 = imbinarize(I_grey, 'adaptive');
imshow(I_bw3);
title('level = Auto')
nexttile
imshow(I_grey); % 展示原图
title('Origin')
