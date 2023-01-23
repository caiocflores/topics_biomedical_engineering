% Lec3_SmoothSuu
%
% Demonstrate effect of spectral smoothing on estimate of spectral
% densities, FRF and coherence, using Welch method and frequency averaging
% method
%
% Alfred C. Schouten
% February 16, 2010
clear all
close all
clc

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

%% no smoothing
U=fft(u);
U=U(2:N/2+1);   % use only halve the vector. Note that U(1) represents the average value
Suu=1/N*real(conj(U).*U);   %autospectral density is real by definition (the imag part should be very small)
Y=fft(y);
Y=Y(2:N/2+1);
Syy=1/N*real(conj(Y).*Y);
Suy=1/N*conj(U).*Y;
f=(1:N/2).'/T;  % frequency vector
H=Suy./Suu;     % estimate for FRF
C=abs(Suy).^2./(Suu.*Syy);  % estimate for the coherence

% theoretical FRF
tmp=freqresp(sys,2*pi*f);
Ht=squeeze(tmp);

% figure with spectra
figure(1)
subplot(311)
loglog(f,Suu),hold on
subplot(312)
loglog(f,Syy),hold on
subplot(313)
loglog(f,abs(Suy)),hold on

% figure with FRF and coherence
figure(2)
subplot(311)
loglog(f,abs(Ht),'g--','linewidth',2),hold on
loglog(f,abs(H))
subplot(312)
semilogx(f,angle(Ht)*180/pi,'g--','linewidth',2),hold on
semilogx(f,angle(H)*180/pi)
subplot(313)
semilogx(f,C),hold on

%% Welch method
% in short: calculate U and Y per segment
% calculate spectra per segment and average over segments
D=10; %10 segments
u_w=reshape(u,N/D,D);   % make matrix with D columns!
U_w=fft(u_w);           % fft works columnwise on matrices
U_w=U_w(2:N/D/2+1,:);
SuuWall=D/N*real(conj(U_w).*U_w);
SuuW=mean(SuuWall,2);   %take the average over the rows (,2 option)
y_w=reshape(y,N/D,D);   % make matrix with D columns!
Y_w=fft(y_w);           % fft works columnwise on matrices
Y_w=Y_w(2:N/D/2+1,:);
SyyWall=D/N*real(conj(Y_w).*Y_w);
SyyW=mean(SyyWall,2);
SuyWall=D/N*conj(U_w).*Y_w;
SuyW=mean(SuyWall,2);
fw=(1:N/D/2).'*D/N/dt;
HW=SuyW./SuuW; % ft by Welch Method
CW=abs(SuyW).^2./(SuuW.*SyyW); % coherence by Welch Method

% figure with spectra
figure(1)
subplot(311)
loglog(fw,SuuW,'r')
subplot(312)
loglog(fw,SyyW,'r')
subplot(313)
loglog(fw,abs(SuyW),'r')
% figure with FRF and coherence
figure(2)
subplot(311)
loglog(fw,abs(HW),'r')
subplot(312)
semilogx(fw,angle(HW)*180/pi,'r')
subplot(313)
semilogx(fw,CW,'r')

%% average over bands
% in short: calculate spectra in the normal 'raw' way
% then average adjacent frequencies with the spectra
m=10;
SuuM=freqAvg(Suu,m);
SyyM=freqAvg(Syy,m);
SuyM=freqAvg(Suy,m);
fm=freqAvg(f,m);
HM=SuyM./SuuM;
CM=abs(SuyM).^2./(SuuM.*SyyM);

% figure with spectra
figure(1)
subplot(311)
loglog(fm,SuuM,'m')
ylabel('S_{uu}')
subplot(312)
loglog(fm,SyyM,'m')
ylabel('S_{yy}')
subplot(313)
loglog(fm,abs(SuyM),'m')
ylabel('|S_{yu}|'),xlabel('frequency [Hz]')
legend({'raw','welch','freq. avg.'})
% figure with FRF and coherence
figure(2)
subplot(311)
loglog(fm,abs(HM),'m')
ylabel('gain H [-]')
subplot(312)
semilogx(fm,angle(HM)*180/pi,'m')
ylabel('phase H [\circ]')
subplot(313)
semilogx(fm,CM,'m')
ylabel('\gamma^2'),xlabel('frequency [Hz]')
legend({'raw','welch','freq. avg.'})

%% 'theoretical' coherence (academic example!)
Nt=fft(n(2:N/2+1));
Snn=1./N*abs(Nt.^2);
Ct=1./(1+mean(Snn)./(abs(Ht).^2.*mean(Suu)));
semilogx(f,Ct,'g--','linewidth',2)
legend({'raw','welch','freq. avg.','theory'})

%% compare with standard matlab toolboxes
%%% signal processing toolbox
% Suu_P=periodogram(u,[],N,[],'twosided'); %equal with double length!
% Suu_PW=pwelch(u,ones(N/10,1),0,N/10,[],'twosided'); %equal with double length!
% with this toolbox windows are applied on signals

%%%  system identification toolbox
% dat=iddata(y,u,dt);
% spa,etfe,etc
% with this toolbox windows are applied on covariance functions 
% (this effect will be discussed in lecture 6)
