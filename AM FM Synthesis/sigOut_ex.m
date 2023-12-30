function sigOut = makeLFMvals(sigLFM, dt)
if(nargin < 2) % nargin- number of input args
dt = 1/8000; % default value
end
sigOut.tt = sigLFM.t1:dt:sigLFM.t2;
sigOut.mu = sigLFM.slope/2;
sigOut.f0 = sigLFM.f1;
sigOut.psi = 2*pi*(sigOut.f0*sigOut.tt + sigOut.mu*sigOut.tt.*sigOut.tt);
sigOut.complexAmp = sigLFM.complexAmp;
xx = real(sigOut.complexAmp*exp(1j*sigOut.psi));
sigOut.times = sigOut.tt;
sigOut.values = xx;
end
