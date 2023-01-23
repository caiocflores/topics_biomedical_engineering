close all; clear all; clc;

intervals = [0.05,0.01,0.001]; % intervalos 
num_plots = length(intervals); % qtde de plots
TT = 1; % tempo total
f = 2; % frequencia do sinal senoidal
for i = 1:num_plots 
	subplot(num_plots, 1, i);
	ts = intervals(i); % periodo de amostragem
	t = 0:ts:TT; % vetor de tempo
	x = sin(2*pi*f.*t);  
	plot(t, x); % plotagem da linha
	hold on;
	plot(t, x, '.k'); % plotagem dos pontos
	xlabel('Tempo (s)'); 
	ylabel(sprintf('Amplitude do sinal'));
	legend('Linha', 'Pontos', 'Location', 'best'); % melhor localização
    title(sprintf('Ts = %s', string(ts)));
end

sgtitle('Sinal senoidal de 2 Hz com diferentes Ts');
saveas(gcf,'semmlow_1_5.png');