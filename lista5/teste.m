close all; clear all; clc;
load sawth.mat

fs = 1000; % Sampling frequency
N=256;
f1 = (1:N)*fs/N; % Frequency vector for plotting
t = (0:N-1)*fs/N; %Time vector for plotting
fc = 40/fs; % Cutoff frequency (normalized to fs)
L = 65; % Requested filter length

ffiltro=[0,2*fc,2*fc,1];
G=[0,0,1,1];
b=fir2(L,ffiltro,G);
bblack=b.*blackmanharris(1);

y=filter(bblack,1,x);
y1=conv(x,bblack,'same');

figure;
plot(t,x,'b'); hold on; plot(t,y,'k'); hold on; plot(t,y1,'r');
legend('Default Signal','Causal','Noncasual');;
xlabel('Time (s)');
ylabel('Amplitude');
title('Default Signal and Comparison of Causal and Non-Causal Filters');

saveas(gcf, "ex4_20.png")