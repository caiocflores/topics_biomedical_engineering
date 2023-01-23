%% dados
clear all; close all; clc;

% 3 senoides
fs = 1e3; 
N = 256;
SNR = -8; % dB
freqs = [240 260 350];

%% 2a 
order = 35;
x = sig_noise(freqs, SNR, N);
[Pxx, f] = pmcov(x, order, N, fs);
plot(f, Pxx, 'LineWidth', 1.3);
xlabel('Frequência (Hz)');
ylabel('Ps(f)');
grid();
title('Espectro de potência modelo AR - Método da Covariância');
saveas(gcf, 'q2_item_a.png');

%% 2b
SNRs = [-6 -10 -12 -14];
legenda = {};

% loop 
for ii = 1:length(SNRs)
    x_new = sig_noise(freqs, SNRs(ii), N); % sinal novo (x_new)
    [Pxx_new, f_new] = pmcov(x_new, order, N, fs);
    figure (2);
    str_SNR = num2str(SNRs(ii));
    plot(f_new, Pxx_new, 'LineWidth', 1.1, 'DisplayName', ['SNR: ' num2str(SNRs(ii))]);
    xlabel('Frequência (Hz)');
    ylabel('Ps(f)');
    legend();
    hold on;
    grid();
    title('Comparação do Método da Covariância p/ diferentes SNRs')
    %sgtitle('Espectro de potência modelo AR - Método da Covariância ()');
end
saveas(gcf, 'q2_item_b.png');
        