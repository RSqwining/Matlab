amps = [100,120];
freqs = [800,2000];
phases = [0.6*pi, -0.1*pi];
fs = 8000;
tStart = [0.1,0.1];
durs = [0.4,0.4];
maxTime = max(tStart+durs) + 0.1;
durLengthEstimate = ceil(maxTime*fs);
tt = (0:durLengthEstimate)*(1/fs);
xx = 0*tt; % 0 Vector with dimensions = tt
for kk = 1:length(amps)
    nStart = round(tStart(kk)*fs)+1 + 0.1*(kk-1)*fs; % Part(b) Modification
    xNew = shortSinus(amps(kk),freqs(kk),phases(kk),fs,durs(kk));
    Lnew = length(xNew);
    nStop = nStart+Lnew-1;
    xx(nStart:nStop) = xx(nStart:nStop) + xNew;
end
plotspec(xx,fs,256); grid on
soundsc(xx);
