AFSNR_Basts=1:10;
for times=1:10
    mcaseNumber=floor((length(x)/N)*0.5)+times*10;
    mcase=x(mcaseNumber*N+1:(mcaseNumber+1)*N); 
    caseplayer = audioplayer(mcase,Fs);
    play(caseplayer)
    rate=1;
    %频谱稀疏度（M）和信号长度（N）M/N为压缩比
    M=fix(N*rate)+1;
    %随机随机观测矩阵
    A = randn(M,N); 
    %y为由观测矩阵A压缩所得的观测向量
    y=A*mcase;
    %测量值中解出信号x重构的最直接方法是通过l0范数下求解稀疏系数的估计
    f=linspace(1,1,N);
    f=[f,f]';
    AFSNR_Bast=-1;
    for caseJ=1:J
        Aeq=A*reshape(OLP(:,:,caseJ),N,N);
        Aeq=[Aeq,-Aeq];%x=u-v (Ay=b)
        beq=y;
        [uv,countZ]=linprog(f,[],[],Aeq,beq,zeros(2*N,1));%下界规定出来防止报错
        clc;
        errorthis=(uv(1:N)-uv(N+1:end))-mcase;
        AFSNR=10*log10((mcase'*mcase)/(errorthis'*errorthis));
        if AFSNR>AFSNR_Bast
            ansOutput=uv(1:N)-uv(N+1:end);
            AFSNR_Bast=AFSNR;
        end
    end
    AFSNR_Basts(times)=AFSNR_Bast;
end
AFSNR_Basts