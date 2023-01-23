%% data
close all; clear all; clc;

N = 512; % number of points
fs = 1e3; % sampling frequency
Ts = 1/fs; 

%% transfer function
b = [0.42e-3 1.25e-3 1.25e-3 1.25e-3 -0.42e-3];
a = [1 -2.686 2.42 -0.73];
H = fft(b, N) ./ fft(a, N);

H_mag = 20*log10(abs(H)); % mag in dB
H_phase = unwrap(phase(H))*180/pi; % phase in deg

f = (0:N-1)*fs/N; % frequency axis
fnyq = 1:N/2;

%% plots 

% magnitude
subplot(3,1,1);
semilogx(f(fnyq), H_mag(fnyq), 'b', 'linewidth', 1.3);
title ("Frequency Response - Magnitude"); 
ylabel ("Magnitude (dB)"); 
xlabel ("Frequency (Hz)"); 
xlim([0 4e2]);
ylim ([ -80 10]) ; % yscale from -80 to 10 dB

% phase 
subplot(3,1,2);
semilogx(f(fnyq), H_phase(fnyq), 'b', 'linewidth', 1.3);
title ("Frequency Response - Phase"); 
ylabel ("Phase (degrees - º)"); 
xlabel ("Frequency (Hz)"); 
ylim ([ -80 10]) ; % yscale from -80 to 10 dB

% H[z] step response 

t = (0:N-1)*Ts;
s = ones(1, N);
sresp = filter(b, a, s); % insert the signal to the H[z] filter
subplot(3,1,3);
plot(t, sresp, 'b', 'linewidth', 1.3);
title ("Step Response"); 
ylabel ("Amplitude"); 
xlabel ("Time (s)"); 
xlim([0 0.5]);
ylim([0 1.3])

saveas(gcf, "ex4_6.png"); % save image
