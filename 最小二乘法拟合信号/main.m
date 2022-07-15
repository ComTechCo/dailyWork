clear;
mode = 3; 
if mode ==1
    mtitle = "测试函数";
    t = 2:0.01:2.2;
    % 声明时间序列
    w1 = 30;
    %iData = 100*sin(1.3*w1.*t+pi/4)+50*exp(-t/0.1);
    iData = 160*sin(0.9*w1.*t+pi/5)+150*exp(-t/0.1).*sin(3.4*w1.*t+pi/4);
elseif mode ==2
    % 第一组测试数据
    mtitle = "第一组测试数据";
    DataRead = readtable("data.xlsx");
    t = table2array(DataRead(:,1));
    iData = table2array(DataRead(:,2));
    w1 = 55*2*pi;
elseif mode ==3
    % 第二组测试数据
    mtitle = "第二组测试数据";
    DataRead = readtable("data.xlsx");
    t = table2array(DataRead(:,3));
    iData = table2array(DataRead(:,4));
    w1 = 40*2*pi;
end
%用最小二乘求解非线性曲线拟合（数据拟合）问题（lsqcurvefit函数）
fun = @(fit,t)fit(1)...
    -fit(2).*t...
    +sin(1*w1.*t)*fit(3)...
    +sin(2*w1.*t)*fit(4)...
    +sin(3*w1.*t)*fit(5)...
    +sin(4*w1.*t)*fit(6)...
    +sin(5*w1.*t)*fit(7)...
    +cos(1*w1.*t)*fit(8)...
    +cos(2*w1.*t)*fit(9)...
    +cos(3*w1.*t)*fit(10)...
    +cos(4*w1.*t)*fit(11)...
    +cos(5*w1.*t)*fit(12);
% 声明需要拟合函数参数的初始值以加快收敛
x0 = ones(1,12)*max(iData)*0.8;
% 使用最小二乘法拟合
fit = lsqcurvefit(fun,x0,t,iData);
% 计算拟合的电流
fitData = fun(fit,t);
% 做图
figure;
hold on;
plot(t,iData);
plot(t,fitData);
legend('测量值',"最小二乘法拟合值");
xlabel("时间t/s")
ylabel("电流I/A")
title(mtitle);
hold off;

% 频率 k*w/2/pi 相角(弧度)deg 幅值p1
p1 = sqrt(fit(3)^2+fit(8)^2);
deg1 = asin(fit(3)/p1);
p2 = sqrt(fit(4)^2+fit(9)^2);
deg2 = asin(fit(4)/p1);
formatSpec = '基波频率%.2f(Hz) 相角(弧度)%.2f 幅值%.4f\n';
fprintf(formatSpec,w1/(2*pi),deg1,p1);
formatSpec = '二次谐波频率%.2f(Hz) 相角(弧度)%.2f 幅值%.4f\n';
fprintf(formatSpec,w1*2/(2*pi),deg2,p2);
