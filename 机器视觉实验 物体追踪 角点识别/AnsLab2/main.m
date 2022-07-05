% figure(1);
% tiledlayout(1,2);
% img1 = imread("GingerBreadMan_first.jpg");
% img2 = imread("GingerBreadMan_second.jpg");
% img1R = img1(:,:,1);
% img2R = img2(:,:,1);
% img1R = imgaussfilt(img1R,10);
% img2R = imgaussfilt(img2R,10);
% redLimit = 180;
% img1R(find(img1R>redLimit))=255;
% img2R(find(img1R>redLimit))=255;
% img1R(find(img1R<redLimit))=0;
% img2R(find(img1R<redLimit))=0;
% nexttile
% C1 = corner(img1R,'QualityLevel', 0.2, ...
%     'SensitivityFactor',0.04);
% imshow(img1)
% hold on
% plot(C1(:,1),C1(:,2),'*');
% title('GingerBreadMan 1')
% hold off
% nexttile
% C2 = corner(img2R,'QualityLevel', 0.2, ...
%     'SensitivityFactor',0.04);
% imshow(img2)
% hold on
% plot(C2(:,1),C2(:,2),'*');
% title('GingerBreadMan 2')
% hold off

% figure(2);
% img1g = img1(:,:,1) ;
% img2g = img2(:,:,1) ;
% tiledlayout(1,2);
% opticFlow = opticalFlowLK('NoiseThreshold',0.015); % 创建光流对象
% nexttile
% flow = estimateFlow(opticFlow,img1g);
% imshow(img1)
% hold on
% plot(flow,'DecimationFactor',[5 5],'ScaleFactor',20);
% hold off
% title('GingerBreadMan 1')
% nexttile
% flow = estimateFlow(opticFlow,img2g);
% imshow(img2)
% hold on
% plot(flow,'DecimationFactor',[5 5],'ScaleFactor',20);
% hold off
% title('GingerBreadMan 2')

% h = figure(3);
% load('red_square_gt.mat')
% opticFlow = opticalFlowLK('NoiseThreshold',0.001); 
% hViewPanel = uipanel(h,'Position',[0 0 1 1]);
% hPlot = axes(hViewPanel);
% vidReader = VideoReader('red_square_video.mp4','CurrentTime',0);
% frameRGB = readFrame(vidReader); 
% frameGray = rgb2gray(frameRGB); 
% ConnerList = zeros(150,2);
% frame = 1;
% ConnerList(frame,:) = corner(frameGray,1);
% frameGray = 0 * frameGray;
% frameGray(245,225) = 255;
% ConnerList(1,:) = [245,225];
% flow = estimateFlow(opticFlow,frameGray);
% while hasFrame(vidReader)
%     frame= frame + 1; 
%     frameRGB = readFrame(vidReader);
%     frameGray = im2gray(frameRGB);
%     cornerAll = corner(frameGray,4);
%     minDis = inf;
%     for i = 1:4
%         if ((ConnerList(frame-1,1)-cornerAll(i,1))^2 + ...
%                 (ConnerList(frame-1,2)-cornerAll(i,2))^2) < minDis
%              ConnerList(frame,:) = cornerAll(i,:);
%              minDis = (ConnerList(frame-1,1)-cornerAll(i,1))^2 + ...
%                 (ConnerList(frame-1,2)-cornerAll(i,2))^2;
%         end
%     end
%     frameGray = frameGray * 0;
%     frameGray(ConnerList(frame,2)-1:1:ConnerList(frame,2)+1, ...
%               ConnerList(frame,1)-1:1:ConnerList(frame,1)+1) = 255;
%     flow = estimateFlow(opticFlow,frameGray);
%     imshow(frameRGB)
%     hold on
%     plot(flow,'DecimationFactor',[9 9],'ScaleFactor',25,'Parent',hPlot);
%     hold off
%     pause(10^-3)
% end

% figure(4)
% plot(gt_track_spatial(:,1),gt_track_spatial(:,2),'-', ConnerList(:,1),ConnerList(:,2),'.');
% legend('True','Count')
% title('Movement track')

% figure(5)
% errors = ones(150,1);
% for i = 1:150
%     errors(i) = sqrt((gt_track_spatial(i,1)-ConnerList(i,1))^2+...
%             (gt_track_spatial(i,2)-ConnerList(i,2))^2);
% end
% plot(1:1:150,errors);
% title('Error of each Frame')
% errY = immse(gt_track_spatial(:,1),ConnerList(:,1));
% errX = immse(gt_track_spatial(:,2),ConnerList(:,2));
% disp(errX)
% disp(errY)