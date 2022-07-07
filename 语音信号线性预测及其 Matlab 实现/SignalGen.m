% 运行平台：Windows 7 64bit，MATLAB R2014a
% 录音录5秒钟
recObj = audiorecorder;
pause(2)
disp('Start speaking.')
recordblocking(recObj, 120);
disp('End of Recording.');
% 回放录音数据
play(recObj);
% 获取录音数据
myRecording = getaudiodata(recObj);
% 绘制录音数据波形
plot(myRecording);
%存储语音信号
filename = 'data_120s.wav'; 
audiowrite(filename,myRecording,8000);