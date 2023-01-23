clc; clear all; close all;

% info sobre o arquivo:
% N = 1000 
% Ts = 1e-3
% variavel x

load("data_c1.mat"); % carregar arquico 'data_c1.mat'

% sinal nao-estacionario e aplicando o detrend

for j=1:4                     % dividir o sinal em 4 partes
    idx = 250*(j-1)+1;        % indices dos segmentos
    seg_ns = x(idx:idx+249);  % extrair segmento
    avg_ns(j) = mean(seg_ns); % media do segmento
    var_ns(j) = var(seg_ns);  % variancia do segmento
    
    % aplicando o detrend
    detrend_x = detrend(x);
    seg_s = detrend_x(idx:idx+249);
    avg_s(j) = mean(seg_s);
    var_s(j) = var(seg_s);
    
end

% print do sinal nao-estacionario
disp("Sinal não-estacionário");
avg_ns_out = sprintf("mean_seg1: %.4f | mean_seg2: %.4f | mean_seg3: %.4f | mean_seg4: %.4f", avg_ns(1), avg_ns(2), avg_ns(3), avg_ns(4));
var_ns_out = sprintf("var_seg1: %.4f  | var_seg2: %.4f  | var_seg3: %.4f  | var_seg4: %.4f\n", var_ns(1), var_ns(2), var_ns(3), var_ns(4));
disp(avg_ns_out);
disp(var_ns_out);

% print do sinal com o detrend aplicado
disp("Sinal modificado");
avg_s_out = sprintf("mean_seg1: %.4f | mean_seg2: %.4f | mean_seg3: %.4f | mean_seg4: %.4f", avg_s(1), avg_s(2), avg_s(3), avg_s(4));
var_s_out = sprintf("var_seg1: %.4f  | var_seg2: %.4f  | var_seg3: %.4f  | var_seg4: %.4f", var_s(1), var_s(2), var_s(3), var_s(4));
disp(avg_s_out);
disp(var_s_out);
