clear all;
clc; 
% Fs Hz (samples per second) is the rate at the speech signal is sampled
Fs = 8000;
% Recording the speech signal
rec = audioread('test.wav'); 
rec = rec(1000:3000);
% Playing the recorded signal
recplayer = audioplayer(rec,Fs);
play(recplayer)
figure(1) 
stem(rec)
title('Recorded input speech signal'); 
xlabel('Length of the input speech signal');
ylabel('Amplitude of the input speech signal');
% Discrete cosine transform of the recorded signal
a0=dct(rec);
figure(2) 
stem(a0)
title('Discrete cosine transform of the recorded signal'); 
xlabel('Length of the DCT spectrum');
ylabel('Amplitude of the DCT spectrum');
% Thresholding the spectrum to make it sparse
for i=1:1:2000
    if  a0(i,1)<=0.05 && a0(i,1)>=-0.06 
        a0(i,1)=0;
    else
        a0(i,1)=a0(i,1);
    end
end
a0=a0(1:2000); 
figure(3) 
stem(a0)
title('The Threshold spectrum');
xlabel('The length of the threshold spectrum');
ylabel('Amplitude of the threshold spectrum');
% Pre-defined measurement matrix
xx=sort(ceil(400*randn(1,1000))); 
n=2000; 
for i=1:n 
    A(:,i)=sin(i*xx)';
end
A = orth(A')'; 
figure(4) 
plot(A)
title('Pre-defined Measurement matrix');
disp('Done.');
%  Observations matrix
y = A*a0; 
figure(5) 
plot(y)
title('Observation Vector');
%initial guess = min energy
x0 = A'*y;
%solve the LP
tic 
xp = l1eq_pd(x0, A, [], y, 1e-2); 
toc 
figure(6) 
plot(xp)
title(' Reconstructed Spectrum using l1-minimization');

% Calculating the error between the Received reconstructed spectrum and actual spectrum
figure(7) 
stem(abs(xp-a0),'-')
title(' Absolute Error of Reconstructed spectrum and Threshold spectrum '); 
xlabel('重构谱与发射阈值谱之间的绝对误差长度')
ylabel('Absolute error');
% Inverse dicrete cosine transform of reconstructed signal
x0 = idct(xp); 
x0player = audioplayer(x0,Fs);
play(x0player);
figure(8) 
stem(x0)
title('Reconstructed signal at the receiver');
xlabel('Length of the reconstructed signal using IDCT');
ylabel('Amplitude of the reconstructed signal using IDCT');



