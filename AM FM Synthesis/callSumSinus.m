% We use a modified form of the preliminary functions
% First, we construct and then call a function called sumSinus that sums
two arbitrary signals.
% Parameter Declaration
amplitudes = [1,1];
freqs = [1200,750];
phases = [0.6*pi, -0.1*pi];
fs = 8000;
tStart = [0.6,0.2];
durs = [0.5,1.6];
sum3_1 = sumSinus(tStart,durs,amplitudes,freqs,phases,fs);
%% Plotting the spectrogram for verification:
%  Plotting and playing the composite signal
   plotspec(sum3_1, fs, 256); grid on
   % Add title and axis labels
   title('Problem 3.1: Spectrogram of Composite Signal (For
Verification)');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
