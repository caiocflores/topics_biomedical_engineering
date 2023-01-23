clc; clear all; close all; 

N = 500; % número de pontos
TT = 0.2; % tempo total do sinal (onda quadrada)
fT = 1/TT; % frequencia do sinal 
Ts = TT/N; % periodo de amostragem
A = 1; % amplitude do sinal
t = (0:N-1)*Ts; % vetor de tempo

y = A*square(2*pi*fT*t); % onda quadrada

% valor RMS
RMS = sqrt(mean(y.^2)); % RMS
sprintf('O valor RMS é: %4f', RMS); % print

% visualizando a forma de onda
hold on;
plot(t, y, 'k', 'DisplayName', 'Onda quadrada'); grid;
xlabel('Tempo (s)'); 
ylabel('Amplitude (V)'); 
yline(RMS, 'b--', 'DisplayName', sprintf('Valor RMS: %.1f V', RMS)); % valor RMS no gráfico
ylim([-1.5*A, 1.5*A]);% limites do eixo y
title('Onda quadrada'); 
legend('Orientation','horizontal','Box','on','Location','southoutside');

saveas(gcf,'semmlow_2_4.png'); % salvar imagem