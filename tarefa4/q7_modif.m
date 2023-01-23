%% defines the system and signals

dt=0.01;        % sample frequency
fs=1/dt;        % sample frequency
N=5000;         % # of samples
T=N*dt;         % observation time
t=(0:N-1).'*dt; % time vector
u=randn(N,1);   % input signal
sys=tf(1,[0.025 0.05 1]); %low pass system
v=lsim(sys,u,t);% output of the system
n=0.1*randn(N,1); % output noise
y=v+n;          % output with noise

%% Welch Method - Hands on (original code)

D = 10; %10 segments
u_w = reshape(u, N/D ,D);   % make matrix with D columns!
U_w = fft(u_w);           % fft works columnwise on matrices
U_w = U_w(2:N/D/2+1, :);
SuuWall = D/N*real(conj(U_w).*U_w);
SuuW = mean(SuuWall, 2);   %take the average over the rows (,2 option)
y_w = reshape(y, N/D, D);   % make matrix with D columns!
Y_w = fft(y_w);           % fft works columnwise on matrices
Y_w = Y_w(2:N/D/2+1, :);
SyyWall = D/N*real(conj(Y_w).*Y_w);
SyyW = mean(SyyWall, 2);
SuyWall = D/N*conj(U_w).*Y_w;
SuyW = mean(SuyWall,2);
fw = (1:N/D/2).'*D/N/dt;
HW = SuyW./SuuW; % ft by Welch Method
CW = abs(SuyW).^2./(SuuW.*SyyW); % coherence by Welch Method

% figure with spectra
figure(1);
subplot(311);
loglog(fw, SuuW, 'r', 'linewidth', 1.3);
xlabel('Frequency');
ylabel('S_{uu}(w)');
title('Power Spectrum - S_{uu}');

subplot(312);
loglog(fw, SyyW, 'r', 'linewidth', 1.3);
xlabel('Frequency');
ylabel('S_{yy}(w)');
title('Power Spectrum - S_{yy}');

subplot(313);
loglog(fw,abs(SuyW), 'r', 'linewidth', 1.3);
xlabel('Frequency');
ylabel('S_{uy}(w)');
title('|S_{uy}|');
saveas(gcf, 'q7_fig1.png');

% figure with FRF and coherence
figure(2);
subplot(311);
loglog(fw,abs(HW), 'r', 'linewidth', 1.3);
xlabel('Frequency');
ylabel('|H(w)|');
title('Module of Frequency Response');

subplot(312);
semilogx(fw, angle(HW)*180/pi, 'r', 'linewidth', 1.3);
xlabel('Frequency');
ylabel('<H(w)');
title('Phase of Frequency Response');

subplot(313);
semilogx(fw, CW, 'r', 'linewidth', 1.3);
xlabel('Frequency');
ylabel('C(w)');
title('Coherence');
saveas(gcf, 'q7_fig2.png');


%% applying Welch Method to input (u) and output (y)

[Suu_w, fu] = pwelch(u, N, D, [], fs); % welch of auto-spectrum of u
[Syy_w, fy] = pwelch(y, N, D, [], fs); % welch of auto-spectrum of y

[Suy_w, fuy] = cpsd(u, y , N, D, [], fs); % cross spectrum

HW_new = Suy_w./Suu_w; % transfer function by Welch Method
[CW_new, f_cw] = mscohere(u,y); % coherence by Welch Method

% figure with spectra
figure(3);
subplot(311);
loglog(fu, Suu_w, 'r', 'linewidth', 1.3);
xlabel('Frequency');
ylabel('S_{uu}(w)');
title('Power Spectrum - S_{uu} - Welch Method');

subplot(312);
loglog(fy, Syy_w, 'r', 'linewidth', 1.3)
xlabel('Frequency');
ylabel('S_{yy}(w)');
title('Power Spectrum - S_{yy} - Welch Method');

subplot(313);
loglog(fu, abs(Suy_w), 'r', 'linewidth', 1.3);
xlabel('Frequency');
ylabel('S_{uy}(w)');
title('|S_{uy}| - Welch Method');
saveas(gcf, 'q7_fig3.png');

% figure with FRF and coherence
figure(4);
subplot(311);
loglog(fu, abs(HW_new), 'r', 'linewidth', 1.3)
xlabel('Frequency');
ylabel('|H(w)|');
title('Module of the Frequency Response - Welch Method');

subplot(312);
semilogx(fu, angle(HW_new)*180/pi, 'r', 'linewidth', 1.3);
xlabel('Frequency');
ylabel('<H(w)');
title('Phase of the Frequency Responde - Welch Method');

subplot(313);
semilogx(f_cw, CW_new, 'r', 'linewidth', 1.3);
xlabel('Frequency');
ylabel('C(w)');
title('Coherence - Welch Method');
saveas(gcf, 'q7_fig4.png');

