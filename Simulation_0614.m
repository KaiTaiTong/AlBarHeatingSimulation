% ENPH 257 Heat Distribution Code - Lab 1 Plotting Temp vs. Time for each different positions on the rod
% Author: Alan Tong
% Date: June 14,2017
clear; close all, nfig = 0;

% Declare variables
% *************************[Please adjust accordingly]*********************
CSVFileName = ('Modulated Temperature Data Vertical Setup Jun 12th.csv'); % CSV File for the data
UpLimitofTemp_Axis = 45; % For setting the maximum Temp on the axis for graph in C
totaltime = 2345; % Total Time to run the simulation
time_for_offset = 150; % Time from 0 to whenever we first turned on the power in s
first_time_off = 606; % First time to turn off the power in s
second_time_on = 1186; % Second time to turn on the power in s 
second_time_off = 1800; % Second time to turn off the power in s

third_time_on = 2345; % Third time to turn on the power in s 
third_time_off = 3000; % Third time to turn off the power in s
% *************************[Please adjust accordingly]*********************

%*******************[Fixed Constant Remain Unchanged]******************
StefanBoltzC = 5.67*10^(-8); % Stefan-Boltzmann Constant for radiation in W/m^2/K^4
Length = 0.3; % Length of the Rod in m
Incrementx = 0.01; % Increment of length of the rod in m
Incrementt = 1; % Increment of time of the rod in s (Should not change too badly)

IncrementSensorPosition = 5; % Every ~5cm will be placed with a temperature sensor
sensorposition1 = 1; % The position of first sensor in the array
sensorposition2 = sensorposition1 + IncrementSensorPosition;
sensorposition3 = sensorposition2 + IncrementSensorPosition;
sensorposition4 = sensorposition3 + IncrementSensorPosition;
sensorposition5 = sensorposition4 + IncrementSensorPosition;
sensorposition6 = sensorposition5 + IncrementSensorPosition;

placement1 = 1;
placement2 = 1;
placement3 = 1;
placement4 = 1;
placement5 = 1;
placement6 = 1;
%*******************[Fixed Constant Remain Unchanged]******************

%*******************[Parameter to be Adjusted]*******************
K = 96.3; % Thermal Conductivity of the rod W/m/K
Kc = 11; % Heat Transfer or Convection Coefficient in W/m^2/K
c = 950; % Heat Capacity of the rod J/kg/K
rho = 2709; % Density of the rod in kg/m^3
InitialTemp = 21.87; % Initial Temperature at xo in C
Tamb = 21.91; % Surrounding Temperature in C
RestInitialTemp = Tamb; % Besides the heat source, the rest of the rod's temp in C
Porigin = 5; % Not the actual Input power, but with efficiency %
Pin = Porigin; % Input power to xo of the rod in W
radius = 1.123*10^(-2); % Radius of the surface in m (essentially we need the surface area, just be careful)
e = 0.3; % Emissivity of the surface of an object 0 to 1, 0 is the perfect reflector and 1 for perfect black body.
%*******************[Parameter to be Adjusted]*******************

% Setting up vectors and initializating listoftemp to be T(x0) =
% InitialTemp, and T(rest) = RestInitialTemp, which is usually room temp
xo = 0;
xf = Length;
x = linspace(xo,xf,Length/Incrementx);

listoftemp = zeros(1,(Length/Incrementx));
listoftemp(1,1) = InitialTemp;
listoftemp(1,2:end) = RestInitialTemp;

% Initializing position of each holes on the rod
t = 0;
storefirst = zeros(1,1); % Very first position on the rod, where we heat up the rod
storesecond = zeros(1,1); % x0 position on the rod, where the first hole is
storethird = zeros(1,1); % x1 second hole
storefourth = zeros(1,1); % x2 third hole
storefifth = zeros(1,1); % x3 fourth hole
storesixth = zeros(1,1); % x4 fifth hole

uplimitofi = Length/Incrementx; % Number of x positions in the simulation
startingofi = uplimitofi;

% Initializing total waiting time
timeline = linspace(0,totaltime,totaltime/Incrementt);


while t < totaltime
    
    if t == first_time_off
        Pin = 0; % Time Control
        Kc = 6;
    end
    if t == second_time_on
        Pin = Porigin;
        Kc = 9.5;
    end
    if t == second_time_off
        Pin = 0; % Time Control
        Kc = 7;
    end


    % As previous version, each dt when we measure the temp at x of the
    % rod, temp at ALL x along the rod has been updated. Therefore, here i
    % is running from the first position i=1, xo to a fixed value,
    % startingofi which is the uplimitofi = Length/Incrementx.
    for i = 1:startingofi
        
