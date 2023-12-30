%% Function sumSinus that sums up two arbitrary signals
 tt = (1/fs)*(0:length(xx)-1);
plot(tt,xx);
12
function xx = sumSinus(tStart, durs, amplitudes, freqs, phases, fs)
   % Parameter Processing
   maxTime = max(tStart + durs) + 0.1;
   durLengthEstimate = ceil(maxTime * fs);
   tt = (0:durLengthEstimate-1) * (1/fs);
   xx = 0 * tt; % Initialize composite signal as zero vector with the same length as tt
   % Summing up the sinusoids based on input parameters
   for kk = 1:length(amplitudes)
       nStart = round(tStart(kk) * fs) + 1;
       xNew = shortSinus(amplitudes(kk), freqs(kk), phases(kk), fs, durs(kk));
       Lnew = length(xNew);
       nStop = nStart + Lnew - 1;
       xx(nStart:nStop) = xx(nStart:nStop) + xNew;
end
   % Peak Analysis
   maxAmplitude = max(xx);
   minAmplitude = min(xx);
   fprintf('Max Amplitude: %f\n', maxAmplitude);
   fprintf('Min Amplitude: %f\n', minAmplitude);
   % Dominant Frequency Components
   [Pxx, F] = periodogram(xx, [], [], fs);
   [~, dominantIdx] = max(Pxx);
   fprintf('Dominant Frequency: %f Hz\n', F(dominantIdx));
end
