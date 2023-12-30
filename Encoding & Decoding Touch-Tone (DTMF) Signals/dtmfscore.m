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