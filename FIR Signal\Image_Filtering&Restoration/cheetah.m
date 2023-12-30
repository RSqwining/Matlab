A = imread('cameraman.jpg'); A_gray = rgb2gray(A);
A_double = im2double(A_gray);
% Execute SVD
[U, S, V] = svd(A_double);
% Retain only the k largest singular values
k = 50;
% You can change this value
S_denoised = S; S_denoised(k+1:end, k+1:end) = 0;
% Reconstruct the denoised image
A_denoised = U * S_denoised * V';
% Display the denoised image
imshow(A_denoised);
% Compute PSNR
psnrValue = psnr(A_denoised, A_double); disp(['PSNR: ',
num2str(psnrValue)]);
