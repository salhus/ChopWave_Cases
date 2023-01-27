function [peak] = fft_peak(output,i)

peak.name = output.bodies(i).name; 
try
[peak.bodies(i).position, peak.f]       = fftpeak(output.bodies(i).position,output(.5*end:.75*end,:));
catch
end
try
peak.bodies(i).forceTotal               = fftpeak(output.bodies(i).forceTotal,output);
catch
end
try
peak.bodies(i).forceExcitation          = fftpeak(output.bodies(i).forceExcitation,output(.5*end:.75*end,:));
catch
end
try
peak.bodies(i).forceRadiationDamping    = fftpeak(output.bodies(i).forceRadiationDamping,output);
catch
end
try
peak.bodies(i).forceRestoring           = fftpeak(output.bodies(i).forceRestoring,output);
catch
end
try
for nn = 1:length(output.constraints)    
peak.bodies(i).forceConstraint(nn)      = fftpeak(output.constraints(nn).forceConstraint,output);
end
catch
end
try
for j = 1:length(output.ptos)
peak.ptos(j).powerInternalMechanics   = fftpeak(output.ptos(j).powerInternalMechanics,output(.5*end:.75*end,:));
end
catch
end
function [ftSigPeak, f] = fftpeak(Sig,output)

t =  output.wave.time(.5*end:.75:end,:);        % Time vector 
L  = length(output.wave.time(.5*end:.75:end,:));% Length of signal
Fs = 10*  (1/abs(t(3) - t(2)));
n = pow2(nextpow2(L));


P2 = abs(Sig);% - (mean(abs((Sig))));

P2 = fft(P2,n,1);
P2 = abs(P2/L);

P1            =   P2(1:n/2+1,:);
P1(2:end-1,:) = 2*P1(2:end-1,:);


ftSigPeak = (P1);
f         = (Fs*(0:(n/2))/n)  /10;
end

end
 





