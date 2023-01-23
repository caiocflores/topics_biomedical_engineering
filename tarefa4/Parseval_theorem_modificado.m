%  Parseval theorem [1]:
%  -------------------
%
%  In this tutorial we show that the total energy of waveform X(t) (1D,2D and 3D) 
%  computed in time domain is equal to the total energy of the waveform's Fourier Transform
%  F(X(t))=x(f) computed in the frequency domain . 
% Reference :
%[1] :  Parseval des Chênes, Marc-Antoine "Mémoire sur les séries et sur
%       l'intégration complète d'une équation aux différences partielles
%       linéaire du second ordre,à coefficients constants" Paris 1799.
%
% (c)  KHMOU Youssef,  Applied Mathematics 
close all;
% 1D case :  Sinusoidal function 
Fs=40; % sampling frequency
f=4; % sinusoid frequency
Ts=1/Fs; % samoling period
T=2; % specific value of time
t=0:Ts:T-Ts; % time axis
N=length(t); % number of points
x=2*cos(2*pi*f*t);

f = (0:N-1)*Fs/N; % frequency axis
fx=(2/N)*fft(x); % fourier transform of x
fs_mag=abs(fx);

figure,
subplot(1,2,1), area(t,abs(x.^2)),title(' Time Domain');
subplot(1,2,2),area(f(1:N/2),fs_mag(1:N/2)), title(' Frequency Domain');

% method 1
E1_timedomain = sum(abs(x.^2))
E1_frequdomain = sum(abs(fx.^2))/N

% method 2
E2_timedomain = sum(abs(x.^2))/N
E2_frequdomain = sum(abs(fx.^2))/N^2
saveas(gcf, sprintf('%s.png', mfilename)); % save image


disp('methods')
out = sprintf('E1_timed: %.4f, E1_freqd: %.4f', E1_timedomain, E1_frequdomain);
disp(out)
out = sprintf('E2_timed: %.4f, E2_freqd: %.4f', E2_timedomain, E2_frequdomain);
disp(out)