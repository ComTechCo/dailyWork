%clear all;
I = imread('YourAnswer.png');

r= double(I(:,:,1)); 
g = double(I(:,:,2)); 
b = double(I(:,:,3)); 
tiledlayout(3,1)
nexttile
hist(r(:),124)
title('Histogram of the red colour')
nexttile
hist(g(:),124)
title('Histogram of the green colour')
nexttile
hist(b(:),124)
title('Histogram of the blue colour')