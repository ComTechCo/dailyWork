close all; 
clear all;
im = imread(['Treasure_Medium.jpg']); % change name to process other images
% figure(1)
% imshow(im);
% figure(2)
bin_threshold = 0.1; % parameter to vary
bin_im = im2bw(im, bin_threshold);
% imshow(bin_im);
% title("Threshold value = 0.1")
% figure(3)
con_com = bwlabel(bin_im);
imshow(label2rgb(con_com));
props = regionprops(con_com);
%% Drawing bounding boxes
n_objects = numel(props);
imshow(im);
hold on;
if_follow = ones(n_objects,1);
degs = ones(n_objects,1);
r = 18;
startId = 0;
for object_id = 1 : n_objects
    % 报告提示可以用颜色判断是否为箭头 其实通过区域的大小判定也是可以的
    if (props(object_id).Area > 1480) && (props(object_id).Area < 1580)
        rectangle('Position', props(object_id).BoundingBox, 'EdgeColor', 'b');
        center = props(object_id).Centroid;
        center1 = round(center(1,1));
        center2 = round(center(1,2));
        if im(center2,center1,2) < 10
            startId = object_id;
            plot(center1,center2,'*');
        end    
    end
end
moveId = startId;
ifPass = zeros(n_objects,1);
steps = 1;
while true
    ifPass(moveId,1) = 1;
    steps = steps + 1;
    center = props(moveId).Centroid;
    center1 = round(center(1,1));
    center2 = round(center(1,2));
    towardDeg = 0;
    for deg = 0 : pi/100 : pi * 2
        pointA = round(center(1,1) + r * cos(deg));
        pointB = round(center(1,2) + r * sin(deg));
        plot(pointA,pointB,'.');
        if im(pointB,pointA,2) > 200 && ...
           im(pointB,pointA,3) < 20  && moveId == startId
            disp("FindPoint")
            towardDeg = deg;
            break;
        end 
        disp(moveId)
        if im(pointB,pointA,2) > 230 && ...
           im(pointB,pointA,3) < 5 && ...
           not(moveId==8)&& not(moveId==10)
            disp("FindPoint")
            towardDeg = deg;
            break;
        elseif im(pointB,pointA,2) > 230 && ...
           im(pointB,pointA,3) < 1 && ...
           ((moveId==8)||(moveId==10))
            disp("FindPoint")
            towardDeg = deg;
            break;
        end 
    end
    ifNoMore = 1;
    towardDeg = towardDeg + pi/100;
    for step = 2*r : 1 : 7 * r
        pointA = round(center(1,1) + step * cos(towardDeg));
        pointB = round(center(1,2) + step * sin(towardDeg));
        plot(pointA,pointB,'.');
        if pointA > 640 || pointA < 1 || pointB > 480 || pointB < 1
            continue;
        end
        if im(pointB,pointA,2) > 200 && ...
            im(pointB,pointA,3) > 200 && ...
            im(pointB,pointA,1) > 200
            disp("FindNextSig")
            for object_id = 1 : n_objects
                center = props(object_id).Centroid;
                if abs(pointA-center(1,1))+abs(pointB-center(1,2)) < 50 ...
                    && ifPass(object_id,1) == 0
                    plot(center(1,1),center(1,2),'*')
                    disp("FindNextPoint")
                    moveId = object_id;
                    ifNoMore = 0;
                    ifPass(object_id,1) = 1;
                    break;
                end
            end
            break;
        end
    end
    if ifNoMore == 1 || steps > n_objects 
        break;
    end
end
hold off;