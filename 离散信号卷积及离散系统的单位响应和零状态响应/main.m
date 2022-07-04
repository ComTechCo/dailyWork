randNumber = round(rand(1,4)*3);
y = [2,-randNumber(1),randNumber(2)]
f = [1,randNumber(3),randNumber(4)]
impz(f,y,0:40)

% randNumber = round(rand(1,2)*100)/100;
% y = [1,0.5,0.5];
% f = ones(1,30);
% impz(f,y,0:15)

% randNumber = round(rand(1,2)*8+1);
% h = [1 randNumber(1) randNumber(2)]
% x = [1 0 -randNumber(1)]
% t = 0:1:2;
% dconv(h,x,t,t)