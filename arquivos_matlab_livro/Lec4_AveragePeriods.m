% demo with multisine input signal and multiple recorded periods
%
% WB2301 Lecture 4
% Februari 2010, Alfred C. Schouten
clear all
close all
clc

% basics
dt=0.01;        % sample frequency
fs=1/dt;        % sample frequency
N=500;          % # of samples
T=N*dt;         % observation time
t=(0:N-1).'*dt; % time vector

M=20;           % number of recorded periods
t_M=(0:N*M-1)/fs; % time vector

%% design signal
% a crested multisine
fhigh=10;                                 % highest excited frequency
freqv=1/T:1/T:fhigh;                      % just all frequencies between 1/T and fhigh
cx=exp(rand(length(freqv),1)*2j*pi);      % vector with amplitude 1 and random phase
[cx2]=msinclip(freqv,cx,[],[],200,[],N);  % cresting
[x,df]=msinprep(freqv,cx2,N,fs,'screen'); % make time-signal
x=x/std(x);                               % scale to have variance of 1
pause

% auto-spectral density of signal
Suu=1/N*abs(fft(x).^2);
Suu_org=Suu;
Suu=Suu(1:N/2+1);
f=(0:N/2)/T;
figure
subplot(211),plot(t,x)
ylabel('u(t) [-]'),xlabel('time [s]')
subplot(212),loglog(f,Suu)
ylabel('S_{uu}(f)'),xlabel('frequency [Hz]')
pause

%% simulate system
M1=M+1;  % one extra period extra
         % will be excluded in analyses to remove transient behavior
t_M1=(0:N*M1-1)/fs;       % time vector
u=repmat(x,M1,1);         % repeat the signal
sys=tf(1,[0.025 0.05 1]); % low pass system
y=lsim(sys,u,t_M1);       % output of the system
nu=randn(N*M1,1);         % input noise
nu=nu/std(nu)*0.1;        % scale noise (try different values!)
u=u+nu;                   % output with noise
ny=randn(N*M1,1);         % output noise
ny=ny/std(ny)*0.5;        % scale noise (try different values!)
y=y+ny;                   % output with noise

% remove the first (extra) period to remove transient behavior
u=u(N+1:end);
y=y(N+1:end);
ny=ny(N+1:end);
nu=nu(N+1:end);
% reshape into matrix, every period in a column
um=reshape(u,N,M);
ym=reshape(y,N,M);
% average (time-)response, only done for plotting
u0=mean(um,2);
y0=mean(ym,2);
% DFT, every period in a column
Um=fft(um);
Um=Um(1:N/2+1,:);
Ym=fft(ym);
Ym=Ym(1:N/2+1,:);
% Schoukens & Pintelon, Eq 2-30
U0=mean(Um,2);
Y0=mean(Ym,2);
H=Y0./U0;
% spectral densities
Suu=1/N*abs(U0.^2);
Syy=1/N*abs(Y0.^2);
Suy=1/N*conj(U0).*Y0;
% Eq 2-31
varU=1/N/(M-1)*sum(abs(Um-U0*ones(1,M)).^2,2);
varY=1/N/(M-1)*sum(abs(Ym-Y0*ones(1,M)).^2,2);
varUY=1/N/(M-1)*sum(conj(Um-U0*ones(1,M)).*(Ym-Y0*ones(1,M)),2);
% Eq 2-32
varH=abs(H).^2/M.*(varY./Syy+varU./Suu-2*real(varUY./Suy));

figure
subplot(211),plot(t,um),hold on
plot(t,u0,'k','linewidth',2)
ylabel('u(t) [-]')
subplot(212),plot(t,ym),hold on
plot(t,y0,'k','linewidth',2)
ylabel('y(t) [-]'),xlabel('time [s]')
pause

figure
subplot(211),loglog(f,abs(Um)),hold on
loglog(f,abs(U0),'k','linewidth',2)
ylabel('S_{uu}(f) [-]')
subplot(212),loglog(f,abs(Ym)),hold on
loglog(f,abs(Y0),'k','linewidth',2)
ylabel('S_{yy}(f) [-]'),xlabel('frequency [Hz]')
pause

