function [peak] = fft_peak(output,i)
warning off

peak.bodies(i).position                 = fftpeak(output.bodies(i).position,             output(.5*end:.75*end,:));
peak.bodies(i).forceTotal               = fftpeak(output.bodies(i).forceTotal,           output(.5*end:.75*end,:));
peak.bodies(i).forceExcitation          = fftpeak(output.bodies(i).forceExcitation,      output(.5*end:.75*end,:));
peak.bodies(i).forceRadiationDamping    = fftpeak(output.bodies(i).forceRadiationDamping,output(.5*end:.75*end,:));
peak.bodies(i).forceRestoring           = fftpeak(output.bodies(i).forceRestoring,       output(.5*end:.75*end,:));

try
for j = 1:length(output.constraints)    
peak.bodies(i).forceConstraint(j)       = fftpeak(output.constraints(j).forceConstraint,output(.5*end:.75*end,:));
end
catch
end
try
for k = 1:length(output.ptos)
peak.ptos(k).powerInternalMechanics     = fftpeak(output.ptos(k).powerInternalMechanics,output(.5*end:.75*end,:));
end
catch
end

peak.name = output.bodies(i).name; 
peak.f    = peak.bodies(i).position.f;
peak.w    = peak.bodies(i).position.w;
peak.Tp   = peak.bodies(i).position.Tp;

function [ftSigPeak] = fftpeak(Sig,output)

t =  output.wave.time;        % Time vector 
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

end
 





