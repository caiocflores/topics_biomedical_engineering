clc; clear all; close all;
load ar_compare.mat;
figure(1);
fs = 1000; % Frequencia de amostragem
N = length(x); % Tamanho do vetor
PS_f = abs((fft(x)).^2)/N; % Espectro de potência Fourier
f = (0:N-1)*fs/N; % Vetor de frequências
plot(f(1:N/2),PS_f(1:N/2)); 
xlabel("Frequência (Hz)")
ylabel("x");
title("FFT");

figure(2);
[PS_w f] = pwelch(x,N,N-1,N,fs); % Espectro de potência Welch
plot(f,PS_w);
xlabel("Frequência (Hz)")
ylabel("x");
title("Welch");

figure(3);
p_ordens = [9,15,23,32,64]; % vetor com as ordens
for idx = (1:5)
	subplot(5,1,idx);
	p = p_ordens(idx); 
	[Pxx, freq] = pburg(x,p,N,fs); % Espectro de potência AR
	plot(freq,Pxx);
	title(sprintf('p = %d',p))
end

xlabel("Frequência (Hz)")
ylabel("x");
sgtitle("AR");
