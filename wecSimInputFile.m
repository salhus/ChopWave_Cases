
caseID = 7;
rho =1025;
%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'RM3.slx';    % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer='on';                    % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 5;                    % Wave Ramp Time [s]
simu.endTime=50;                       % Simulation End Time [s]        
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.1;                         % Simulation Time-Step [s]
simu.cicEndTime = 40;                   % Specify CI Time [s]
simu.b2b = 1;
%% Wave Information
bemFreq = 0.02:0.02:5.2;
bemWaterDepth = 100;

% % % noWaveCIC, no waves with radiation CIC  
% waves = waveClass('elevationImport');       % Initialize Wave Class and Specify Type  
% waves.elevationFile = 'elevationData.mat';
% waveGen(waves,simu,bemFreq,bemWaterDepth) 

waves = waveClass('irregular');
waves.height = 0.0;                     % Wave Height [m]
waves.period = 3; 
waves.spectrumType = 'PM';
% waves.direction = 90;
% waves.spread = 1;

marker = 1;
distance = 10;
[X,Y] = meshgrid(-marker:distance:marker,-marker:distance:marker);
waves.marker.location = [reshape(X,[],1),reshape(Y,[],1)]; % Marker Locations [X,Y]
clear('marker','distance','X','Y')
waves.marker.style = 3; % 1: Sphere, 2: Cube, 3: Frame.
waves.marker.size = 15; % Marker Size in Pixels
waves.marker.graphicColor = [1,0,0];



% % Regular Waves  
waves1 = waveClass('irregular');           % Initialize Wave Class and Specify Type       
% waves1 = waveClass('elevationImport');       % Initialize Wave Class and Specify Type  
% waves1.elevationFile = 'elevationData.mat';


waves1.height = 5.0;                     % Wave Height [m]
waves1.period = 2;                       % Wave Period [s]
waves1.spectrumType = 'PM';
waves1.direction = 0;
% waves1.spread = 1;

marker = 10;
distance = 5;
[X,Y] = meshgrid(-marker:distance:marker,-marker:distance:marker);
waves1.marker.location = [reshape(X,[],1),reshape(Y,[],1)]; % Marker Locations [X,Y]
clear('marker','distance','X','Y')
waves1.marker.style = 1; % 1: Sphere, 2: Cube, 3: Frame.
waves1.marker.size = 30; % Marker Size in Pixels
waves1.marker.graphicColor = [1,0,0];
waveGen(waves1,simu,bemFreq,bemWaterDepth) 
% w1 = waves1.waveAmpTime;


waves2 = waveClass('irregular');           % Initialize Wave Class and Specify Type                                 
waves2.height = 5;                     % Wave Height [m]
waves2.period = 3;                       % Wave Period [s]
waves2.spectrumType = 'PM';
waves2.direction = 90;
% waves2.spread = 1;

marker = 10;
distance = 5;
[X,Y] = meshgrid(-marker:distance:marker,-marker:distance:marker);
waves2.marker.location = [reshape(X,[],1),reshape(Y,[],1)]; % Marker Locations [X,Y]
clear('marker','distance','X','Y')
waves2.marker.style = 1; % 1: Sphere, 2: Cube, 3: Frame.
waves2.marker.size = 30; % Marker Size in Pixels
waves2.marker.graphicColor = [0,0,1];
waveGen(waves2,simu,bemFreq,bemWaterDepth) 
% w2 = waves2.waveAmpTime;

% waves3 = waveClass('irregular');           % Initialize Wave Class and Specify Type                                 
% waves3.height = .75;                     % Wave Height [m]
% waves3.period = 2;                       % Wave Period [s]
% waves3.spectrumType = 'PM';
% 
% 
% waveGen(waves3,simu,bemFreq,bemWaterDepth) 
% w3 = waves3.waveAmpTime;
% 
% waves4 = waveClass('irregular');           % Initialize Wave Class and Specify Type                                 
% waves4.height = 2;                     % Wave Height [m]
% waves4.period = 5;                       % Wave Period [s]
% waves4.spectrumType = 'PM';
% 
% 
% waveGen(waves4,simu,bemFreq,bemWaterDepth) 
% w4 = waves4.waveAmpTime;

waveGroup = [waves1;waves2];%;waves3;waves4];
% SwellandChop(:,1) = w1(:,1); 
% SwellandChop(:,2) = w1(:,2) ;%+ w2(:,2);% + w3(:,2) + w4(:,2);
% 
% 
% 
% save('SwellandChop.mat','SwellandChop')


%% Body Data
% Float
body(1) = bodyClass(sprintf('hydroData/rm3_p%d.h5',caseID));      
    % Create the body(1) Variable, Set Location of Hydrodynamic Data File 
    % and Body Number Within this File.   
    body(1).geometryFile = sprintf('geometry/float_p%d.stl',caseID);  
    % Location of Geomtry File
body(1).mass = 'equilibrium';                   
    % Body Mass. The 'equilibrium' Option Sets it to the Displaced Water 
    % Weight.
[Ix, Iy, Iz]    = MoIfloat(caseID);
body(1).inertia = [Ix, Iy, Iz]*rho;  % Moment of Inertia [kg*m^2]     
body(1).yaw.option = 1;
body(1).yaw.threshold = 1;
% Spar/Plate
body(2) = bodyClass(sprintf('hydroData/rm3_p%d.h5',caseID)); 
body(2).geometryFile = sprintf('geometry/spar_p%d.stl',caseID); 
body(2).mass = 'equilibrium';   
[Ix, Iy, Iz]    = MoIspar(caseID);
body(2).inertia = [Ix, Iy, Iz]*rho;
body(2).yaw.option = 1;
body(2).yaw.threshold = 1;
%% PTO and Constraint Parameters
% Floating (3DOF) Joint
constraint(1) = constraintClass('Constraint1'); % Initialize Constraint Class for Constraint1
constraint(1).location = [0 0 0];               % Constraint Location [m]

% Translational PTO
pto(1) = ptoClass('PTO1');                      % Initialize PTO Class for PTO1
pto(1).stiffness = 0;                           % PTO Stiffness [N/m]
pto(1).damping = 0;                       % PTO Damping [N/(m/s)]
pto(1).location = [0 0 0];