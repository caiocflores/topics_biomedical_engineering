%% dados
close all; clear all; clc;

order = 4;
fc1 = 150; % fcorte 1
fc2 = 300; % fcorte 2
fs = 1e3; % famostragem
fc1_norm = fc1/(fs/2); % fcorte 1 norm
fc2_norm = fc2/(fs/2); % fcorte 2 norm
N = 5e3; % num de pontos

[b, a] = butter(order, [fc1_norm, fc2_norm]);
[H, f] = freqz(b, a, N, fs);

Ps = abs((H.^2))/N; % espectro de potencia
plot(f, Ps);
xlabel("Frequência (Hz)")
ylabel("PSD");
grid();
saveas(gcf, 'q1_item_a1.png');

%% 1a 
figure(2);
N = 5e3; % num amostras p/ ruido
x = randn(1, N); % ruido branco 
y = filtfilt(b, a, x); % aplicando ruido na entrada do SLIT
nfft = 2^nextpow2(N); 
window = 128;
noverlap = 0.5*window;
[PS_w, f] = pwelch(y, window, noverlap, nfft, fs); %  Espectro de potÃªncia
plot(f, PS_w);
xlabel("Frequência (Hz)")
ylabel("PSD");
grid();
saveas(gcf, 'q1_item_a2.png');

%% 1b
figure(3);
N = 2048;
[rxy, lags] = xcorr(x, y, "coeff"); % calcula correlacao cruzada
PS_f = (2/N^2)*abs((fft(rxy)).^2); % espectro de potencia
%f = (0:N-1)*(fs/N); % vetor de frequencia

plot(lags, PS_f); 
xlabel("Lags")
ylabel("PSD");
grid();
saveas(gcf, 'q1_item_b.png');