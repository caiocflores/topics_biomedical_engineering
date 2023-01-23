% ColoredNoise

% March 2007, Alfred Schouten,
% Example for WB2301 / Lecture 4

% Boost a white noise signal
close all;clear al;clc

% construct the signal
Fs=1000;        % sample rate
dt=1/Fs;
T=4;           % observation time
N=T*Fs;       
t=(0:N-1).'/Fs;

% white noise signal
x=randn(N,1);
x=x-mean(x);
x=x/std(x);

% filter
f_lp=100;        % low-pass 
[b,a]=butter(2,f_lp*2/Fs); %digital butterworth
x_lp=filter(b,a,x);

% colored noise signal
x_lp=x_lp-mean(x_lp);
x_lp=x_lp/std(x_lp);

%fft
f=(1:N/2).'/T;
X=fft(x); X=X(2:N/2+1);
Sxx=1/N*abs(X.^2);
X_lp=fft(x_lp); X_lp=X_lp(2:N/2+1);
Sxx_lp=1/N*abs(X_lp.^2);

mf=freqAvg(f,8);
mSxx=freqAvg(Sxx,8);
mSxx_lp=freqAvg(Sxx_lp,8);

figure
subplot(221)
plot(t,x,'LineWidth',2)
xlabel('time [s]','FontSize',14)
ylabel('amplitude [-]','FontSize',14)
title('white noise','FontSize',16)
subplot(222)
plot(t,x_lp,'LineWidth',2)
xlabel('time [s]','FontSize',14)
title('colored noise','FontSize',16)

subplot(223)
plot(mf,mSxx,'LineWidth',2)
xlabel('frequency [Hz]','FontSize',14)
ylabel('S_{xx} [-]','FontSize',14)
subplot(224)
plot(mf,mSxx_lp,'LineWidth',2)
xlabel('frequency [Hz]','FontSize',14)


