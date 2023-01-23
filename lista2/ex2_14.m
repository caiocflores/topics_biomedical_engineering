clc; clear all; close all;

for idx=1:1e4
    rand_4num = rand(4,1);              % gerando 4 nums 
    rand_array(idx) = mean(rand_4num);  % media dos 4 nums
end 

histogram(rand_array); % histograma
xlabel("Valor gerado por rand()");
ylabel("Ocorrência dos valores");
title("Histograma de 10000 valores de rand()");

saveas(gcf,'semmlow_2_14.png'); % salvar imagem