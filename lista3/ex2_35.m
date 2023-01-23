clc; clear all; close all;
% attention: insert the file 'axcor' 

load Hr_med.mat % loading the file
% there is two variables:
% hr_med: heart rate
% t_med: time vector 

[cov_hrm, lags_hrm] = axcor(hr_med - mean(hr_med)); % normal autocovariance
plot(lags_hrm, cov_hrm, 'k'); hold on;
plot([lags_hrm(1) lags_hrm(end)], [0 0], 'r--');
xlabel('Lags');
ylabel('$c_{xx}$', 'Interpreter', 'latex', 'Fontsize', 20); % latex symbol
title('Heart Rate Autocovariance');
axis([-30 30 -0.2 1.2]); % x-axis [-30, 30] beats
grid();
saveas(gcf,sprintf('%s.png',mfilename));

%% 1) simple form to extract the frequency of periodic elements
% based on 2 samples
f1 = 1/( t_med(2) - t_med(1) );

% based on all the "t_med" samples
for i=1:(length(t_med) - 1)
    f_vec(i) = 1/( t_med(i+1) - t_med(i) );
end 
f_med = mean(f_vec);

out = sprintf('2-samples Frequency: %.4f | Average Frequency: %.4f', f1, f_med);
disp(out);

%% 2) using the cross correlation in with f = 0.1 to 1 Hz
% this range [0.1, 1] is usually the heart rate range

cnt = 1;
for i=(0.1:0.1:2)
    f_axcorr_vec(cnt) = max(axcor(hr_med, cos(2*pi*i*t_med)));
    freqs(cnt) = i;
    out = sprintf('Frequency: %.2f Hz --> Max cross correlation: %.4f', freqs(cnt), f_axcorr_vec(cnt));
    disp(out);
    cnt = cnt +1;
end

%disp(f_axcorr_vec);
%disp(max(f_axcorr_vec));