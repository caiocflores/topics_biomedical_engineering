Ts = 0.01; % Sample interval
%N = 500; % Number of points
TT = 3;
t = (0:Ts:TT); % Time vector
f = 1.5; % Frequency of sine wave 1
x = sin(2*pi*f*t); % Sine wave 1
y = cos(2*pi*f*t); % Sine wave 2
Corr = sum(x.*y); % Eq. 2.29
disp(Corr)