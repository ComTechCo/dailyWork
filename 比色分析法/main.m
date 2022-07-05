% v = VideoReader('./Video/Video2.mp4');
% v.CurrentTime = 0;
% backGround = readFrame(v);
% keyPoint = [1680 960];
% indexFrame = 1;
% timeColour = zeros(1,7200);
% while hasFrame(v)
%     vidFrame = readFrame(v) - backGround;
%     timeColour(1,indexFrame) = sum(vidFrame(keyPoint(2),keyPoint(1),:));
%     indexFrame = indexFrame + 1;
% %     image(vidFrame, 'Parent', currAxes);
% %     currAxes.Visible = 'off';
% %     pause(0.01);
% end
smoothColour = smoothdata(timeColour(1:indexFrame));
%plot(smoothColour,'gaussian',indexFrame*0.1);
[maxData,maxIndex] = max(smoothColour(1:indexFrame));
minLength = 1;
for midIndex = 1:indexFrame
    if timeColour(1,midIndex) > maxData * 0.95
        break;
    end
    if timeColour(1,midIndex) < maxData * 0.1
        minLength = minLength + 1;
    end
end
subplot(3,3,1:3);
normalizeData = 1-smoothColour(1:maxIndex+minLength)/maxData;
normalizeData = normalizeData/max(normalizeData);
plot(normalizeData);
xlabel('Frame')
ylabel('Normalized Data')

subplot(3,3,4);
minFrame = read(v,[minLength minLength]);
plot(keyPoint(2),keyPoint(1),'o');
imshow(minFrame)
hold on;
plot(keyPoint(1),keyPoint(2),'o');
hold off;

subplot(3,3,5);
midFrame = read(v,[midIndex midIndex]);
imshow(midFrame)
hold on;
plot(keyPoint(1),keyPoint(2),'o');
hold off;

subplot(3,3,6);
maxFrame = read(v,[maxIndex maxIndex]);
imshow(maxFrame)
hold on;
plot(keyPoint(1),keyPoint(2),'o');
hold off;

a1 = keyPoint(2)-25;
a2 = keyPoint(2)+25;
b1 = keyPoint(1)-50;
b2 = keyPoint(1)+50;

subplot(3,3,7);
imshow(minFrame(a1:a2,b1:b2,:));

subplot(3,3,8);
imshow(midFrame(a1:a2,b1:b2,:));

subplot(3,3,9);
imshow(maxFrame(a1:a2,b1:b2,:));
