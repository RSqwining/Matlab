xx = 256 * (rem(0:100, 50) < 10); %input 
coeff = [1, -0.9]; %filter coefficients
w = firfilt(coeff, xx); %output
n = 0:75;
l=0:1:22;
r=0.9;
b=r.^l;
y=firfilt(b,w); %restoration output 
subplot(4,1,1);
stem(n,xx(n+1)); 
xlabel('n'); 
ylabel('x[n]'); 
title('Input Signal'); 
xlim([0,75]); 
subplot(4,1,2); 
stem(n,w(n+1));
xlabel('n'); 
ylabel('w[n]'); 
title('Filtered Signal'); 
xlim([0,75]);
subplot(4,1,3);
stem(n,y(n+1));
xlabel('n'); 
ylabel('y[n]'); 
title('Restoration Filter Signal'); 
xlim([0,75]);
subplot(4,1,4); 
stem(n,y(n+1)-xx(n+1)); 
xlabel('n'); 
ylabel('x[n]-y[n]'); 
title('Difference (Error) Signal'); 
xlim([0,50]);
ylim([-30 200]);
