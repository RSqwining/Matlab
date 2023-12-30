function sigBeatSum = sum2BeatStruct(sigBeatIn)
sigBeatSum.f1 = sigBeatIn.fc - sigBeatIn.fd;
sigBeatSum.f2 = sigBeatIn.fc + sigBeatIn.fd;
sigBeatSum.phi1=sigBeatIn.phic - sigBeatIn.phid;
sigBeatSum.phi2=sigBeatIn.phic + sigBeatIn.phid;
sigBeatSum.X1 = sigBeatIn.Amp/2;
sigBeatSum.X2 = sigBeatIn.Amp/2;
sigBeatSum.times = sigBeatIn.t1:1/(sigBeatIn.fs):sigBeatIn.t2;
sigBeatSum.values = sigBeatSum.X1*cos(2*pi*sigBeatSum.f1*sigBeatSum.times +
sigBeatSum.phi1) + sigBeatSum.X2*cos(2*pi*sigBeatSum.f2*sigBeatSum.times +
sigBeatSum.phi2);
end
