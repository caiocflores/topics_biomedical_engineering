%% Subject f2o02 - Elderly 
clc; clear all; close all; 
warning('off');

% rri before the aligned step
load pf_f2o02_linear.mat % general rri 
open('patient')

rri_serie = detrend(patient.sig.ecg.rri.data);
time = patient.sig.ecg.rri.time;
subplot(1,2,1);

% PSD - AR Model: Original Signal
[Sxx, f] = pyulear(rri_serie, 16, 2048, 4);

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

figure(1);
subplot(2,1,1);
plot(time, rri_serie);
xlabel('Time (s)');
ylabel('Amplitude (u.a.)');
title('RRI Time Series (Raw) - f2o02');


subplot(2,1,2);
plot(f, Sxx, 'k', 'linewidth', 1.1);
xlim([0 0.4]);
%ylim([0 2e7]);
xlabel('Frequency (Hz)');
ylabel('Amplitude (u.a.)');
title('Power Density Spectral (PSD) - AR Model');

% intervalos VLF, LF e HF
hold on;
area(f(f<0.04), Sxx(f<0.04), 'FaceColor', 'g') % 0.04
hold on;

area(f(f>=0.04 & f<0.15), Sxx(f>=0.04 & f<0.15), 'FaceColor', 'r') % 0.04 and 0.15
hold on;

area(f(f>=0.15 & f<=0.4), Sxx(f>=0.15 & f<=0.4), 'FaceColor', 'b') % 0.4

saveas(gcf, 'raw_rri_f2o02.png');


% print areas
sprintf('Elderly Subject - f2o02: \n VLF  = %f \n LF   = %f \n HF   = %f', relat_area_VLF, ...
    relat_area_LF, relat_area_HF) % print areas

% preenchimento manual
% hold on;
% area(f(4:5), Sxx(4:5), 'FaceColor', 'r');
% hold on;
% area(f(13:14), Sxx(13:14), 'FaceColor', 'b');

