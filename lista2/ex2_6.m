clc; close all; clear all;
N = 1e3; % numero de po
TT = 1; % tempo toal
Ts = TT/N; % periodo de amostragem
f = 1/0.5; % frequencia dos sinais
t = (0:N-1)*Ts; % vetor de tempo
A = 1; % amplitude do sinal
s = A*sawtooth(2*pi*f*t); % onda dente de serra
s_rms = sqrt(sum(s.^2)/N); % valor RMS do sinal s 

% plot
plot(t, s, 'k', 'DisplayName', 'Sawtooth wave');
hold on;
yline(s_rms,'b--','DisplayName', sprintf('RMS = %.2f V',s_rms)); % valor RMS
ylabel('Amplitude (V)');
xlabel('Time (sec)');
ylim([-1.1*A,1.1*A]); % limites de visualizacao
legend('Orientation','horizontal','Box','on','Location','southoutside');
title('RMS value of a sawtooth wave');
saveas(gcf, 'semmlow_2_6.png')