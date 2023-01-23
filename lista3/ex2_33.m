clc; clear all; close all;

load prob2_33_data.mat % loading the signal the file
% there is one variable:
% x -> fs = 500 Hz

% signal x
N = 1580                        % number of points
fs = 500;                       % plot frequency
t = (0:N-1)/fs;                 % time vector, same length as signal x

% sine wave of 50 Hz
f = 50;                         % sine wave frequency
y = sin(2*pi*f*t);              % the sine wave
[rxy, lags] = axcor(x, y);      % cross correlation x and sin_wave


%ploting the sinusoidal wave
subplot(3,1,1);
plot(t, y, 'b'); 
xlabel('Time (s)');
ylabel('$y(t)$','Interpreter', 'latex', 'Fontsize', 10); 
title('\textbf{$sin(2\pi 50t)$}','Interpreter', 'latex', 'Fontsize', 10');
axis([0 3.25 -1 1]);
grid();

%ploting the signal x
subplot(3,1,2);
plot(t, x, 'k'); 
xlabel('Time (s)');
ylabel('$x(t)$','Interpreter', 'latex', 'Fontsize', 10); 
title('Signal x');
axis([0 3.25 -10 10]);
grid();

%ploting the cross correlation
subplot(3,1,3);
plot(lags/fs, rxy, 'r'); % plot cross correlation function      
hold on;
[rxy_max, max_lags] = max(rxy); % find max correlation
max_lags = lags(max_lags)/fs; % convert max shift to sec
plot(max_lags, rxy_max, '*k'); % plot max correlation
xlabel('Lags (s)');
ylabel('$r_{xy}(t)$','Interpreter', 'latex', 'Fontsize', 10); 
title(sprintf('Max corr: %s | Delay: %s', string(rxy_max), string(max_lags)));
axis([-3.25 3.25 -0.1 0.1]);
grid();
saveas(gcf,sprintf('%s.png',mfilename));

