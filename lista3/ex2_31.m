clc; clear all; close all;

load bandwidths.mat; % loading the file
% there is two variable: signals x and y
% x: narrowband signal 
% y: broadband signal 

[rxx, lags_x] = xcorr(x, x, 'coeff', 30); % autocorrelation x
[ryy, lags_y] = xcorr(y, y, 'coeff', 30); % autocorrelation y

% plot
subplot(2, 1, 1);
plot(lags_x, rxx, 'k', 'DisplayName', 'Narrowband Signal');
ylabel('Autocorrelation value'); % x-axis name
xlabel('Lags'); hold on; % y-axis name; joint plot 
axis([-30 30 -0.5 1.2]); % limits of the axis plot
legend('Orientation','horizontal','Box','on','Location','southoutside');

subplot(2, 1, 2);
plot(lags_y, ryy, 'b', 'DisplayName', 'Broadband Signal');
ylabel('Autocorrelation value');
xlabel('Lags');
axis([-30 30 -0.5 1.2]);
legend('Orientation','horizontal','Box','on','Location','southoutside');
sgtitle('Autocorrelation of signals X and Y');
grid(); % insert lines 
saveas(gcf, 'semmlow_2_31.png');