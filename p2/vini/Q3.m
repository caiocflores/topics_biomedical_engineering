clc; clear all; close all;
figure(1);
fs = 1000; % Frequencia de amostragem 
N = 5000; % Numero de amostras
ordem = 4; % Ordem do filtro
freqs = [100,200]/(fs/2); % Frequencias do filtro passa-bandas
[b,a] = butter(ordem,freqs,'bandpass') ; % Coeficientes do filtro
[H,f] = freqz(b,a,N,fs); % Espectro de magntiude
PS = abs((H.^2))/N; % Espectro de potência
plot(f,PS);
xlabel("Frequência (Hz)")
ylabel("PSD");
grid();
%%
figure(2);
N = 2048;
H = fft(b,N)./fft(a,N); % Equação 4.13
PS_f = abs((H.^2))/N; % Espectro de potência
f = (1:N)*fs/N; % Vetor de frequência
plot(f(1:N/2),PS_f(1:N/2)); 
xlabel("Frequência (Hz)")
ylabel("PSD");
grid();
%%
figure(3);
N = 50000; % Numero de amostras
x = randn(1,N); % Ruído para entrada
y = filtfilt(b,a,x); % Aplica ruído na entrado do SLIT
[rxy,lags] = xcorr(x,y,"coeff"); % Calcula correlação cruzada
nfft= 2^nextpow2(N); 
window = 128;
noverlap = 0.5*window;
[PS_w,f] = pwelch(rxy,window,noverlap,nfft,fs); %  Espectro de potência
plot(f,PS_w);
xlabel("Frequência (Hz)")
ylabel("PSD");
grid();
