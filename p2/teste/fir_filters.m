%% Ex 4.10 Design a double bandpass filter.
%
fs = 1000; % Sample frequency
N = 2000; % Number of points
L = 65; % Filter order
fl1 = 50/(fs/2); % Define cutoff freqs: first peak low
fh1 = 100/(fs/2); % First peak high freq.
fl2 = 200/(fs/2); % Second peak low cutoff
fh2 = 250/(fs/2); % Second peak high cutoff
%
x = sig_noise([75 225],-20,N); % Generate noisy signal
%
% Design filter Construct frequency and gain vectors
f = [0,fl1,fl1,fh1,fh1,fl2,fl2,fh2,fh2,1]; % Frequency vector
G = [0, 0, 1, 1, 0, 0, 1, 1, 0, 0]; % Gain vector
%
subplot(2,1,1);
plot(f,G); % Plot the desired response
title('Original Signal')
%% Example 4.10 (continued)
%
b = fir2(L,f,G); % Construct filter
[H,f] = freqz(b,1,512,fs); % Calculate filter response
%
subplot(2,1,2);
plot(f,abs(H)); % Plot filter freq. response
title('Filtered FIR')
........labels......
%
y = filter(b,1,x); % Apply filter
Xf = abs(fft(x)); % Compute magnitude spectra of unfiltered
Yf = abs(fft(y)); % and filtered data