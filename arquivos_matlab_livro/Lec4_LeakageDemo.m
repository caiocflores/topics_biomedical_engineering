% LeakageDemo

% March 2007, Alfred Schouten,
% Example for WB2301 / Lecture 4

% Visualizes the 'leakage' effect,
% Occurs when the number of periods of a sinoid
%  within the observation time is not an integer!
close all;clear al;clc

Fs=100;         % sample frequency [Hz]
dt=1/Fs;
T=1;            % observation time
N=Fs*T;         % number of samples
t=(0:N-1).'/Fs; % time vector

% the signal, i.e. the 5 Hz sine 
freq=5;         % 5Hz
x=sin(2*pi*freq*t);
% second signal, i.e. the 5.5 Hz sine 
freq2=5.5;
x2=sin(2*pi*freq2*t);

% Fourier transform
X=fft(x); X=X(2:N/2+1); % take first half of the vector and 
                        %  remove X(1), the DC component
X2=fft(x2); X2=X2(2:N/2+1);
f=(1:N/2).'/T;            % corresponding frequency vector

figure
%plot the 5 Hz signal
subplot(211)
plot(t,x,'b.-','LineWidth',2), box off, hold on
axis([0 1 -1.1 1.1])
set(gca,'FontSize',14)
xlabel('time [s]','FontSize',16)
ylabel('amplitude','FontSize',16)

pause
%plot the |FFT| normalized with max(abs(X))
subplot(212)
h1=stem(f,abs(X)/max(abs(X)),'bo','LineWidth',2); box off, hold on
axis([0 10 -0.1 1.1])
set(gca,'FontSize',14)
xlabel('frequency [Hz]','FontSize',16)
ylabel('amplitude','FontSize',16)
legend(h1(1),{'1 Hz'})

pause
%plot the 5.5 Hz signal
subplot(211)
plot(t,x2,'r.-','LineWidth',2)

pause
%plot the |FFT|
subplot(212)
h2=stem(f,abs(X2)/max(abs(X)),'ro','LineWidth',2);
legend([h1(1) h2(1)],{'5 Hz','5.5 Hz'})

