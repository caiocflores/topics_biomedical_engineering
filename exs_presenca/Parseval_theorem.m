clc;
close all;
% 1D case :  Sinusoidal function 
Fs=40;f=4;Ts=1/Fs;T=2;t=0:Ts:T-Ts;N=length(t);
x=2*cos(2*pi*f*t);
fx=fft(x);
figure,
subplot(1,2,1), area(t,abs(x.^2)),title(' Time Domain');
subplot(1,2,2),area(abs(fx)), title(' Frequency Domain');
E1_timedomain=sum(abs(x.^2))
E1_frequdomain=sum(abs(fx.^2))/N
%saveas(gcf, sprintf('%s.png', mfilename)); % save image

