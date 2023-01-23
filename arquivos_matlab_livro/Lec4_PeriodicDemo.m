% Periodic demo

% Februari 2010, Alfred Schouten,
% Example for WB2301 / Lecture 4

clear all; close all; clc

fs=200;          % sample frequency [Hz]
T=10;            % observation time
N=fs*T;          % number of samples
t=(0:N-1)/fs;    % time vector

%random signal
xr=randn(N,1);
xr=xr/std(xr);
fcut=10;
[b,a]=butter(3,fcut*2/fs);
xrf=filtfilt(b,a,xr);
xrf=xrf/std(xrf);
% fft
f=(1:N/2)/T;
Xr=fft(xr);Xr=Xr(2:N/2+1);
Xrf=fft(xrf);Xrf=Xrf(2:N/2+1);

figure
plot(t,xr), hold on
xlabel('time [s]')
ylabel('amplitude')
pause
plot(t,xrf,'r')
pause

figure
plot(f,abs(Xr),'b'), hold on, axis([0 100 0 200])
xlabel('frequency [Hz]')
ylabel('amplitude')
title('Fourier coefficients')
pause
plot(f,abs(Xrf),'r')
pause

plot(f,mean(abs(Xr(1:100))),'c')
plot(f,mean(abs(Xrf(1:100))),'m')
pause

%periodic signal
freqv=1/T:1/T:fcut;
cx=exp(1j*rand(length(freqv),1)*2*pi);
[xp,df]=msinprep(freqv,cx,N,fs,'screen');
xpscale=std(xp);
xp=xp/xpscale;

figure
subplot(211), plot(t,xrf,'b'), box off, hold on, axis([0 T -4 4])
title(['filtered white noise [' num2str(fcut) ' Hz]'])
ylabel('amplitude')
subplot(212), plot(t,xp,'r'), box off, hold on, axis([0 T -4 4])
title(['multisine [0.1-' num2str(fcut) ' Hz]'])
ylabel('amplitude')
xlabel('time [s]')
pause

Xp=fft(xp);Xp=Xp(2:N/2+1);

figure
subplot(221), plot(f,abs(Xrf)), axis([0 20 0 300]),hold on
ylabel('magnitude')
subplot(223), plot(f,angle(Xrf)*180/pi), axis([0 20 -200 200])
ylabel('phase')
set(gca,'YTick',[-270:90:270])

subplot(222), plot(f,abs(Xp),'r'), axis([0 20 0 300])
subplot(224), plot(f,angle(Xp)*180/pi,'r'), axis([0 20 -200 200])

subplot(221), title(['filtered white noise'])
subplot(222), title(['multisine'])
pause
subplot(221), plot(f(1:100),ones(1,100).*mean(abs(Xrf(1:100))),'m')
pause

% histogram filtered noise
figure
subplot(211), plot(t,xrf), axis([0 T -3 3]), hold on
title(['filtered white noise'])
ylabel('amplitude')
xlabel('time [s]')
subplot(212), hist(xrf), axis([-3 3 0 500]), hold on
xlabel('amplitude')
pause

%%% cresten

% histogram not crested
figure
subplot(211), plot(t,xp), axis([0 T -3 3]), hold on
title(['multisine'])
ylabel('amplitude')
xlabel('time [s]')
subplot(212), hist(xp), axis([-3 3 0 500]), hold on
xlabel('amplitude')
pause

% cresting 50 iterations
figure(99);
[cx2]=msinclip(freqv,cx,[],[],50,[],N);
[xpc2,df]=msinprep(freqv,cx2,N,fs,'screen');
xpc2=xpc2/xpscale;
pause

% histogram crested 50 iterations
figure
subplot(211), plot(t,xpc2), axis([0 T -3 3])
title(['multisine crested (50)'])
ylabel('amplitude')
xlabel('time [s]')
subplot(212), hist(xpc2), axis([-3 3 0 500])
xlabel('amplitude')
pause

% cresting +450 iterations
figure(99)
[cx3]=msinclip(freqv,cx2,[],[],450,[],N);
[xpc3,df]=msinprep(freqv,cx3,N,fs,'screen');
xpc3=xpc3/xpscale;
pause

% histogram crested 500 iterations
figure
subplot(211), plot(t,xpc3), axis([0 T -3 3])
title(['multisine crested (500)'])
ylabel('amplitude')
xlabel('time [s]')
subplot(212), hist(xpc3), axis([-3 3 0 500])
xlabel('amplitude')
pause

% 4 segments
N4=N/4;
T4=T/4;
f4=(1:N4/2)/T4;
%periodic signal
freqv=1/T4:1/T4:fcut;
cx=exp(1j*rand(length(freqv),1)*2*pi);
figure(99)
[cx2]=msinclip(freqv,cx,[],[],200,[],N);
[xp_seg,df]=msinprep(freqv,cx2,N4,fs,'screen');
xp_seg=xp_seg/std(xp_seg);
xp4=[xp_seg;xp_seg;xp_seg;xp_seg];

figure
subplot(211),plot(t(1:length(xp_seg)),xp_seg)
title('Crested signal 2.5 seconds')
subplot(212),plot(t,xp4)

Xp3=fft(xpc3);      Xp3=Xp3(2:N/2+1);
Xp_seg=fft(xp_seg); Xp_seg=Xp_seg(2:N4/2+1);
Xp4=fft(xp4);       Xp4=Xp4(2:N/2+1);

figure
subplot(121), stem(f,abs(Xp3)), hold on, axis([0 12 0 300])
title('10 s signal')
subplot(122), stem(f4,abs(Xp_seg),'r'), axis([0 12 0 300])
title('2.5 s signal')
pause
subplot(121), stem(f,abs(Xp4),'r')
pause

figure
plot(f,abs(Xr),'b'), hold on, axis([0 100 0 300])
xlabel('frequency [Hz]')
ylabel('amplitude')
title('Fourier coefficients')
plot(f,abs(Xrf),'r')
n=find(abs(Xp)>mean(abs(Xp)));
plot(f(n),abs(Xp(n)),'mx')
n4=find(abs(Xp4)>mean(abs(Xp4)));
plot(f(n4),abs(Xp4(n4)),'kx')
legend('noise','filtered noise','multisine 10s','multisine 4x 2.5s')

