clc; close all; clear all;

% sujeito f2o02
load f2o02m.mat
whos;
fs = 250;
ts = 1/fs;

% respiracao
resp = val(1,:);

% ECG
ecg = val(2,:); 

% conversao para escala correta verificando valores de base e da ganho do
% arquivo .info
base=0; gain=819.2; ecg=(ecg-base)./gain;

resp =(resp-base)./gain; figure; 

% CONVERSAO DE TEMPO
% vetor de tempo para 5 min = 300 segundos
% baixou-se 1h de dados do PhysioNet
% em 1h, h? 10^6 pontos
total_1hseg = (60*60) + (6*60) + (40);
total_5minseg = (5*60);
n_points = 1e6;

% CONVERSAO DE PONTOS
% para calcular a qtde de pontos em 5min/300s
% fez-se uma proporcao:
% 1h (3600s) -- 1e6
% 300 -- n_points_5min
n_points_5min = ((n_points*total_5minseg)-1)/total_1hseg;
t_points = ((n_points_5min:2*n_points_5min) * ts);

% TAREFA1
% plotar dados da resp e ECG

% resp
subplot(2,1,2);
resp = val(1, n_points_5min:2*n_points_5min);
plot(t_points, resp, 'g'); grid;
xlabel('Tempo (s)');
ylabel('Resp (mV)');
title('f2o02 - Resp x Tempo');

% ecg
subplot(2,1,1);
ecg = val(2, n_points_5min:2*n_points_5min);
plot(t_points, ecg, 'r'); grid;
xlabel('Tempo (s)');
ylabel('ECG (mV)');
title('f2o02 - ECG x Tempo');
