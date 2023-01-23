clc; clear all; close all;
load chirp.mat
fs = 1024; % Suposta frequÃªncia de amostragem
N = length(x); % Tamanho do vetor
f = (0:N-1)*fs/N; % Vetor de frequÃªncias
H_mag = abs(fft(x)); % Espectro de magnitude do sinal original 
subplot(2,1,1);
plot(f(1:N/2),H_mag(1:N/2));
title("Sinal original");
xlabel("Frequência (Hz)")
ylabel("x");

x_interp = zeros(1,N/2);
count = 0;
for idx = (1:N)
	if rem(idx,2) == 1
		x_interp(count+1) = x(idx);
		count = count + 1;
		
	end
	if count == N/2
		break
	end
end

fs = 512; % Nova frequencia de amostragem
N = length(x_interp); % Tamanho do vetor
f = (0:N-1)*fs/N; % Vetor de frequÃªncias
H_mag = abs(fft(x)); % Espectro de magnitude do sinal interpolado 
subplot(2,1,2);
plot(f(1:N/2),H_mag(1:N/2));
title("Sinal interpolado");
xlabel("Frequência (Hz)")
ylabel("x interpolado");
