clc; clear all; close all;

% a rotina "quantization.m" deve ser carregada

f1 = 4; % frequencia da senoide: 4 Hz
N = 1e3; % numero de pontos do vetor de tempo
ts = 0.002; % periodo de amostragem 

t1 = (0:N-1)*ts; % vetor de tempo de 1e3 pontos;

n_bits = [4, 8, 10, 12];
% quantizacao para 4, 8, 10 e 12 bits
for bits=n_bits
    signal_in = sin(2*pi*f1*t1); % senoide de entrada
    signal_out = quantization(signal_in, bits); % quantizando 
    noise_signal = signal_out - signal_in;
    
    % calculo do erro experimental/amplitude do sinal de erro
    q_exp = max(noise_signal) - min(noise_signal);

    % calculo do nivel de quantizacao
    q = 1/(2^bits-1);
    out = sprintf('%2d bits: Valor experimental de q = %5e | Valor teórico de q = %5e', bits, q_exp, q);
    
    % saida formatada
    disp(out)
end 
