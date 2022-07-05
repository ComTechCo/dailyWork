% Lena是图像处理中常用的案例 Opencv相关课程也会见到他
% P.S 图像处理一般用Opnecv比较多 Matlab不那么常用
img = imread('lena.gif');
imgGray = im2gray(img);
% figure(1)
% tiledlayout(2,1)
% nexttile
% hist(double(imgGray),256)
% title('histogram')
% 看了直方图，认为合适的阈值是95
% 理由：把图像压扁一点，95的地方是两个波峰间的波谷
% nexttile
% imgBW = im2bw(img,95/255);
% imshow(imgBW);
% title('level = 95/255')
% 
% figure(2)
% imgHisteq = histeq(img);
% tiledlayout(1,2)
% nexttile
% imshow(img)
% title('Origin')
% nexttile
% imshow(imgHisteq)
% title('Applied histeq')

% figure(3)
% % 如果 gamma 小于 1，则 imadjust 会对映射加权，使之偏向更高（更亮）输出值
% % 无参数时 增强 最弱 和 最强 的1%
% imgImad = imadjust(img,[],[],0.9); 
% imgImadAuto = imadjust(img); 
% tiledlayout(2,3)
% nexttile
% imshow(img)
% title('Origin')
% nexttile
% imshow(imgImad)
% title('Applied imadJust Gamma=0.9')
% nexttile
% imshow(imgImadAuto)
% title('Applied Auto imadJust')
% nexttile
% hist(double(img),128)
% title('Histogram of Origin')
% nexttile
% hist(double(imgImad),128);
% title('Histogram after Adjust')
% nexttile
% hist(double(imgImadAuto),128);
% title('Histogram after Auto Adjust')

% figure(4)
% % Synthesise two images from the image  lena.gif’ with two types of noise 
% % Gaussian and salt and pepper" (imnoise). Visualise the results;
% imgNoiseG = imnoise(img,'gaussian');
% imgNoiseS = imnoise(img,'salt & pepper');
% tiledlayout(1,3)
% nexttile
% imshow(img)
% title('Origin')
% nexttile
% imshow(imgNoiseG)
% title('Gaussian')
% nexttile
% imshow(imgNoiseS)
% title('salt & pepper')

% figure(4)
% imgNoiseG = imnoise(img,'gaussian');
% imgNoiseGAdj = imgaussfilt(imgNoiseG,1.2);
% tiledlayout(1,3)
% nexttile
% imshow(img)
% title('Origin')
% nexttile
% imshow(imgNoiseG)
% title('Gaussian')
% nexttile
% imshow(imgNoiseGAdj)
% title('After Filter')

% figure(4)
% imgNoiseG = imnoise(img,'salt & pepper');
% imgNoiseGAdj = imgaussfilt(imgNoiseG);
% tiledlayout(1,3)
% nexttile
% imshow(img)
% title('Origin')
% nexttile
% imshow(imgNoiseG)
% title('salt & pepper')
% nexttile
% imshow(imgNoiseGAdj)
% title('After Filter')

% figure(5)
% imgNoiseG = imnoise(img,'salt & pepper');
% imgNoiseGAdj = medfilt2(imgNoiseG);
% tiledlayout(1,3)
% nexttile
% imshow(img)
% title('Origin')
% nexttile
% imshow(imgNoiseG)
% title('salt & pepper')
% nexttile
% imshow(imgNoiseGAdj)
% title('After Filter')



% figure(5)
% tiledlayout(2,5)
% for i = 1:9
%     nexttile
%     edge1 = edge(img,'sobel',i*0.01);
%     imshow(edge1)
%     mtitle = "sobel with threshold="+num2str(i*0.01);
%     title(mtitle)
% end
% nexttile
% imshow(img)
% title('Origin')
% 
% figure(6)
% tiledlayout(1,2)
% nexttile
% imshow(img)
% title('Origin')
% nexttile
% edge1 = edge(img,'sobel',0.06);
% imshow(edge1)
% title('sobel with threshold=0.06')

% figure(7)
% tiledlayout(2,5)
% for i = 1:9
%     nexttile
%     edge1 = edge(img,'canny',i*0.01+0.3);
%     imshow(edge1)
%     mtitle = "canny with threshold="+num2str(i*0.01+0.3);
%     title(mtitle)
% end
% nexttile
% imshow(img)
% title('Origin')
% 
% figure(8)
% tiledlayout(1,2)
% nexttile
% imshow(img)
% title('Origin')
% nexttile
% edge1 = edge(img,'canny',0.36);
% imshow(edge1)
% title('canny with threshold=0.36')
% 
% figure(9)
% tiledlayout(2,5)
% for i = 1:9
%     nexttile
%     edge1 = edge(img,'prewitt',i*0.01+0.04);
%     imshow(edge1)
%     mtitle = "prewitt with threshold="+num2str(i*0.001+0.04);
%     title(mtitle)
% end
% nexttile
% imshow(img)
% title('Origin')
% 
% figure(10)
% tiledlayout(1,2)
% nexttile
% imshow(img)
% title('Origin')
% nexttile
% edge1 = edge(img,'prewitt',0.042);
% imshow(edge1)
% title('prewitt with threshold=0.042')
