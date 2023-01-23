clc; clear all; close all; 
warning('off');

% subject f2o02
load f2o02m.mat;
fs2 = 250; % Hz
ts2 = 1/fs2;

% ECG
ecg = val(2,:);
base=0; gain=409.6; ecg = (ecg-base)./gain;

% TIME CONVERSOR
% time vector for 5 min = 300 sec
% downloaded 1h of data from PhysioNet
tts = (60*60); % 1h00
tts_5min = (5*60);
n_points = length(ecg);

% POINTS CONVERSOR
% to calculate the number of points in 300sec
% proportion:
% tts -- n_points
% 300 -- n_points_5min
n_points_5min = ((n_points*tts_5min)-1)/tts;

t_points = ((7*n_points_5min:8*n_points_5min) * ts2); % time vector
ecg = ecg(7*n_points_5min:8*n_points_5min); % 2100 - 2400 seg

% uncomment to see the plot if necessary
% plot(t_points, ecg, 'r'); grid;
% xlabel('Tempo (s)');
% ylabel('ECG (mV)');
% title('f2o02 - ECG x Tempo');