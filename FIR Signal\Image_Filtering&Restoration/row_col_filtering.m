%file pulled from https://dspfirst.gatech.edu/database/?d=labs&chap=5 under SamplingConvFiltering.zip file
%row filtering 
load('echart.mat')
bdiffh=[1,-1];
yy1=conv2(echart,bdiffh); % row filtering subplot(2,1,1);
imshow(echart); subplot(2,1,2); imshow(yy1);

%column filtering
load('echart.mat')
bdiffh=[1,-1];
yy2=conv2(echart,bdiffh'); %similar to row filtering but inverted coeff(column filtering) subplot(2,1,1);
imshow(echart);
subplot(2,1,2);
imshow(yy2);
