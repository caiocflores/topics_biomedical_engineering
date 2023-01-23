%% data 
clear all; close all; clc; 
load Resp_noise1.mat; % load the file

fs = 125; % Hz
Ts = 1/fs;
resp = resp; % noise free-signal
resp_noise1 = resp_noise1; % noisy signal
N = length(resp);
order = 14;
fc_orig = 0.15*(fs/2);
fc = fc_orig / (fs/2);

t = (0:N-1)*Ts; % time axis 
f = (0:N-1)*fs/N; % frequency axis 
fnyq = 1:N/2; % Nyquist frequency

%% butterworth filter
[b, a] = butter(order, fc);

% causal IIR filter
x_filter = filter(b, a, resp_noise1); % filter() func

% noncausal IIR filter
x_filtfilt = filtfilt(b, a, resp_noise1); % filter with no delay

%% plots

% magnitude spectrum of butterworth filter 
H_filt_mag = abs(fft(b, N) ./ fft(a, N));
figure(1);
plot(f(fnyq), H_filt_mag(fnyq), 'b', 'linewidth', 1.3);
title ('Butterworth Filter');
xlabel ('Frequency (Hz)'); 
ylabel ('Magnitude'); 
xlim([0 62]);
saveas(gcf, 'fig1_ex4_24.png')


% original signal - noisy signal
figure(2);
subplot(3,1,1);
plot(t, resp_noise1, 'b', 'linewidth', 1.3);
title ('Signal - Noisy Original');
xlabel ('Time (s)'); 
ylabel ('Amplitude');
xlim([0 5.5]);

% original signal - noise-free signal
figure(2);
subplot(3,1,2);
plot(t, resp, 'b', 'linewidth', 1.3);
title ('Signal - Noise-free');
xlabel ('Time (s)'); 
ylabel ('Amplitude'); 
xlim([0 5.5]);

% signal filtered with filter() function -- causal IIR filter
subplot(3,1,3);
plot(t, x_filter, 'b', 'linewidth', 1.3, 'DisplayName', 'filter()');
title ('Signal Filtered - filter() - causal');
xlabel ('Time (s)'); 
ylabel ('Amplitude');
hold on; % plot in the same graph

% signal filtered with filtfilt() function -- noncausal IIR filter
plot(t, x_filtfilt, 'r', 'linewidth', 1.3, 'DisplayName', 'filtfilt()'); 
title ('Signal Filtered - filtfilt() - noncausal');
xlabel ('Time (s)'); 
ylabel ('Amplitude');
xlim([0 5.5]);
legend();

saveas(gcf, 'fig2_ex4_24.png')