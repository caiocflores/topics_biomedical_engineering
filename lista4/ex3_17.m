% exercise 3.17 - Semmlow 
clc; close all; clear all;

load short.mat % variable x -> 32 points
fs = 1; % sampling frequency 
N = length(x); % number of points
f = (0:N-1)*(fs/N); % frequency axis without zero padding

N2 = 256; % number points 0 (zero padding)
f2 = (0:N2-1)*(fs/N2); % frequency axis w/ zero padding

X_fft = fft(x); % fft
X_mag = (2/N)*abs(X_fft(1:N/2)); % fft normalized mag

X_fft_zp = fft(x,N2); % w/ zero padding fft 
X_mag_zp = (2/N)*abs(X_fft_zp(1:N2/2)); % w/  zero padding fft mag

subplot(2,1,1);
plot(f(1:N/2), X_mag, 'b', 'linewidth', 2, 'DisplayName', 'No padding'); % fft mag
set(gca, 'xlim', [0 0.5], 'ylim', [0 0.06]);
xlabel('Frequency (Hz)'); 
ylabel('Amplitude'); 
legend('Orientation','vertical','Box','on','Location','southoutside');
grid on;

subplot(2,1,2);
plot(f2(1:N2/2), X_mag_zp, 'k', 'linewidth', 2, 'DisplayName', '256 padding'); % w/ zero padding fft mag
set(gca, 'xlim', [0 0.5], 'ylim', [0 0.06]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
legend('Orientation','vertical','Box','on','Location','southoutside');
grid on;

sgtitle('Zero Padding Effect', 'Interpreter', 'latex');
saveas(gcf, sprintf('%s.png', mfilename)); % save image

