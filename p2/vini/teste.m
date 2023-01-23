% normalizaca: (2/N)
% o N tira o vies do num de amostras e o 2 restringe para 1/2 do espectro

clc; clear all; close all;
load chirp.mat
fs = 1024; % Suposta frequÃªncia de amostragem
N = length(x); % Tamanho do vetor
f = (0:N-1)*fs/N; % Vetor de frequÃªncias
H_mag = abs(fft(x)); % Espectro de magnitude do sinal original 
H_mag_norm = (2/N)*abs(fft(x)); % Espectro de magnitude do sinal original 

subplot(2,1,1);
plot(f(1:N/2),H_mag(1:N/2));
title("Sinal original");
xlabel("Frequência (Hz)")
ylabel("x");

subplot(2,1,2);
plot(f(1:N/2),H_mag_norm(1:N/2));
title("Sinal original normalizado");
xlabel("Frequência (Hz)");
ylabel("x");


