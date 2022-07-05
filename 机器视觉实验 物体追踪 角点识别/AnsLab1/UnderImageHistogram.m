OnePic = imread('One_colour.jpg');
TwoPic = imread('Two_colour.jpg');
OnePicGray = im2gray(OnePic);
TwoPicGray = im2gray(TwoPic);
tiledlayout(2,2)
nexttile
imshow(OnePicGray)
title('P1')
nexttile
hist(double(OnePicGray),124)
title('Histogram of P1')
nexttile
imshow(TwoPicGray)
title('P2')
nexttile
hist(double(TwoPicGray),124)
title('Histogram of P2')