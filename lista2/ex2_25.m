clc; clear all; close all; 

% Cos e Onda quadrada com a mesma f

N = 500;
Ts = 2e-3;
A = 1;
t = (0:N-1)*Ts;
f1 = 1;
s1 = A*cos(2*pi*f1*t);    % cossenoide
s2 = A*square(2*pi*f1*t); % onda quadrada

rxy = mean(s1.*s2); % correlacao normalizada (= sum(s1.*s2)/N )

% plotando os sinais s1 e s2
plot(t, s1, "DisplayName", "Cosseno");
hold on;
plot(t, s2, "DisplayName", "Onda Quadrada");
ylim([-1.1*A, 1.1*A]);
xlabel("Time (s)");
ylabel("Amplitude (V)");
legend('Orientation','horizontal','Box','on','Location','southoutside');
title({"Normalized correlation (rxy):"; rxy}); % rxy plotado no titulo

saveas(gcf,'semmlow_2_25.png'); % salvar imagem