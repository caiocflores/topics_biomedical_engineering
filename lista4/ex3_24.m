clc; close all; clear all;

N = 512; % number of points - gaussian noise array
fs = 200; % sampling frequency
gn = randn(1,N); % gaussian noise array

N1 = 256; % Welch length 1
N2 = 32; % Welch length 2

% PS(f) = |X(f)|^2 
[gn_fft1, f1] = pwelch(gn, N1, N1-1, [], fs); % periodogram1
[gn_fft2, f2] = pwelch(gn, N2, N2-1, [], fs); % periodogram2

subplot(2,1,1);
plot(f1, gn_fft1, 'linewidth', 1); % plot periodogram1
xlabel('Frequency (Hz)');
ylabel('$|P_{s}(f)|$', 'Interpreter', 'latex', 'Fontsize', 12);
title('\textbf{Periodogram N = 256}', 'Interpreter', 'latex', 'Fontsize', 12);
grid on;

subplot(2,1,2);
plot(f2, gn_fft2, 'linewidth', 1); % plot periodogram2
xlabel('Frequency (Hz)');
ylabel('$|P_{s}(f)|$', 'Interpreter', 'latex', 'Fontsize', 12);
title('\textbf{Periodogram N = 32}', 'Interpreter', 'latex', 'Fontsize', 12);
grid on;

saveas(gcf, sprintf('%s.png', mfilename)); % save image
