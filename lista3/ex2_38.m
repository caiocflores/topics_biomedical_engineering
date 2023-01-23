clc; clear all; close all;

fs = 500;
TT = 5;
N = fs*TT; 
t = (0:N-1)/fs;
tau = 1;
h = exp(-t./tau); % impulse response

random = rand(1, N); % uniform random array
step = ones(1, N); % step array

y_r = conv(random, h); % random convolution
y_s = conv(step, h); % step convolution

subplot(1,2,1);
plot(t, h, 'k', 'DisplayName', 'Impulse Response'); % impulse response plot
axis([0 5 0 1]);
xlabel('Time (s)'); % x-axis name
ylabel('$h(t)$', 'Interpreter', 'latex', 'Fontsize', 16); hold on;  
legend();
grid();
title('Impulse response');

subplot(1,2,2);
plot(t, y_r(1:N), 'b', 'DisplayName', 'Random Response');
hold on;
plot(t, y_s(1:N), 'r', 'DisplayName', 'Step Response');
axis([0 5 0 500]);
xlabel('Time (s)'); % x-axis name
ylabel('$y_{r}(t)$, $y_{s}(t)$', 'Interpreter', 'latex', 'Fontsize', 16); 

legend();
grid();
title('Random and Step Responses');
sgtitle('Convolution');

saveas(gcf,sprintf('%s.png',mfilename));
