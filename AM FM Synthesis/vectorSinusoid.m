amplitudes = [1,1];
freqs = [1200,750];
phases = [0.6*pi, -0.1*pi];
fs = 8000;
tStart = [0.6,0.2];
durs = [0.5,1.6];
sum3_1 = sumSinus(tStart,durs,amplitudes,freqs,phases,fs);
%% Example Spectrogram
fs = 8000;
tt = 0:1/fs:0.5;
xx = cos(4000*pi*tt);
yy = xx + cos(1600*pi*tt);
plotspec(yy, fs, 1024); colorbar
%% Spectrogram of xx (sum signal) derived from Exercise 3.1
% Section length = 256
plotspec(sum3_1, fs, 256); grid on; colorbar
% Add title and axis labels
   title('Spectrogram of Composite Signal with Sec. Length = 256 (For
Verification)');
   xlabel('Time (s)');
   ylabel('Frequency (Hz)');
%% Section Length = 1024
plotspec(sum3_1, fs, 1024); colorbar
% Add title and axis labels
   title('Spectrogram of Composite Signal with Sec. Length = 1024 (For
Verification)');
   xlabel('Time (s)');
   ylabel('Frequency (Hz)');
%% Section Length = 2048
plotspec(sum3_1, fs, 2048); grid on ; colorbar
% Add title and axis labels
   title('Spectrogram of Composite Signal with Sec. Length = 2048 (For
Verification)');
   xlabel('Time (s)');
   ylabel('Frequency (Hz)');
   %% Section Length = 4096
plotspec(sum3_1, fs, 4096); grid on ; colorbar
% Add title and axis labels
   title('Spectrogram of Composite Signal with Sec. Length = 4096 (For
Verification)');
   xlabel('Time (s)');
   ylabel('Frequency (Hz)');
%% Section Length = 8198
plotspec(sum3_1, fs, 8198); grid on ; colorbar
% Add title and axis labels
   title('Spectrogram of Composite Signal (For Verification)');
   xlabel('Time (s)');
   ylabel('Frequency (Hz)');
