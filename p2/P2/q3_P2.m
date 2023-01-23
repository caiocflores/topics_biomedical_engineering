%% dados
clear all; close all; clc;

N = 256;
freq = 300;
SNR = -12;
fs = 1e3;

%% 3a

x = sig_noise(freq, SNR, N); % sinal
f = (0:N-1)*(fs/N); % eixo f
Ps_x = (2/N)*abs((fft(x)).^2); % espectro de potencia
plot(f(1:N/2), Ps_x(1:N/2), 'b', 'linewidth', 1);
xlabel('Frequência (Hz)');
ylabel('Ps(f)');
grid();
title('Espectro de potência do sinal');
saveas(gcf, 'q3_item_a.png');

%% 3b

[rxx, lags] = xcorr(x, 'coeff');
Ps_xx = (2/N^2)*abs(fft(rxx).^2);
lags = lags(lags>0);
Ps_xx = Ps_xx(lags>0);

figure(2);
plot(lags, Ps_xx, 'b', 'linewidth', 1);
xlabel('Lags)');
ylabel('Ps(f)');
grid();
title('Espectro de potência via r_{xy}');
saveas(gcf, 'q3_item_b.png');


