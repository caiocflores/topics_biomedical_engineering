%% data
close all; clear all; clc;

%% FILTROS IIR 
order = 8;
rp = 3; % dB
rs = 60; % dB
N = 512; % zero padding
fs = 2e3; 
fc = 200;
fc_norm = fc/(fs/2);

[b, a] = butter(order, fc_norm);
[H, f] = freqz(b, a, N, fs);
H = 20*log10(abs(H));
semilogx(f, H, 'k', 'DisplayName', 'Butter');
legend();
xlabel('Frequency - fs/2 (Hz)');
ylabel('X(f) (dB)');
axis([0 1e3 -80 0]);
hold on;

[b, a] = cheby1(order, rp, fc_norm); % Chebyshev Type I filter coefficients
[H, f] = freqz(b, a, N, fs); % Calculate complex spectrum
H = 20*log10(abs(H)); % Convert to magnitude in dB
semilogx(f, H, 'r', 'DisplayName', 'Cheby 1'); % Plot spectrum in dB vs. log freq
%legend('Cheby 1');
hold on;

%
[b, a] = cheby2(order, rs, fc_norm); % Chebyshev Type II filter coefficients
[H, f] = freqz(b, a ,N, fs); % Calculate complex spectrum
H = 20*log10(abs(H)); % Convert to magnitude in dB
semilogx(f, H, 'b', 'DisplayName', 'Cheby 2'); % Plot spectrum in dB vs. log freq
%legend('Cheby 2');
hold on;


%
[b,a] = ellip(order, rp, rs, fc_norm); % Elliptic filter coefficients
[H,f] = freqz(b, a, N, fs); % Calculate complex spectrum
H = 20*log10(abs(H)); % Convert to magnitude in dB
semilogx(f, H, 'g', 'DisplayName', 'Ellip'); % Plot spectrum in dB vs. log freq
%legend('Ellip');
title('IIR FIlters')

