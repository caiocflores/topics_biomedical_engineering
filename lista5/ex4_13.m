%% data 
clear all; close all; clc;

fs = 1e3; % sampling frequency 
N = 256; % number of points | zpadding = N-1
zp = N-1;
cutoff = 100; % cutoff freq
fc = cutoff/fs; % normalized fc by fs
f = (0:N-1)*fs/N; % frequency axis
L = 129; % size of the filters

%% windowed filters
k = -floor(L/2):-1; % window vector
b = sin(2*pi*fc*k)./(pi*k); % construct negative b[k]
b = [b 2*fc , fliplr(b)]; % flip for positive b[k]

% Rectangular
H_rect = fft(b, N);
H_rect_mag = abs(H_rect);

% Hamming 
n_ham = 1:L; % hamming window vector
ham = 0.54 - 0.46* cos ((2* pi*n_ham)/L); % hamming window eq
b_ham = b .* ham; % apply hamming window

H_ham = fft(b_ham, N); % spectrum of hamming window
H_ham_mag = abs(H_ham); % magnitude of the spectrum of hamming window

% Blackman-Harris 
n_black = -floor(L/2):floor(L/2); % bharris window vector
a_window = [0.35875 0.48829 0.14128 0.01168]; % bharris window coeffs
black = a_window (1) + a_window (2)*cos ((2* pi*n_black)/L) + ... 
        a_window (3)*cos (2*(2* pi*n_black)/L) + ...
        a_window (4)*cos (3*(2* pi*n_black)/L); % bharris window equation

b_black = b .* black; % apply bharris window

H_black = fft(b_black , N); % spectrum of bharris window
H_black_mag = abs(H_black); % magnitude of the spectrum of bharris window

% impulse reponse
impulse = [1 zeros(1,zp)]; % impulse vector (zero padding = 255)
y_rect = filter(b, 1, impulse);
y_ham = filter(b_ham , 1, impulse); % impulse response in the hamming window 
y_black = filter(b_black , 1, impulse); % impulse response in the bharris window
t = (0:N-1)/fs; % time axis

%% plots
subplot(2,1,1);
plot(t, y_rect, 'r', 'linewidth', 1.1, 'DisplayName', 'Rectangular'); % impulse response rectangular window filter
hold on;
plot(t, y_ham, 'g', 'linewidth', 1.1, 'DisplayName', 'Hamming'); % impulse response hamming window filter
hold on;
plot(t, y_black, 'k', 'linewidth', 1.1, 'DisplayName', 'Blackman-Harris'); % impulse response bharris window filter
title ('Impulse responses in different windowed filters');
legend(); 
xlabel ('Time (s)'); 
ylabel ('Amplitude'); 
xlim ([0 0.1]); % time axis limited in 0.1s

subplot(2,1,2);
diff = y_black - y_ham;
plot(t, diff, 'b', 'linewidth', 1.3); % diff of impulse responses
title ("Difference between Blackman-Harris and Hamming");
xlabel ("Time (s)");
ylabel ("Amplitude"); 
xlim ([0 0.1]); 

saveas(gcf, "ex4_13.png"); % save image