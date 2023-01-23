clc; close all; clear all;

%% questao 1a
N = 200;
TT = 2;
Ts = TT/N;
fs = 1/Ts;
t = (0:N-1)*Ts; 
A = 1; 

% sinal x1(t)
x1 = ones(N);
subplot(3,2,1)
plot(t,x1,'k','DisplayName','x1','LineWidth',2);
axis([0 2 -1 1]);
ylabel('x1(t)');
xlabel('time (s)');
title('x1(t) graph');
grid();

% sinal x2(t)
fx2 = 1/2; 
x2 = A*square(2*pi*fx2*t);
subplot(3,2,2)
plot(t,x2,'k','DisplayName','x2','LineWidth',2);
axis([0 2 -1 1]);
ylabel('x2(t)')
xlabel('time (s)');
title('x2(t) graph');
grid();

% sinal x3(t)
fx3 = 1/1;
x3 = A*square(2*pi*fx3*t);
subplot(3,2,3)
plot(t,x3,'k','DisplayName','x3', 'LineWidth',2);
axis([0 2 -1 1]);
ylabel('x3(t)')
xlabel('time (s)');
title('x3(t) graph');
grid();

% sinal y(t)
y = zeros(1, N);
y(1:100) = 1*t(1:100);
y(101:200) = -1*ones(100,1);
subplot(3,2,4)
plot(t,y,'k','DisplayName','y','LineWidth',2);
axis([0 2 -1 1]);
ylabel('y(t)')
xlabel('time (s)');
title('y(t) graph');
grid();

%% questao 1b
%Calcular coeficientes
a1 = sum(y.*x1)/(sum(x1.^2));
a2 = sum(y.*x2)/(sum(x2.^2));
a3 = sum(y.*x3)/(sum(x3.^2));

% calcula função aproximada
yest = a1.*x1 + a2.*x2 + a3.*x3;

%% questao 1c
figure(2);
hold on;
plot(t, yest, 'k', 'DisplayName','yest(t)', 'lineWidth', 2);
plot(t, y, 'b', 'DisplayName','y(t)', 'lineWidth', 2);
ylabel('amplitude')
xlabel('time (s)');
title('y(t) preto e yest(t) azul');
grid();
