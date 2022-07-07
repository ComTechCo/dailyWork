clc;
clear all;
x=audioread('data_cctv.wav'); 
Fs=48000;
p=12;   %p为预测阶数
N=128;
Lpcs=zeros(floor((length(x)/N)*0.75),p);

%lpc 线性预测系数 Levinson-Durbin 算法实现
%lpc(i)即文中码矢bi 
ci=2;
for i=floor((length(x)/N)*0.15):floor((length(x)/N)*0.9)
   fragment=x(i*N+1:(i+1)*N); 
   durbin_i=durbin1(fragment,p);
   if_allzero=1;
   if_nan=0;
   for j=1:p
       if durbin_i(j)>0
           if_allzero=0;
       end
       if isnan(durbin_i(j))
           if_nan=1;
           break;
       end
   end
   if (if_nan==0 && if_allzero==0) || (ci-1<0) 
       Lpcs(ci,:)=durbin_i;
   else
       Lpcs(ci,:)=Lpcs(ci-1,:);
   end
   ci=ci+1;
end
figure(1) 
stem(Lpcs')
title('不同语段得到的预测系数'); 
xlabel('i');
ylabel('第i点的预测系数');

%Matlab聚类相关算法见网站描述
%https://ww2.mathworks.cn/help/stats/cluster-analysis-example.html

%通过k阶聚类算法构造系数矢量码本,取J类
J=80;
[Idx,Ctrs,SumD,D] = kmeans(Lpcs,J);
kmeanLpcs = Ctrs;

%由聚类所得码矢构造矩阵，所有的矩阵一起构成过完备的OLP字典
OLP=zeros(N,N,J);
OLPIn_=zeros(N,N);
for n=1:J
    OLPIn_=zeros(N,N);
    for lj=1:N
        jCounter=1;
        OLPIn_(lj,lj)=1;
        for li=lj+1:N
            if jCounter>p
                break;
            else
                OLPIn_(li,lj)=kmeanLpcs(n,jCounter);
                jCounter=jCounter+1;
            end
        end
    end
    OLPIn=inv(OLPIn_);
    OLP(:,:,n)=OLPIn;
end
%---------------------------------------------------------

%Levinson-Durbin 算法
function z=durbin1(y,order)
R=zeros(1,order+1);
aa=zeros(order,order);
parcor=zeros(1,order);%autocorrelation
N=size(y,1);
for h=1:order+1
    R(h)=0;
    for f=h:N
        R(h)=R(h)+y(f)*y(f-h+1);
    end
end
parcor(1)=R(2)/R(1);
aa(1,1)=parcor(1);
E=(1-parcor(1)^2)*R(1);
for h=2:order
    temp=0;
    for f=1:h-1
        temp=temp+aa(h-1,f)*R(h-f+1);
    end
    parcor(h)=(R(h+1)-temp)/E;%反射系数
    aa(h,h)=parcor(h);
    for f=1:h-1
        aa(h,f)=aa(h-1,f)-parcor(h)*aa(h-1,h-f);
    end
    E=E*(1-parcor(h)^2);
end
z=-aa(order,:);
end
