% exercise 3.28 - Semmlow
clc; close all; clear all; 

fs = 1e3; % sampling frequency
N = 512; % array of samples
windows = 'Rectangular Blackman Hamming';
windows = string(split(windows)'); % windowed filter names
pos = 1; % counter used in for loop to plot 

for fig = 1:3
    [s, t] = sig_noise([280,300], -10, N); % signal with noise
    filters = [ones(1,N); blackman(N)'; hamming(N)']; % filters functions
    f = (0:N-1)*(fs/N); % frequency axis
    
    for i = 1:3
        subplot(3, 3, pos);
        sf = s.*filters(i,:); % appling filter
        S_mag = fft(sf); % fft 
        S_mag = (2/N)*abs(S_mag(1:N/2)); % fft normalized mag 
        plot(f(1:N/2), S_mag, 'linewidth', 1.1); % only positive freqs plot
        xlabel('Frequency (Hz)');
        ylabel('Magnitude Spectrum');
        grid on;
        title(sprintf('%s | N = %d', windows(i), N));
        pos = pos + 1; % ++counter to subplot 
    end
end

sgtitle('Comparison of windowed filters w/ N = 512', 'Interpreter', 'latex');
saveas(gcf, sprintf('%s.png', mfilename)); % save image

