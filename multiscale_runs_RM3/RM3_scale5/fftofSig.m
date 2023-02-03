function [ftSigPeak] = fftofSig(Sig,time)

t =  time;                    % Time vector 
L  = length(t);               % Length of signal
Fs = (1/abs(t(3) - t(2)));    % Sampling frequency
n = pow2(nextpow2(L));        

P2            = (Sig);
P2            = fft(P2,n,1);
P2            = abs(P2/L);
P1            = P2(1:n/2+1,:);
P1(2:end-1,:) = 2*P1(2:end-1,:);
ftSigPeak.sig = (P1);
ftSigPeak.f   = (Fs/n)*     (0:(n/2));
ftSigPeak.w   = 2*pi.*    ftSigPeak.f;
ftSigPeak.Tp  = 1./ftSigPeak.f;
end




 