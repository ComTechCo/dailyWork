clc; 
%Fs 单位 Hz 输入信号的采样率
Length=8000;
Fs=8000; 
x=audioread('test.wav'); 
figure(1) 
stem(x)
title('输入信号'); 
xlabel('输入信号长度');
ylabel('输入信号振幅');
%对输入信号进行离散余弦变化（DCT）
a0=dct(x); 
figure(2) 
stem(a0) 
axis([0 2000 -1 1]);
title('记录信号的离散余弦变换（DCT）'); 
xlabel('DCT谱的长度');
ylabel('DCT谱的振幅');
% Thresholding the spectrum to make it sparse（阈值化）
for i=1:1:Length
    if  a0(i,1)<=0.04 && a0(i,1)>=-0.06 
        a0(i,1)=0;
    else
        a0(i,1)=a0(i,1);
    end
end
a0; 
figure(3) 
stem(a0) 
axis([0 2000 -1 1]);
title('The Threshold spectrum（阈值化）');
xlabel('The length of the threshold spectrum'); 
ylabel('Amplitude of the threshold spectrum');
%频谱稀疏度（K）和信号长度（N）
K=800;
N=Length;
%随机测量矩阵
disp('正在创建度量矩阵');
A = randn(K,N); 
A = orth(A')'; 
figure(4) 
imagesc(A) 
colorbar; 
colormap('lines');
title('随机测量矩阵');
disp('OK.');
%  观测向量
y = A*a0; 
figure(5) 
plot(y)
title('观测向量');
%初始猜测=最小能量
x0 = A'*y;
%solve the LP
tic 
xp = l1eq_pd(x0, A, [], y, 1e-2); 
toc 
figure(6) 
plot(xp) 
axis([0 2000 -0.6 0.6]);
title('用l1最小化重构谱');
% 重建信号的反二重余弦变换（IDCT）
Xrec=idct(xp); 
Xrecplayer = audioplayer(Xrec,Fs);
play(Xrecplayer);
figure(7) 
stem(Xrec)
title('接收端重构信号'); 
xlabel('用IDCT重建信号的长度'); 
ylabel('用IDCT重建信号的振幅');
% Calculating Absolute error between the reconstructed and actual signal
err=abs(Xrec-x);
stem(err);
title('重建谱和阈值谱的绝对误差'); 
xlabel('最大绝对误差长度'); 
ylabel('最大绝对误差');

