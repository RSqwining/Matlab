function xx = dtmfdial(keyNames,fs)
%DTMFDIAL Create a signal vector of tones which will dial
%           a DTMF (Touch Tone) telephone system.
%
% usage:    xx = dtmfdial(keyNames,fs)
% keyNames =  vector of characters containing valid key names
% fs = sampling frequency
% xx = signal vector that is the concatenation of DTMF tones.
%
dtmf.keys = ['1','2','3','A';
            '4','5','6','B';
            '7','8','9','C';
            '*','0','#','D'];
dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];
dtmf.rowTones=[697;770;852;941]*ones(1,4);
xx=0; %initialize the output vector to 0
tt=0:1/fs:0.2; %time interval
for ii = 1:length(keyNames)
   key=keyNames(ii); %key in the char array
   [krow,kcol]=find(key==dtmf.keys); %determine the indices
   if(numel(krow)==0 || numel(kcol) == 0) %make sure not invalid
       continue
   end
   sinusoid=cos(2*pi*dtmf.rowTones(krow, kcol)*tt) + cos(2*pi*dtmf.colTones(krow, kcol)*tt); %create dual sinusoid given freq
   xx=[xx zeros(1, 0.05*fs) sinusoid]; %append the wait time and sinusoid 
end
end