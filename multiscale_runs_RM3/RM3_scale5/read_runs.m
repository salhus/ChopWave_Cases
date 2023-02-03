clc;clear;close all
warning off
%%
pathn = cd;
RunList = dir([pathn '\chopsim*']);
nRun      = length(RunList);


%%
mode=3;

for body=1
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');



for nR = 1:nRun
load(sprintf('%s',RunList(nR).name))
peak(nR) = fft_peak(output,body);
for kk = 1:length(output.ptos)
avgPower(nR,kk) = mean(abs(output.ptos(kk).powerInternalMechanics(floor(.25*end):floor(.75*end),mode)));
avgForce(nR,kk) = mean(abs(output.ptos(kk).forceInternalMechanics(floor(.25*end):floor(.75*end),mode)));
end
end
end


for p = 1:nRun
% 
position(p,body)               = max(peak(p).bodies.position.sig(:,mode)) ;

end

position = reshape(position,8,5);
avgPower = reshape(avgPower,8,5);
avgForce = reshape(avgForce,8,5);


T = 5:3:17;
dir = 22.5:22.5:180;
%%

figure()

h = heatmap(position);
h.XData  = T;
h.YData  = dir;
h.XLabel = 'Periods T(s)';
h.YLabel = 'Direction \theta^\circ';
h.FontName = 'Times';
h.FontSize = 14;
h.Title  = 'Position (m or deg)';


figure()

h = heatmap(avgPower);
h.XData  = T;
h.YData  = dir;
h.XLabel = 'Periods T(s)';
h.YLabel = 'Direction \theta^\circ';
h.FontName = 'Times';
h.FontSize = 14;
h.Title  = 'Power (W)';

figure()

h = heatmap(avgForce);
h.XData  = T;
h.YData  = dir;
h.XLabel = 'Periods T(s)';
h.YLabel = 'Direction \theta^\circ';
h.FontName = 'Times';
h.FontSize = 14;
h.Title  = 'Force (N)';

