%% data preprocessing
clc; clear all; close all; 
warning('off');

% obs.: not necessary to apply filters

% subject f2y02
load f2y02m.mat;
fs = 333; % Hz 
ts = 1/fs;

% ECG
ecg = val(2,:);
base = 0; gain = 819.2; ecg = (ecg-base)./gain;

% BP
bp = val(3,:);
base = 0; gain = 819.2; bp =(bp-base)./gain;

% TIME CONVERSOR
% time vector for 5 min = 300 sec
% downloaded 1h (50min3sec) of data from PhysioNet
tts = (50*60) + 3; % 50m e 3s
tts_5min = (5*60);
n_points = length(ecg);

% POINTS CONVERSOR
% to calculate the number of points in 300sec
% proportion:
% tts -- n_points
% 300 -- n_points_5min
n_points_5min = ((n_points*tts_5min)-1)/tts; % numero de pontos

t_points = ((7*n_points_5min:8*n_points_5min) * ts); % time vector

%% ECG plot
ecg = ecg(7*n_points_5min:8*n_points_5min); % 2100 - 2400 seg

% uncomment to see the plot if necessary
plot(t_points, ecg, 'r'); grid;
xlabel('Tempo (s)');
ylabel('ECG (mV)');
title('f2y02 - ECG x Tempo');

%% BP plot
% BP during 300 seconds
bp = bp(7*n_points_5min:8*n_points_5min); % 2100 - 2400 seg

% uncomment to see the plot if necessary
figure(2);
plot(t_points, bp, 'b'); grid;
xlabel('Tempo (s)');
ylabel('BP (mV)');
title('f2y02 - BP x Tempo');
