% AliasingDemo

% March 2007, Alfred Schouten,
% Example for WB2301 / Lecture 4

% Visualizes the 'aliasing' effect,
% Occurs when the frequencies in the signal are higher then half the sample
% frequency
close all;clear al;clc

% construct the 'continuous' signal: a signal at a much higher sample rate
fs1=1000;       % 'continuous' sample rate
T=2;            % observation time
N1=T*fs1;       
t1=(0:N1-1).'/fs1;
freq=9;         % 9Hz
x1=sin(2*pi*freq*t1); %9Hz signal @ 1000Hz

%figure
plot(t1,x1,'b','LineWidth',2), hold on
ylim([-1.2 1.2])
xlabel('time [s]','FontSize',16)
ylabel('amplitude [-]','FontSize',16)

% the sampled signal
fs=10;          % sample frequency [Hz]
N=fs*T;         % number of samples
rs=fs1/fs;      % resample rate
t=t1(1:rs:end); % time vector
x=x1(1:rs:end); % 9Hz signal @ 10Hz

% explanation: 
% the fs has dreceased, thus the Ts has increased

%pause
% plot the samples
hold on;
plot(t,x,'ro','LineWidth',2)
%pause
% draw a line between the samples
plot(t,x,'r--','linewidth',3)
