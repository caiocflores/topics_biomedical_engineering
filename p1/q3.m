close all; clear variables; clc;

load hrv3.mat
%whos hrv3
%whos info

%% Questao 3a
figure(1) 
hrv3 = hrv3' % fazer a transposta
fs = 2.5; % frequencia de amostragem (Hz)
Ts = 1/fs; % periodo de amostragem 
N = length(hrv3); % num de amostras
t = (0:N-1)*Ts; % vetor de tempo
plot(t ,hrv3, 'linewidth', 2);
axis([0 t(end) min(hrv3) max(hrv3)]); % limites
ylabel('BPM')
xlabel('Tempo (s)');
title('Taxa de batimento cardíaco');
grid();


%% questao 3b
figure(2);
[cov, lags_cov] = axcor(hrv3 - mean(hrv3)); % autocovariancia 
plot(lags_cov, cov, 'linewidth', 2);
lags_cov = Ts*lags_cov; % Convertendo de amostra para segundos
axis([lags_cov(1) lags_cov(end) min(cov) max(cov)]); % Área de plotagem
ylabel('Valor de autocovariância')
xlabel('Lag (s)');
title('Autocovariância do sinal hrv3');
grid();
