xx = 256 * (rem(0:100, 50) < 10); %input coeff = [1, -0.9]; %filter coefficients
w = firfilt(coeff, xx); %output
n = 0:75;
figure(1);
subplot(2, 1, 1); 
stem(n, xx(n+1)); 
xlabel('n'); ylabel('x[n]'); 
title('Input Signal'); 
subplot(2, 1, 2); 
stem(n, w(n+1)); 
xlabel('n'); 
ylabel('w[n]'); 
title('Filtered Signal');
