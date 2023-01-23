%% Subject f2o02 - Elderly 
clc; clear all; close all; 
warning('off');

% subject f2002
load f2o03m.mat;
fs = 250; % Hz 
ts = 1/fs;

% ECG
ecg = val(2,:);
base = 0; gain = 409.6; ecg = (ecg-base)./gain;

tts = (60*60); % 1h
tts_5min = (5*60);
n_points = length(ecg);

n_points_5min = ((n_points*tts_5min)-1)/tts; % numero de pontos
t_points = ((7*n_points_5min:8*n_points_5min) * ts); % time vector

ecg = ecg(7*n_points_5min:8*n_points_5min); % 2100 - 2400 seg
%plot(t_points, ecg, 'r'); grid;
%xlabel('Tempo (s)');
%ylabel('ECG (mV)');
%title('f2o02 - ECG x Tempo');

% PSD - AR Model: Original Signal
figure(1)
[Sxx, f] = pyulear(ecg, 16, 256);

tot_area = trapz(Sxx);

vlf = zeros(size(Sxx));
lf = zeros(size(Sxx));
hf = zeros(size(Sxx));

for i = 1:length(Sxx)
    % very low frequency
    if (f(i) >= 0) && (f(i) < 0.04)
        vlf(i) = abs(Sxx(i));
    else
        vlf(i) = 0;
    end
    
    % low frequency
    if (f(i)>= 0.04) && (f(i) < 0.15)
        lf(i) = abs(Sxx(i));
    else
        lf(i) = 0;
    end

    % high frequency
    if (f(i)>=0.15) && (f(i) <= 0.4)
        hf(i) = abs(Sxx(i));
    else
        hf(i) = 0;
    end
end

relat_area_VLF = trapz(vlf)/tot_area*100
relat_area_LF = trapz(lf)/tot_area*100
relat_area_HF = trapz(hf)/tot_area*100

plot(f, Sxx);
hold on;
xlim([0 0.5])


