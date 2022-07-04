%P3Q1
% A=[1 -0.5 0.25 0];
% B=[1 2 0.27 1];
% p=roots(A)
% pm=abs(p);
% if  max(pm)<1 
%     disp('稳定')
% else 
%     disp('不稳定')
% end 
% un=zeros(1,100);
% un(1) = 1;
% sn=filter(B,A,un);
% n=0:length(sn)-1;
% plot(n,sn);
% xlabel('n')
% ylabel('H(n)')

%P3Q2
A=[1 0 0];
B=[1 -1.6 0.9425];
distribution(A,B);
A=[1 -0.3 0];
B=[1 -1.6 0.9425];
distribution(A,B);
A=[1 -0.8 0];
B=[1 -1.6 0.9425];
distribution(A,B);
A=[1 -1.6 0.8];
B=[1 -1.6 0.9425];
distribution(A,B);

% %P4
% figure;
% a = 1/100.49;
% A = [1 -1.8237 0.9801];
% B = [a 0 a];
% N = 200;
% h = impz(B,A,N+1);
% parsum = 0;
% for k = 1:N+1
%     parsum = parsum + abs(h(k));
%     if abs(h(k)) < 10^(-6)
%         break
%     end
% end
% % Plot the impulse response
% n = 0:N;
% stem(n,h)
% xlabel('Time index n'); ylabel('Amplitude');
% % Print the value of abs(h(k)) 
% disp('Value =');disp(abs(h(k)));
% 
% 
% un=ones(1,100);
% sn=filter(B,A,un);
% n=0:length(sn)-1;
% figure;
% plot(n,sn);
% xlabel('n')
% ylabel('S(n)')
% 
% index = 1:1:100;
% useSin = sin(0.014*index)+sin(0.4*index); 
% sn=filter(B,A,useSin);
% figure;
% plot(n,sn);
% xlabel('n')
% ylabel('Y(n)')