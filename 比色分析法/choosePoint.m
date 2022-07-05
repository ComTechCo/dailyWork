v = VideoReader('./Video/Video1.mp4');
v.CurrentTime = input("Please input time you need:");
frame = readFrame(v);
imshow(frame)