clc; close all; clear all;

fs = 1024; % sampling frequency
N = 1024; % number of points
A = 0.5; % amplitude

%% sawtooth wave

% sawtooth time domain
f1 = 2; % freq of the signal
t = (0:N-1)/fs; % time axis
s1 = A*sawtooth(2*pi*f1*t); % signal

% signal reconstructed
% fft 
c = 40; % number of points to reconstruction 
sf = (2/N)*fft(s1); % fft
S_mag = abs(sf); % fft mag
f = (0:N-1)*(fs/N); % frequency axis
S_phase = unwrap(angle(sf)); % fft phase

r1 = zeros(1,N); % array of zeros
r1_dc = S_mag(1)/2; % dc value
r1 = r1_dc + r1;  % add dc value

for m = 2:c % 2:c because S_mag(1) is a dc term 
    r1 = r1 + S_mag(m)*cos(2*pi*f(m)*t + S_phase(m)); % Eq. 3.15
end

plot(t, s1, 'k', 'linewidth', 1, 'DisplayName', 'Signal'); 
hold on;
plot(t, r1, 'b', 'linewidth', 1, 'DisplayName', 'Reconstructed Signal');
xlabel('Time (s)');
ylabel('$s(t)$', 'Interpreter', 'latex');

legend('Orientation','horizontal','Box','on','Location','southoutside');
title('Signal reconstruction of $s(t)$ w/ 24 components', 'Interpreter', 'latex');
grid on;

%saveas(gcf, sprintf('%s.png', mfilename)); % save image
