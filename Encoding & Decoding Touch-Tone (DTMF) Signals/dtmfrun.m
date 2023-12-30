function keys = dtmfrun(xx,L,fs)
%DTMFRUN    keys = dtmfrun(xx,L,fs)
%    returns the list of key names found in xx.
%   keys = array of characters, i.e., the decoded key names
%     xx = DTMF waveform
%      L = filter length
%     fs = sampling freq
%
center_freqs = [697 770 852 941 1209 1336 1477 1633];
hh = dtmfdesign(center_freqs,L,fs);
%   hh = L by 8 MATRIX of all the filters. Each column contains the
%         impulse response of one BPF (bandpass filter)
%
[nstart,nstop] = dtmfcut(xx,fs);   %<--Find the tone bursts
keys = [];
score=[];
dtmf.keys = ['1','2','3','A';
           '4','5','6','B';
           '7','8','9','C';
           '*','0','#','D'];
for kk=1:length(nstart)
    x_seg = xx(nstart(kk):nstop(kk));    %<--Extract one DTMF tone
    score =[];
    for yy= 1:8
        sc = dtmfscore(x_seg,hh(:,yy));
        score = [score sc];
    end
    val=find(score==1);
    if length(val) ~= 2 || val(1) > 4 || val(2) < 5 
        %must make sure only two freq found, the first in 1-4 index, 
        %and the second in 5-8 index
        continue
    end
    rval=val(1);
    cval=val(2)-4;
    keys=[keys dtmf.keys(rval,cval)];
end