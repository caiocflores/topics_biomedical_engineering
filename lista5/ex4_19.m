%% dados
clear all; close all; clc;

load ECG_60Hz_data.mat; % load the file
fs = 250; % Hz
Ts = 1/fs;
N = length(x); 
bandwidth = 5;
center = 60;
order = 27;

t = (0:N-1)*Ts; % time axis 

f = (0:N-1)*fs/N; % frequency axis 
fnyq = (1:N/2); % Nyquist frequency

%% filtering process

fc1 = (center - bandwidth)/(fs/2); % normalized fc1 -> fc1/(fs/2)
fc2 = (center + bandwidth)/(fs/2); % normalized fc2 -> fc2/(fs/2)
fc1_orig = fc1/2; % only fc1/fs
fc2_orig = fc2/2; % only fc2/fs

% rectangular stopband filter
k = -floor(order/2):-1;
b1_fc1 = sin(2*pi*fc1_orig*k)./(pi*k); % first fc - fc1
b1_fc2 = sin(2*pi*fc2_orig*k)./(pi*k); % second fc - fc2
b1 = (b1_fc1 - b1_fc2); % construct negative b[k]
b1 = [b1 1 - 2*(fc2_orig - fc1_orig), fliplr(b1)]; % flip for positive b[k]
%b1 = b1 .* hamming(order)'; % hamming windowed coeffs
Hb1_m = abs(fft(b1, N)); % Filter Magnitude Spectrum


% fir rectangular bandstop 
figure(1);
subplot(2,1,1);
plot(f(fnyq), Hb1_m(fnyq), 'b', 'linewidth', 1.3);
title ('FIR filter - Rectangular Bandstop');
xlabel ('Time (s)'); 
ylabel ('Amplitude');
xlim([0 120]);

% fir1() function
subplot(2,1,2)
b2 = fir1(order, [fc1 fc2], 'stop'); % stopband filter
Hb2 = fft(b2, N);
Hb2_m = abs(Hb2);
plot(f(fnyq), Hb2_m(fnyq), 'b', 'linewidth', 1.3);
title ('FIR filter - fir1() function');
xlabel ('Time (s)'); 
ylabel ('Amplitude'); 
xlim([0 120]);
saveas(gcf, 'fig1_ex4_19.png')

% signal before filtering
figure(2);
subplot(3,1,1)
plot(t, x, 'b', 'linewidth', 1.3);
title ('ECG signal before filtering');
xlabel ('Time (s)'); 
ylabel ('Amplitude'); 


% signal after filtering
subplot(3,1,2);
x_filt_b1 = filter(b1, 1, x); % rect window
plot(t, x_filt_b1, 'b', 'linewidth', 1.3);
title ('ECG signal filtered - Rectangular Bandstop');
xlabel ('Time (s)'); 
ylabel ('Amplitude'); 

subplot(3,1,3);
x_filt_b2 = filtfilt(b2, 1, x); % fir1() function
plot(t, x_filt_b2, 'b', 'linewidth', 1.3);
title ('ECG signal filtered - fir() function');
xlabel ('Time (s)'); 
ylabel ('Amplitude'); 

saveas(gcf, 'fig2_ex4_19.png')