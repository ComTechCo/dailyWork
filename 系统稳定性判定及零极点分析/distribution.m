function distribution(A,B)
    figure;
    subplot(2,1,1)
    zplane(B,A);
    p=roots(A);
    pm=abs(p);
    if  max(pm)<1 
        disp('稳定')
    else 
        disp('不稳定')
    end 
    %第二问
    un=zeros(1,20);
    un(1)=1;
    sn=filter(B,A,un);
    n=0:length(sn)-1;
    subplot(2,1,2)
    plot(n,sn)
    xlabel('n')
    ylabel('h(n)')
end

