%Part 1
q = 0.9;
r = 0.9;
M = 22;
N = 100; % Sample length for our simulation
% Impulse signal
x = [1; zeros(N-1, 1)];
% FIR FILTER-1's impulse response: h1[n] = δ[n] - qδ[n-1]
h1 = [1 -q];
% FILTER-1 operation
w = firfilt(h1, x);
% FIR FILTER-2's impulse response: h2[n] = r^n for n = 0,1,...,M
h2 = r.^(0:M);
% FILTER-2 operation
y = firfilt(h2, w);
% Plotting the impulse response of the cascaded system
figure;
stem(y, 'filled');
title('Impulse Response of the Cascaded System using firfilt()'); xlabel('Sample index n');
ylabel('Amplitude');

%Part 2
load echart;
imshow(echart, []);
q = 0.9;
b1 = [1, -q];
a1 = 1;
% Filtering in the horizontal direction
echo_temp = filter(b1, a1, echart, [], 2);
% Filtering in the vertical direction
echo = filter(b1, a1, echo_temp, [], 1);
imshow(echo, []);
M = 22;
r = 0.9;
b2 = r.^(0:M-1);
a2 = 1; % Denominator coefficients for a FIR filter
% Deconvolving in the horizontal direction
restored_temp = filter(b2, a2, echo, [], 2);
% Deconvolving in the vertical direction
restored = filter(b2, a2, restored_temp, [], 1);
imshow(restored, []);
mse = mean((echart(:) - restored(:)).^2);
disp(mse);

%Part 3
r = 0.9;
M_values = [11, 22, 33];
restored_images = cell(1, numel(M_values));
for idx = 1:numel(M_values)
   M = M_values(idx);
   b2 = r.^(0:M-1);
   a2 = 1; % Denominator coefficients for a FIR filter
   % Deconvolving in the horizontal direction
   restored_temp = filter(b2, a2, echo, [], 2);
   % Deconvolving in the vertical direction
   restored_images{idx} = filter(b2, a2, restored_temp, [], 1);
   figure;
   imshow(restored_images{idx}, []);
   title(['Restored Image with M = ', num2str(M)]);
end
mse_values = zeros(1, numel(M_values));
for idx = 1:numel(M_values)
   mse_values(idx) = mean((echart(:) - restored_images{idx}(:)).^2);
End
% Calculate perceived grayscale change
perceived_changes = sqrt(mse_values);
disp(perceived_changes);
T = table(M_values', mse_values', perceived_changes', 'VariableNames',
{'M_values', 'MSE', 'Perceived_Change'});
disp(T);
