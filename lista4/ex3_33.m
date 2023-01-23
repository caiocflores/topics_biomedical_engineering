clc; close all; clear all;
warning('off');
load eeg_data.mat % variable eeg

fs = 50; % sampling frequency
N = length(eeg); % length of egg signal
f = (0:N-1)*(fs/N); % frequency axis 

% empiric method to see a smooth spectrum with information of the peaks
Ns = N/14; % segment element ~ 58
unavg_ps = abs( fft(eeg).^2 )/N; % unaveraged tecnique
[avg_ps, f1] = pwelch(eeg, Ns, floor(0.99*Ns), [], fs); % averaged tecnique 

subplot(2,1,1);
plot(f(1:N/2), unavg_ps(1:N/2)); % only positive freqs (N/2)
xlabel('Frequency (Hz)');
ylabel('Power Spectrum');
title('\textbf{Standard Spectrum}', 'Interpreter', 'latex', 'Fontsize', 12);
set(gca, 'xlim', [0 25], 'ylim', [0 12e7]);
grid on;

subplot(2,1,2);
plot(f1, avg_ps);
xlabel('Frequency (Hz)');
ylabel('Power Spectrum');
title('\textbf{Periodogram}', 'Interpreter', 'latex', 'Fontsize', 12);
set(gca, 'xlim', [0 25], 'ylim', [0 12e5]);
grid on;

%saveas(gcf, sprintf('%s.png', mfilename)); % save image