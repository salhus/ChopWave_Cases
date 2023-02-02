

%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'RM3.slx';      % Specify Simulink Model File
simu.mode = 'accelerator';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
if viz == 1
simu.explorer = 'on';                   % Turn SimMechanics Explorer (on/off)
elseif viz == 0 
simu.explorer = 'off';    
end
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 10;                    % Wave Ramp Time [s]
simu.endTime = 500;                     % Simulation End Time [s]
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.05; 							% Simulation time-step [s]
simu.cicEndTime = 20;
%% Wave Information
bemFreq = 0.02:0.02:5.2;
bemWaterDepth = 100;

% % % noWaveCIC, no waves with radiation CIC  
waves = waveClass('irregular');       
waves.height = 1e-50;                     
waves.period = waveintT; 
waves.spectrumType = 'PM';
waves.direction = 0;

waveGen(waves,simu,bemFreq,bemWaterDepth) 

if viz == 1
marker = 1;
distance = 20;
[X,Y] = meshgrid(-marker:distance:marker,-marker:distance:marker);
waves.marker.location = [reshape(X,[],1),reshape(Y,[],1)]; 
% Marker Locations [X,Y]
clear('marker','distance','X','Y')
waves.marker.style = 3; % 1: Sphere, 2: Cube, 3: Frame.
waves.marker.size = 15; % Marker Size in Pixels
waves.marker.graphicColor = [1,1,1];
end
% % Regular Waves  
waves1 = waveClass('irregular');                                        
waves1.height = 1;                     
waves1.period = 8;                       
waves1.spectrumType = 'PM';
waves1.direction = 0;

if viz ==1
marker =10;
distance = 10;
[X,Y] = meshgrid(-marker:distance:marker,-marker:distance:marker);
waves1.marker.location = [reshape(X,[],1),reshape(Y,[],1)]; 
% Marker Locations [X,Y]
clear('marker','distance','X','Y')
waves1.marker.style = 2; % 1: Sphere, 2: Cube, 3: Frame.
waves1.marker.size = 20; % Marker Size in Pixels
waves1.marker.graphicColor = [0.1,0.2,0.9];
end
waveGen(waves1,simu,bemFreq,bemWaterDepth) 
w1 = waves1.waveAmpTime;


waves2 = waveClass('irregular');                                    
waves2.height        = chop.H;                    
waves2.period        = chop.T;                       
waves2.spectrumType  = 'PM';
waves2.direction     = chop.dir;

if viz ==1
marker = 10;
distance = 20;
[X,Y] = meshgrid(-marker:distance:marker,-marker:distance:marker);
waves2.marker.location = [reshape(X,[],1),reshape(Y,[],1)]; % Marker Locations [X,Y]
clear('marker','distance','X','Y')
waves2.marker.style = 1; % 1: Sphere, 2: Cube, 3: Frame.
waves2.marker.size = 30; % Marker Size in Pixels
waves2.marker.graphicColor = [0.9,0.2,0.1];
end
waveGen(waves2,simu,bemFreq,bemWaterDepth) 
w2 = waves2.waveAmpTime;


waveGroup = [waves1;waves2];%;waves3;waves4];
SwellandChop(:,1) = w1(:,1); 
SwellandChop(:,2) = w1(:,2) + w2(:,2);% + w3(:,2) + w4(:,2);



save('SwellandChop.mat','SwellandChop')


%% Body Data
% Float
body(1) = bodyClass(sprintf('hydroData/rm3_scale_runs_0-360_deg/rm3_p%d.h5',caseID)); 
body(1).geometryFile = sprintf('geometry/float_p%d.stl',caseID);  
body(1).mass           = 'equilibrium';%Mass.Float;                   
[Ix, Iy, Iz]           = MoIfloat(caseID);
body(1).inertia        = [Ix, Iy, Iz]*rho;  % Moment of Inertia [kg*m^2]     
body(1).yaw.option     = 1;
body(1).yaw.threshold  = 22.5/2;
% Spar/Plate
body(2) = bodyClass(sprintf('hydroData/rm3_scale_runs_0-360_deg/rm3_p%d.h5',caseID)); 
body(2).geometryFile  = sprintf('geometry/spar_p%d.stl',caseID); 
body(2).mass          = 'equilibrium';%Mass.Spar;   
[Ix, Iy, Iz]          = MoIspar(caseID);
body(2).inertia       = [Ix, Iy, Iz]*rho;
body(2).yaw.option    = 1;
body(2).yaw.threshold = 22.5/2;
%% PTO and Constraint Parameters
% Floating (3DOF) Joint
constraint(1) = constraintClass('Constraint1'); % Initialize Constraint Class for Constraint1
constraint(1).location = [0 0 0];               % Constraint Location [m]

% Translational PTO
pto(1) = ptoClass('PTO1');                      % Initialize PTO Class for PTO1
pto(1).stiffness =  10000*.1*caseID;                           % PTO Stiffness [N/m]
pto(1).damping   = 100000*.1*caseID;                       % PTO Damping [N/(m/s)]
pto(1).location = [0 0 0];