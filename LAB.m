clc;
clear all;
close all;
fs = 10;
fm = 10;
t=(-fs:1/fm:fs);

%Señal Sac
x = 2*pi*t;
seno = sin(x);
sac = seno./x;
idx = isnan(sac);
sac(idx) = 1;

r = 0;
x = 2*r*pi*t;
cosen = cos(x);
Den = (1-(4*r*t).^2);
cost = cosen./Den;
h = sac.*cost;

r = 0.25;
x = 2*r*pi*t;
cosen = cos(x);
Den = (1-(4*r*t).^2);
cost = cosen./Den;
h1 = sac.*cost;

r = 0.75;
x = 2*r*pi*t;
cosen = cos(x);
Den = (1-(4*r*t).^2);
cost = cosen./Den;
h2 = sac.*cost;

r = 1;
x = 2*r*pi*t;
cosen = cos(x);
Den = (1-(4*r*t).^2);
cost = cosen./Den;
h3 = sac.*cost;


figure(1)
plot(t,h,'b','LineWidth',2);
hold on
plot(t,h1,'m','LineWidth',2);
plot(t,h2,'r','LineWidth',2);
plot(t,h3,'c','LineWidth',2);
legend('roll-off=0','roll-off=0.25','roll-off=0.75','roll-off=1');
grid on
xlabel('Tiempo')
ylabel('Amplitud')
title('Respuesta en tiempo')

%Ahora sacamos la respuesta en frecuencia
L = length(h);%Largo de datos de tiempo
n = 2^nextpow2(L);
f = fs*(0:(n/2))/n;

%|H|
fft_h = fft(h,n);
P_h = abs(fft_h/n).^2;

%|H1|
fft_h = fft(h1,n);
P_h1 = abs(fft_h/n).^2;

%|H2|
fft_h = fft(h2,n);
P_h2 = abs(fft_h/n).^2;

%|H3|
fft_h = fft(h3,n);
P_h3 = abs(fft_h/n).^2;


figure(2)
plot(f,P_h(1:n/2+1),'b','LineWidth',2);
hold on

plot(f,P_h1(1:n/2+1),'m','LineWidth',2);
plot(f,P_h2(1:n/2+1),'r','LineWidth',2);
plot(f,P_h3(1:n/2+1),'c','LineWidth',2);
legend('roll-off=0','roll-off=0.25','roll-off=0.75','roll-off=1');
grid on
xlabel('Frecuencia')
ylabel('Amplitud')
title('Respuesta en Frecuencia')


%%%%%%%%%%%%%%%%%%%%%%%%NOSEEEEEEEEEEEEEEEEE%%%%%%%%%%%%%%%%%%%%%
G = fft(h,1024);
G1 = fft(h1,1024);
G2 = fft(h2,1024);
G3 = fft(h3,1024);

figure
plot([-512:511]/1024*fs, abs(fftshift(G)),'b','LineWidth',2);
hold on
plot([-512:511]/1024*fs, abs(fftshift(G1)),'m','LineWidth',2);
plot([-512:511]/1024*fs, abs(fftshift(G2)),'c','LineWidth',2);
plot([-512:511]/1024*fs, abs(fftshift(G3)),'r','LineWidth',2);
legend('r=0','r=0.25','r=075','r=1');
axis([-2 2 0 14])
grid on