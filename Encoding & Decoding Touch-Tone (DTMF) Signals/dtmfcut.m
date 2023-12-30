function [nstart,nstop] = dtmfcut(xx,fs)
xx = xx(:)' / max(abs(xx)); %xx now from 0 to 1 
intFs = round(0.01*fs); 

xx = filter(ones(1,intFs) / intFs, 1, abs(xx));
xx = diff(xx > 0.02); %below 0.02 don't consider

nzero = find(xx ~= 0)'; %perform ctranspose
%below creates a seg of xx between silences
if xx(nzero(1)) < 0 %remove 0
    nzero = [1; nzero];  
end
if xx(nzero(end)) > 0 %include xx last element if >0
    nzero = [nzero; length(xx)]; 
end

%creates the nstart and nstop given the from the entire nzero 
index = [];
while length(nzero)>1
	if nzero(2)>(10*intFs+nzero(1))
		index = [index, nzero(1:2)];
	end
	nzero(1:2) = [];
end

nstart = index(1,:);
nstop = index(2,:);