%          Plotting the Graph dynamically (Commented since we probably just need the steady state)
%          hold on;
%          xlabel ('x of the Rod (m)'), ylabel ('Temperature (C)');
%          h = plot(x,listoftemp,'b+');
%          axis([0 Length RestInitialTemp 60]); % Setting axis domain and range
%          pause(0.001); % Adjust according to the purpose
%          delete(h);
        
        % When i hits the last position x along the rod, we use the equation dTend/dt = k((Tend-1)-Tend)/(c*rho*(dx)^2)
        % Here we also consider the Ploss (area of side of the circle and circumference)
        if i == uplimitofi
            listoftemp(1,i) = listoftemp(1,i) + Incrementt*K*(listoftemp(1,i-1) - listoftemp(1,i))/(c*rho*Incrementx^2);
            Ploss = ((2*pi*radius+pi*radius^2)*Incrementx*Kc*(listoftemp(1,i)-Tamb)+(2*pi*radius+pi*radius^2)*Incrementx*e*(StefanBoltzC)*((listoftemp(1,i)+273)^4 - (Tamb+273)^4));
            
            % When i is at the beginning of the rod where xo is, we apply the euqation of cooling -> dT1/dt = -k*(T1-T2)/(c*rho*(dx)^2)
            % Here we also consider the Ploss (area of side of the circle and circumference)
        elseif i == 1
            listoftemp(1,1) = listoftemp(1,1) - Incrementt*K*(listoftemp(1,1) - listoftemp(1,1+1))/(c*rho*Incrementx^2) + Pin*Incrementt/(c*rho*pi*Incrementx*(radius^2));
            Ploss = ((2*pi*radius + pi*radius^2)*Incrementx*Kc*(listoftemp(1,i)-Tamb)+(2*pi*radius+pi*radius^2)*Incrementx*e*(StefanBoltzC)*((listoftemp(1,i)+273)^4 - (Tamb+273)^4));
            
            % Formula is Tn = Tn + dt*(k/c*rho)*d^2T/dt^2, where d^2T/dt^2 = ((Tn-1)+ T(n+1) - 2T(n))/(dx)^2 for heat transfer within the rod (same as version 1)
            % For Ploss in the middle of the rod, we do not consider area of the x-section, only circumference
        else
            listoftemp(1,i) = listoftemp(1,i) + Incrementt*((K/(c*rho))*(listoftemp(1,i-1)-2*listoftemp(1,i)+listoftemp(1,1+i))/(Incrementx^2));
            Ploss = (2*pi*radius*Incrementx*Kc*(listoftemp(1,i)-Tamb)+2*pi*radius*Incrementx*e*(StefanBoltzC)*((listoftemp(1,i)+273)^4 - (Tamb+273)^4));
            
        end  
        % This euqaiton is common for all position x, where Tprev - Ploss = Tnow
        listoftemp(1,i) = listoftemp(1,i) - Ploss*Incrementt/(c*rho*pi*radius^2*Incrementx);
        
         if i == sensorposition1
             storefirst(1,placement1) = listoftemp(1,i);
             placement1 = placement1 + 1;
         end
         if i == sensorposition2
             storesecond(1,placement2) = listoftemp(1,i);
             placement2 = placement2 + 1;
         end
         if i == sensorposition3
             storethird(1,placement3) = listoftemp(1,i);
             placement3 = placement3 + 1; 
         end
         if i == sensorposition4
             storefourth(1,placement4) = listoftemp(1,i);
             placement4 = placement4 + 1;  
         end
         if i == sensorposition5
             storefifth(1,placement5) = listoftemp(1,i);
             placement5 = placement5 + 1;   
         end
         if i == sensorposition6
             storesixth(1,placement6) = listoftemp(1,i);
             placement6 = placement6 + 1;   
         end

    end
    t = t + Incrementt;
    
end

% Read File
M = csvread(CSVFileName,1,0);
% After reading the data, transpose the data and save as vectors
timeline_actual = (M(1:end,1) - time_for_offset)';

% Calculating the Offset value for each position of the rod
average_of_0 = sum((M(1:time_for_offset,3)'))/time_for_offset;
average_of_1 = sum((M(1:time_for_offset,5)'))/time_for_offset;
average_of_2 = sum((M(1:time_for_offset,7)'))/time_for_offset;
average_of_3 = sum((M(1:time_for_offset,9)'))/time_for_offset;
average_of_4 = sum((M(1:time_for_offset,11)'))/time_for_offset;

average_of_all = (average_of_0 + average_of_1 + average_of_2 + average_of_3 + average_of_4)/5;

offset0 = average_of_0 - average_of_all;
offset1 = average_of_1 - average_of_all;
offset2 = average_of_2 - average_of_all;
offset3 = average_of_3 - average_of_all;
offset4 = average_of_4 - average_of_all;

% With Offest
%  x0_actual = M(1:end,3)' - offset0;
%  x1_actual = M(1:end,5)' - offset1;
%  x2_actual = M(1:end,7)' - offset2;
%  x3_actual = M(1:end,9)' - offset3;
%  x4_actual = M(1:end,11)' - offset4;

% Without Offset
x0_actual = M(1:end,3)' ;
x1_actual = M(1:end,5)' ;
x2_actual = M(1:end,7)' ;
x3_actual = M(1:end,9)' ;
x4_actual = M(1:end,11)' ;

hold on;
xlabel ('Time (s)'), ylabel ('Temperature (C)');
title ('Lab: Temperature of positions of holes on Al rod vs. Time');
plot(timeline,storesecond,'b',timeline,storethird,'g',timeline,storefourth,'r',timeline,storefifth,'c',timeline,storesixth,'m');
legend('x0 => 5.02cm','x1 => 10.00cm','x2 => 14.95cm','x3 => 20.08 cm','x4 => 25.09 cm')

% err = 0.3*ones(size(storesecond));
% errorbar(timeline, storesecond, err,'r');
% errorbar(timeline, storethird, err,'r');
% errorbar(timeline, storefourth, err,'r');
% errorbar(timeline, storefifth, err,'r');
% errorbar(timeline, storesixth, err,'r');

plot(timeline_actual, x0_actual,'b.');
plot(timeline_actual, x1_actual,'g.');
plot(timeline_actual, x2_actual,'r.');
plot(timeline_actual, x3_actual,'c.');
plot(timeline_actual, x4_actual,'m.');
grid on;

txt = texlabel('30cm Aluminum Bar (Vertical)');
t = text(1500,25,txt);
t.FontSize = 11;

axis([0 totaltime Tamb UpLimitofTemp_Axis ]);