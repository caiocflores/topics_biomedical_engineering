%% Subject f2o02 - Elderly 
clc; clear all; close all; 
warning('off');

% obs.: only 60 Hz filter
%% TASK 6

load t5_f2o02.mat; % load of patient file - CRSIDLab
open('patient');

tempo = patient.sig.ecg.rri.aligned.time;
rri_detrend = detrend(patient.sig.ecg.rri.aligned.data); % retira trend linear do rri
sbp_detrend = detrend(patient.sig.bp.sbp.aligned.data); % retira trend linear do sbp

% Janelamento (detrend) antes de se calcular a FFT:
N = length(rri_detrend);
u = sbp_detrend.*hanning(length(sbp_detrend)); % esta ser� a entrada X(s)
y = rri_detrend.*hanning(length(rri_detrend)); % esta ser� a sa�da Y(s)
fs = 4; % em Hz; frequencia de reamostragem

T = N/fs; % Tempo de observa��o, = N*dt, onde dt = 1/fs = 1/4 s
U = fft(u);
U = U(2:((N/2)+1)); % Usar apenas metade do vetor. U(1) representa o valor m�dio
Suu = 1/N*real(conj(U).*U); % PSD � real por defini��o(a parte imagin�ria deve ser muito pequena)

Y = fft(y); % FFT = Fast Fourier Transform
Y = Y(2:((N/2)+1));

Syy=1/N*real(conj(Y).*Y); % Densidade espectral de potencia (PSD) de y
Suy=1/N*conj(U).*Y; % Densidade espectral de pot�ncia cruzada (CPSD) de u e y
f=(1:(N/2)).'/T; % Vetor de frequ�ncias
Hsbp=Suy./Suu; % Estimativa para fun��o de resposta em frequ�ncia (FRF)
Csbp=abs(Suy).^2./(Suu.*Syy); % Estimativa para a coer�ncia

% Plotando a fun��o resposta em frequ�ncia (FRF) e a coer�ncia
% (seguindo o modelo implementado em "Lec3_SmoothSuu.m":
figure(1)
subplot(311)
loglog(f,abs(Hsbp), 'b', 'linewidth', 1.3); grid;
xlabel('Frequency');
ylabel('|H(w)|');
title('Module of Frequency Response');

subplot(312)
semilogx(f,angle(Hsbp)*180/pi, 'b', 'linewidth', 1.3); grid;
xlabel('Frequency');
ylabel('<H(w)');
title('Phase of Frequency Response');

subplot(313)
semilogx(f,Csbp, 'b', 'linewidth', 1.3); grid;
xlabel('Frequency');
ylabel('C(w)');
title('Coherence'); hold on;
saveas(gcf, 't6_old_fig1.png');
% Veja que o fato da coer�ncia dar sempre 1 � um �problema� da FFT sem m�dia alguma.
% Fazendo pelo m�todo de Welch:

%% * M�TODO DE WELCH *
% Resumo: Divide o sinal em v�rios trechos. Esses trechos s�o organizados de forma a
% ficarem com determinada percentagem de seu comprimento sobreposta ao trecho
% anterior. Assim, o m�todo calcula o espectro aplicando a transformada de Fourier
% nesses trechos menores do sinal.
% Aqui, utiliza-se 50% de sobreposi��o e 8 trechos do sinal.

[SuuW,fw1] = cpsd(u,u,[],[],[],4);
[SyyW,fw2] = cpsd(y,y,[],[],[],4);
[SuyW,fw3] = cpsd(u,y,[],[],[],4);

%%% Fun��o de transfer�ncia
HWsbp=SuyW./SuuW;
CWsbp=abs(SuyW).^2./(SuuW.*SyyW);

% Plotando o resultado (como em "Lec3_SmoothSuu.m"):
figure(2)
subplot(311)
loglog(fw1,abs(HWsbp), 'r', 'linewidth', 1.3); grid;
xlabel('Frequency');
ylabel('|H(w)|');
title('Module of the Frequency Response - Welch Method');

subplot(312)
semilogx(fw1,angle(HWsbp)*180/pi, 'r', 'linewidth', 1.3); grid;
xlabel('Frequency');
ylabel('<H(w)');
title('Phase of the Frequency Responde - Welch Method');

subplot(313)
semilogx(fw1,CWsbp,'r', 'linewidth', 1.3); grid % COMPARE COM AS FIGURAS DO FFT
xlabel('Frequency');
ylabel('C(w)');
title('Coherence - Welch Method');
saveas(gcf, 't6_old_fig2.png');
%% C�lculo das �reas de BF (baixa frequencia) e AF (alta frequencia) da FT:
% (continua��o)

%close all; clear all; clc;

HWsbp_lf = zeros(size(HWsbp));
HWsbp_hf = zeros(size(HWsbp));
for i = 1:length(HWsbp)
    if (fw1(i)>= 0.04) && (fw1(i) <= 0.15)
    HWsbp_lf(i) = abs(HWsbp(i));
    else
    HWsbp_lf(i) = 0;
    end

    if (fw1(i)> 0.15) && (fw1(i) <= 0.4)
        HWsbp_hf(i) = abs(HWsbp(i));
    else
        HWsbp_hf(i) = 0;
    end
end

area_H_LF = trapz(HWsbp_lf);
area_H_HF = trapz(HWsbp_hf);

%% C�lculo das �reas de BF (baixa frequencia) e AF (alta frequencia) da FT:
% Considerando apenas os pontos com coer�ncia acima de 0,5: parte onde a entrada
% e a saida possuem uma relacao linear independentemente do tipo de sys
% (onde faz sentido calcular a fun��o de transfer�ncia (tf))

HWsbp_lf_c = zeros(size(HWsbp));
HWsbp_hf_c = zeros(size(HWsbp));
for i = 1:length(HWsbp)
    if (fw1(i)>= 0.04) && (fw1(i) <= 0.15) && (CWsbp(i) > 0.5)
        HWsbp_lf(i) = abs(HWsbp(i));
    else
        HWsbp_lf(i) = 0;
    end
    if (fw1(i)> 0.15) && (fw1(i) <= 0.4) && (CWsbp(i) > 0.5)
        HWsbp_hf(i) = abs(HWsbp(i));
    else
        HWsbp_hf(i) = 0;
    end
end

area_H_LF_c = trapz(HWsbp_lf);
area_H_HF_c = trapz(HWsbp_hf);

sprintf('Elderly Subject - f2o02: \n HLF_c = %d \n HLF_c = %d', area_H_LF_c, area_H_HF_c) % print areas