

%Zmienne wejsciowe Tzew,qg,fp
%Zmienne wejsciowe (stanu) Twew, Tp

clear all;
close all;
%========= 1. Identyfikacja =============
%wartosci nominalne
TzewN=-20; %oC      
TwewN=20; %oC        
TpN=10; %oC      
qgN=20000; %W
Vw=2.5; %m^3
Vp=1.25; %m^3
fpN=0.2; %m^3/s
cp=1000; %cieplo wlasciwe powietrza
rop=1.2;%gestosc powietrza
a1=0.55;
a2=0.45;
%.............................
%identyfikacja parametrow statycznych
K1=(a1*qgN)/(TwewN-TzewN);
Kp=(a2*qgN)/(TwewN-TpN);
K2=(a2*qgN - cp*rop*fpN*(TpN-TzewN))/(TpN-TzewN);
%.............................
%identyfikacja paramterow dynamicznych
Cvw=cp*rop*Vw; %pojemnosc cieplna wnetrza
Cvp=cp*rop*Vp; %pojemnosc cieplna poddasza

%========= 2. Punkty pracy =============
Tzew0=TzewN ; % [+0 , +10 , +20]
qg0=qgN * 0.8; %[1.0 0.7 0.5]
fp0=fpN * 0.5; %[1.0 0.7 0.5]
%..........................
%pkty rownowagi
Tp0=(Tzew0*(Kp*K1 + (K2+cp*rop*fp0)*(K1+Kp))+Kp*qg0)/(K1*Kp+(K1+Kp)*(K2+cp*rop*fp0));
Twew0=(qg0+Kp*Tp0+K1*Tzew0)/(K1+Kp);

%========= 3. Symulacja =============
%parametry
czas_symulacji=100;
t0=10;
dfp=0*fpN;
dqg=0.2*qgN;
dTzew=-2;
%%%%%%%%%%  a. BADANIA MODELU NIELINIOWEGO %%%%%%%%%%%%%
% 
% model='Rak_miniprojekt_si.slx';
% 
% sim(model,czas_symulacji);
% figure(1)
% subplot(211)
% plot(ans.tout,ans.Twew);
% xlabel('t [s]');
% ylabel('Twew(t)');
% title('Temperatura wnętrza (Model nieliniowy)');
% grid on
% subplot(212);
% plot(ans.tout,ans.Tp);
% xlabel('t [s]');
% ylabel('Tp(t)');
% title('Temperatura poddasza (Model nieliniowy)');
% grid on

%%%%%%%%%%  b. BADANIA ZA POMOCA ROWNAN STANU  %%%%%%%%%%%%%

%Definicja macierzy
A=[(-K1-Kp)/Cvw , Kp/Cvw ; Kp/Cvp , (-Kp-K2-cp*rop*fp0)/Cvp];
B=[K1/Cvw 1/Cvw ; (K2+cp*rop*fp0)/Cvp 0];
C=[1 0;0 1];
D=[0 0 ; 0 0];
%.....................
%stan równowagi
u0=[Tzew0;qg0];
VT0=-A^-1 * B *u0;

%symulacja
czas_symulacji=100;
t0=10;
model='Rak_miniprojekt_statespace_si.slx';

sim(model,czas_symulacji);
figure(2)
subplot(211)
plot(ans.tout,ans.Twew)
grid on
xlabel('t [s]');
ylabel('Twew(t)');
title('Temperatura wnętrza (Rownania stanu)');
subplot(212)
plot(ans.tout,ans.Tp)
grid on
xlabel('t [s]');
ylabel('Tp(t)');
title('Temperatura poddasza (Rownania stanu)');

%%%%%%%%%%  c. BADANIA ZA POMOCA TRANSMITANCJI  %%%%%%%%%%%%%
%===== Punkty pracy, parametry, definicje ========
%Definicja transmitancji
M=[Cvw*Cvp, Cvw*Kp+Cvw*K2+Cvw*cp*rop*fp0+Kp*Cvp+K1*Cvp, K1*Kp+K1*K2+K1*cp*rop*fp0+Kp*K2+Kp*cp*rop*fp0];
LTzew_1 = [K1*Cvp,K1*(Kp+K2+cp*rop*fp0)+Kp*(K2+cp*rop*fp0)];
Lqg_1 = [Cvp,Kp+K2+cp*rop*fp0];
LTzew_2 = [K2+cp*rop*fp0,(K2+cp*rop*fp0)*(K1+Kp)+Kp*K1];
Lqg_2 = Kp;

%symulacja
czas_symulacji=100;
t0=10;
model='Rak_miniprojekt_transmit_si.slx';

sim(model,czas_symulacji);
figure(3)
subplot(211)
plot(ans.tout,ans.Twew)
grid on
xlabel('t [s]');
ylabel('Twew(t)');
title('Temperatura wnetrza (Transmitancje)');
subplot(212)
plot(ans.tout,ans.Tp)
grid on
xlabel('t [s]');
ylabel('Tp(t)');
title('Temperatura poddasza (Transmitancje)');
