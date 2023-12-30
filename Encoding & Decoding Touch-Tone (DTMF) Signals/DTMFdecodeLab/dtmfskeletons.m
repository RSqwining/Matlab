%==========================================
function dtmfskeletons
end
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
soundsc(xx,fs); %finally play the sound
end
%==========================================

function keys = dtmfrun(xx,L,fs)
%DTMFRUN    keys = dtmfrun(xx,L,fs)
%    returns the list of key names found in xx.
%   keys = array of characters, i.e., the decoded key names
%     xx = DTMF waveform
%      L = filter length
%     fs = sampling freq
%
center_freqs = [697 770 852 941 1209 1336 1477 1633];
hh = dtmfdesign( center_freqs,L,fs );
%   hh = L by 8 MATRIX of all the filters. Each column contains the
%         impulse response of one BPF (bandpass filter)
%
[nstart,nstop] = dtmfcut(xx,fs);   %<--Find the tone bursts
keys = [];
dtmf.keys = ['1','2','3','A';
           '4','5','6','B';
           '7','8','9','C';
           '*','0','#','D'];
for kk=1:length(nstart)
   x_seg = xx(nstart(kk):nstop(kk));    %<--Extract one DTMF tone
   score =[];
for yy= 1:8
sc = dtmfscore(x_seg,hh(yy));
score = [score sc];
val=find(score, 1);
score(val)=0;
sval=find(score, 1);
sval=sval-4;
keys=[keys dtmf.keys(val,sval)]
end
end
end

%==========================================
function sc = dtmfscore(xx, hh)
 
% xx = input DTMF tone segment 
% hh = impulse response of ONE bandpass filter


% Normalize the input signal to the range [-2, +2] 

 xx = xx * (2 / max(abs(xx)));


% Filter the input signal with the bandpass filter 

 yy = filter(hh, 1, xx);


% Find the maximum amplitude of the filtered signal 

 max_amplitude = max(abs(yy));


% Scoring rule implementation 
% The score equals one when the max amplitude is greater than or equal to 0.59 
 
 sc = max_amplitude >= 0.59;


end


%==========================================
     function hh = dtmfdesign(fb, L, fs)

    % Initialize the matrix to hold the impulse responses
    hh = zeros(L, length(fb));
    
    % Design each filter
    for i = 1:length(fb)

        % Time index n
        n = 0:(L-1); 

        % Unnormalized coefficients for a cosine filter
        h = cos(2*pi*fb(i)*n/fs);

        % Take the FFT to get the frequency response
        H = fft(h);

        % Find the maximum magnitude of the frequency response
        maxH = max(abs(H));

        % Normalize the filter gain so that the peak is 1
        beta = 1/maxH;

        % Store the normalized impulse response
        hh(:,i) = beta * h;
    end
end

