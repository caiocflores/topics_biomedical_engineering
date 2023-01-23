clear all;
close all;

f=5; %5Hz
Tt= 1;%1 segundo


%Representação 1000 pontos:
N=1000; %N=Tt/Ts
Ts1 = Tt/N;
t1=(0:N-1)*Ts1;
sig1=sin(2*pi*f*t1);

%Representação subamostrada
fs2=9; %Amostragem 7Hz
Ts2=1/fs2;
t2=0:Ts2:Tt;
sig2=sin(2*pi*f*t2);

%Plotando:
plot(t1,sig1,'b');grid;
xlabel('Tempo (s)');
ylabel('Amplitude do sinal')
hold on;
plot(t2,sig2,'r*');


%Sinal "recuperado"
t3=linspace(0,Tt);
f2=fs2-f;
sig3=-sin(2*pi*f2*t3);
plot(t3,sig3,'g');

legend('sinal original','sinal subamostrado','sinal "recuperado"');
title('Efeito de Aliasing');

saveas(gcf,'semmlow_1_9.png');