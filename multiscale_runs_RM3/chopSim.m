
clc
clear
close all

%%
currentFolder        = pwd;
rho =1025;
viz = 1;
waveintT = 32;
%%

for caseID = 5

chop.H   = 0.5;

for i = 1:3:15 
chop.T   = 4+i;
for j = 1:8
chop.dir = 0+22.5*j;
wecSim
mkdir(sprintf('RM3_scale%d',caseID))
save(sprintf('chopsim_T%d_dir%d',chop.T,chop.dir*10),"output")
source = sprintf('chopsim_T%d_dir%d.mat',chop.T,chop.dir*10);
destination = sprintf('RM3_scale%d',caseID);
movefile(source,destination)

end
end
















end