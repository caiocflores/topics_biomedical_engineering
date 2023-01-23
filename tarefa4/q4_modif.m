%%  Part 2:  Compute the cross covariance (by hand) and apply to noisy data.

%   First, generate two noisy signals.
dt = 0.001;                     %The sampling interval.
t = (dt:dt:1);                  %Time axis.
x = 0.2*randn(1,length(t));     %Signal x.
y = 0.2*randn(1,length(t));     %Signal y.

%   Plot the two signals 
figure(1);
subplot(2,1,1);
plot(t, x, 'b', 'DisplayName', 'Signal x', 'linewidth', 1.3);
hold on;
plot(t, y, 'g', 'DisplayName', 'Signal y', 'linewidth', 1);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
legend('Orientation','horizontal','Box','on','Location','northeast');
title('Amplitude x Time - Signals x and y');

%  Computing the cross-variance
[rxy, lag] = my_cc_circ_shift(x, y);

%   And plot the results
subplot(2,1,2);
plot(lag, rxy, 'b', 'linewidth', 1.3)
xlabel('Lags (ms)'); 
ylabel('Cross-covariance');
title('Cross-covariance between signals x and y (r_{xy})');
saveas(gcf, 'q4_fig1.png');

%% Part 2 - Modified

% Cross-covariance of x and y using the built-in function xcorr()
[cxy, lags_cxy] = (xcorr(x - mean(x), y - mean(y))); % cross-covariance
N = length(t); % num of samples
cxy = cxy ./( (N) ); % normalization - eliminate the bias of the num of samples

% Plot of cross-crovariance with 'my_cc_circ_shift.m'
figure(2);
subplot(2,1,1);
plot(lag, rxy, 'b', 'linewidth', 1.3)
xlabel('Lags (ms)'); 
ylabel('Cross-covariance');
title('Cross-covariance between signals x and y (r_{xy})');

% Plot of cross-covariance with 'xcorr()'
subplot(2,1,2);
plot(lags_cxy, cxy, 'b', 'linewidth', 1.3);
xlabel('Lags (ms)');
ylabel('Cross-covariance');
title('Cross-covariance (c_{xy}) with xcorr()');
saveas(gcf, 'q4_fig2.png');