% theoretical response
tmp=freqresp(sys,2*pi*f);
Ht=squeeze(tmp);
% figure with FRF
k=find(Suu>mean(Suu)); % select excited frequencies (those with power)
figure
subplot(211)
loglog(f,abs(Ht),'g--','linewidth',2),hold on
loglog(f(k),abs(H(k)))
loglog(f(k),abs(H(k))+2*sqrt(varH(k)),'b:')
loglog(f(k),abs(H(k))-2*sqrt(varH(k)),'b:')
ylabel('|H(f)| [-]')
legend('theory','estimate','+2*std','-2*std')
subplot(212)
semilogx(f,angle(Ht)*180/pi,'g--','linewidth',2),hold on
semilogx(f(k),unwrap(angle(H(k)))*180/pi)
ylabel('phase H(f) [\circ]'),xlabel('frequency [Hz]')
pause

%% noise analyses

% spectral density of the noise
Ny=fft(ny);
Nu=fft(nu);
Snyny=1/(N*M)*abs(Ny.^2);
Snunu=1/(N*M)*abs(Nu.^2);
Snuny=1/(N*M)*conj(Nu).*Ny;
f_M=(0:N*M-1)/(T*M);

% frequency averaging to improve estimate
mfr=freqAvg(f_M,10);
mSnyny=freqAvg(Snyny,10);
mSnunu=freqAvg(Snunu,10);
mSnuny=freqAvg(Snuny,10);

% compare with varY
figure
subplot(311)
plot(mfr,mSnunu), hold on
plot(f,varU,'k')
legend('S_{nunu}(f)','\sigma_u^2(f)')
subplot(312)
plot(mfr,mSnyny), hold on
plot(f,varY,'k')
legend('S_{nyny}(f)','\sigma_y^2(f)')
subplot(313)
plot(mfr,abs(mSnuny)), hold on
plot(f,abs(varUY),'k')
xlabel('frequency [Hz]')
legend('|S_{nuny}(f)|','|\sigma_uy^2(f)|')

%%
break
%% matlab standard toolboxes
% signal processing toolbox => cross-covariance, spectral densities
% system identification toolbox => IRF, FRF, etc

% Signal processing
[Suu_sp,f_sp] = periodogram(u,[],N,fs,'two-sided');
Suu_sp=Suu_sp/(M*dt); % <M> scale with number of segments
                      % SP toolbox scales with 1/T, normal is 1/N, so we
                      % need an extra dt (T=N*dt)
% method 2
Hs = spectrum.periodogram({'rectangular',N});
hopts = psdopts(Hs);
set(hopts,'Fs',fs,'NFFT',N,'SpectrumType','twosided');
Sdata=psd(Hs,u,hopts);
Suu_sp2=Sdata.Data/(M*dt);
                      
figure
plot(f,Suu), hold on, % our calculated spectrum
plot(f_sp,Suu_sp,'ro--') % SP toolbox
plot(f_sp,Suu_sp2,'kx:') % SP toolbox
% tada, exactly equal!

% SYS ID toolbox
data=iddata(y,u,dt,'Period',N);
% Hid=etfe(data); % standard, does not calculate confidence intervals
%Hid=spa(data); % with confidence intervals. However not for periodic data,
               %  always uses Hanning window.
Hid=spa(data,N,freqv*2*pi); % evaluate over segment length and at excited frequencies

[MAG,PHASE,W,SDMAG,SDPHASE] = bode(Hid);
MAG=squeeze(MAG); % rotate vectors
SDMAG=squeeze(SDMAG);
PHASE=squeeze(PHASE);
SDPHASE=squeeze(SDPHASE);

figure
%bode(Hid,'SD',2,'fill')
% our FRF
subplot(211)
loglog(f(k),abs(H(k))), hold on
loglog(f(k),abs(H(k))+2*sqrt(varH(k)),'b:')
loglog(f(k),abs(H(k))-2*sqrt(varH(k)),'b:')
subplot(212)
semilogx(f(k),unwrap(angle(H(k)))*180/pi), hold on
% IDENT toolbox
subplot(211)
loglog(W/(2*pi),MAG,'r--')
loglog(W/(2*pi),MAG+2*SDMAG,'r--')
loglog(W/(2*pi),MAG-2*SDMAG,'r--')
subplot(212)
semilogx(W/(2*pi),PHASE,'r--')
semilogx(W/(2*pi),PHASE+2*SDPHASE,'r--')
semilogx(W/(2*pi),PHASE-2*SDPHASE,'r--')
% comparable, not equal
% Formula's for confidence intervals for periodic signals are different
% from (standard) algorithms

% ARX/ARMAX/OE/BJ

% subspace
% Mod=n4sid(data);
