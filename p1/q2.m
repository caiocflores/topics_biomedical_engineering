%% questao 2a
clc; clear all; close all;
Ts = 1; % 1 hora
N = 24; % num amostras
K = 1;  % dosagem
xn = K*ones(1, N); % impulsos
ns = (0:N-1); % vetor de amostras
pn = xn .* (5*K*(1-0.7*((0.5).^ns) - (0.25*(0.2.^ns))));

subplot(3, 1, 1);
plot(ns, pn, 'linewidth', 2); % pn é a resp. ao degrau unitario
ylabel('p[n]')
xlabel('Qtde. de amostras (n)');
title('Resposta ao degrau');
grid();

%% questao 2b
subplot(3, 1, 2);
hn = gradient(pn); % derivada
plot(ns, hn, 'linewidth', 2);
ylabel('h[n]')
xlabel('Qtde. de amostras (n)');
title('Resposta ao impulso');
grid();


%% questao 2c
subplot(3, 1, 3);
K = 3; % dosagem
num_doses = 24/K; % intervalo de doeses
xn = K .* repmat([1,0,0,0], 1, num_doses); % 1 dose a cada 4h
y = conv(xn, hn); % conv -> resposta
plot(ns, y(1:N), 'linewidth', 2); % plot das 24h
ylabel('y[n]')
xlabel('Amostras (n)');
title('Resposta ao trem de pulsos');
grid();