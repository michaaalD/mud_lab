

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






%Lab11

%zmienne wyjściowe Tw1, Tw2
%zmienne wejściowe Tzew, Tkz, Fk
clear all;
close all;
%wartosci nominalne
TzewN=-20;
Tw1N=20;
Tw2N=15;
TkzN=30;
PkN=20000;
Vw1=4*7*2.5;
Vw2=Vw1*0.8;
cpp=1000;
rop=1.2;

%identyfikacja parametrów statycznych
FkN=PkN/(cpp*rop*TkzN);
Ks1=(cpp*rop*FkN*(TkzN-Tw2N))/(Tw2N+Tw1N-2*TzewN);
Ks2=Ks1;
K0=(-Ks1*(Tw1N-TzewN)+cpp*rop*FkN*(TkzN-Tw1N))/(Tw1N-Tw2N);

%parametry dynamiczne
Cv1=cpp*rop*Vw1;
Cv2=cpp*rop*Vw2;
Fk00=[TkzN-2 TkzN TkzN+1 ];
a= [0.8 1];
for j=1:2
for i=1:3
%warunki poczatkowe
Tzew0=TzewN;
Tkz0=Fk00(i);
Fk0=a(j)*FkN;

%stan równowagi
c=cpp*rop*Fk0;
E=[c+Ks1+K0, -K0; c+K0 -K0-c-Ks2];
F=[c*Tkz0+Ks1*Tzew0; -Ks2*Tzew0];
G=inv(E)*F;
Tw10=G(1);
Tw20=G(2);

%symulacja
ts=2000; %czas symulacji
t0=200; % czas skoku;
dTzew=0;
dTkz=1;
dFk=0;  % uklad liniowy dla dFk=0


%rownania stanu
A=[(-cpp*rop*Fk0-Ks1-K0)/Cv1, K0/Cv1; (K0+cpp*rop*Fk0)/Cv2 (-K0-cpp*rop*Fk0-Ks2)/Cv2];
B=[(cpp*rop*Fk0)/Cv1, Ks1/Cv1; 0, Ks2/Cv2];
C=[1,0;0,1];
D=[0,0;0,0];
trow=[Tw10,Tw20];

%transmitancja
MS=[-Cv1*Cv2, Cv1*(-K0-c-Ks2)-Cv2*(c+Ks1+K0), (c+Ks1+K0)*(-K0-c-Ks2)+K0*(K0+c)];
L1=[-Cv2*Ks1, Ks1*(-K0-c-Ks2)-Ks2*K0];
L2=[-Ks2*Cv1, -Ks2*(K0+c+Ks1)-Ks1*(K0+c)];
L3=[-c*(K0+c)];
L4=[-c*Cv2, c*(-c-K0-Ks2)];


figure(1);
sim('miniprojekttransim');
  

    hold on;
    x=[1,3];
    subplot(4,2,x(j));
    plot(ans.tout,ans.tw1tr);
    xlabel('t[s]');
    ylabel('T[°C]');
    title(['Fk=',num2str(a(j)),'*FkN, dTkz=1°C ']);
    legend('TkzN-2°C','TkzN','TkzN+1°C');
    hold off;

    
    hold on;
    subplot(4,2,j+j);
    plot(ans.tout,ans.tw2tr);
    xlabel('t[s]');
    ylabel('T[°C]');
    title(['Fk=',num2str(a(j)),'*FkN, dTkz=1°C']);
    legend('TkzN-2°C','TkzN','TkzN+1°C');
    hold off;
    
    figure(2);
    sim('miniprojektsim2');
  

    hold on;
    x=[1,3];
    subplot(4,2,x(j));
    plot(ans.tout,ans.tw1rs);
    xlabel('t[s]');
    ylabel('T[°C]');
    title(['Fk=',num2str(a(j)),'*FkN, dTkz=1°C ']);
    legend('TkzN-2°C','TkzN','TkzN+1°C');
    hold off;

    
    hold on;
    subplot(4,2,j+j);
    plot(ans.tout,ans.tw2rs);
    xlabel('t[s]');
    ylabel('T[°C]');
    title(['Fk=',num2str(a(j)),'*FkN, dTkz=1°C']);
    legend('TkzN-2°C','TkzN','TkzN+1°C');
    hold off;

end;
end;
Fk01=[TzewN-1 TzewN TzewN+2 ];
a= [0.8 1];
for j=1:2
for i=1:3
%warunki poczatkowe
Tzew0=Fk01(i);
Tkz0=TkzN;
Fk0=a(j)*FkN;

%stan równowagi
c=cpp*rop*Fk0;
E=[c+Ks1+K0, -K0; c+K0 -K0-c-Ks2];
F=[c*Tkz0+Ks1*Tzew0; -Ks2*Tzew0];
G=inv(E)*F;
Tw10=G(1);
Tw20=G(2);

dTzew=2;
dTkz=0;

%rownania stanu
A=[(-cpp*rop*Fk0-Ks1-K0)/Cv1, K0/Cv1; (K0+cpp*rop*Fk0)/Cv2 (-K0-cpp*rop*Fk0-Ks2)/Cv2];
B=[(cpp*rop*Fk0)/Cv1, Ks1/Cv1; 0, Ks2/Cv2];
C=[1,0;0,1];
D=[0,0;0,0];
trow=[Tw10,Tw20];

%transmitancja
MS=[-Cv1*Cv2, Cv1*(-K0-c-Ks2)-Cv2*(c+Ks1+K0), (c+Ks1+K0)*(-K0-c-Ks2)+K0*(K0+c)];
L1=[-Cv2*Ks1, Ks1*(-K0-c-Ks2)-Ks2*K0];
L2=[-Ks2*Cv1, -Ks2*(K0+c+Ks1)-Ks1*(K0+c)];
L3=[-c*(K0+c)];
L4=[-c*Cv2, c*(-c-K0-Ks2)];


figure(1);
sim('miniprojekttransim');
  

    hold on;
    x=[5,7];
    subplot(4,2,x(j));
    plot(ans.tout,ans.tw1tr);
    xlabel('t[s]');
    ylabel('T[°C]');
    title(['Fk=',num2str(a(j)),'*FkN, dTzew=2°C ']);
    legend('TkzN-2°C','TkzN','TkzN+1°C');
    hold off;

    
    hold on;
    subplot(4,2,j+j+4);
    plot(ans.tout,ans.tw2tr);
    xlabel('t[s]');
    ylabel('T[°C]');
    title(['Fk=',num2str(a(j)),'*FkN, dTzew=2°C']);
    legend('TzewN-1°C','TzewN','TzewN+2°C');
    hold off;
    
    figure(2);
    sim('miniprojektsim2');
  

    hold on;
    x=[5,7];
    subplot(4,2,x(j));
    plot(ans.tout,ans.tw1rs);
    xlabel('t[s]');
    ylabel('T[°C]');
    title(['Fk=',num2str(a(j)),'*FkN, dTzew=2°C ']);
    legend('TzewN-1°C','TzewN','TzewN+2°C');
    hold off;

    
    hold on;
    subplot(4,2,j+j+4);
    plot(ans.tout,ans.tw2rs);
    xlabel('t[s]');
    ylabel('T[°C]');
    title(['Fk=',num2str(a(j)),'*FkN, dTzew=2°C']);
    legend('TzewN-1°C','TzewN','TzewN+2°C');
    hold off;

end;
end;
figure(3)
Fk02=[TkzN-1 TkzN TkzN+2 ];
for i=1:3
%warunki poczatkowe
Tzew0=TzewN;
Tkz0=Fk02(i);
Fk0=FkN;

%stan równowagi
c=cpp*rop*Fk0;
E=[c+Ks1+K0, -K0; c+K0 -K0-c-Ks2];
F=[c*Tkz0+Ks1*Tzew0; -Ks2*Tzew0];
G=inv(E)*F;
Tw10=G(1);
Tw20=G(2);

dTzew=0;
dTkz=-1;

sim('miniprojekt1');
 
    hold on;
    subplot(3,2,1);
    plot(ans.tout,ans.tw1);
    xlabel('t[s]');
    ylabel('T[°C]');
    title('dTkz=-1°C');
    legend('TkzN-1°C','TkzN','TkzN+2°C');
    hold off;

    
    hold on;
    subplot(3,2,2);
    plot(ans.tout,ans.tw2);
    xlabel('t[s]');
    ylabel('T[°C]');
    title('dTkz=-1°C');
    legend('TkzN-1°C','TkzN','TkzN+2°C');
    hold off;
end;
Fk04=[0.7*FkN 0.9*FkN FkN ];
for i=1:3
%warunki poczatkowe
Tzew0=TzewN;
Tkz0=TkzN;
Fk0=Fk04(i);

%stan równowagi
c=cpp*rop*Fk0;
E=[c+Ks1+K0, -K0; c+K0 -K0-c-Ks2];
F=[c*Tkz0+Ks1*Tzew0; -Ks2*Tzew0];
G=inv(E)*F;
Tw10=G(1);
Tw20=G(2);

dTkz=0;
dFk=0.2*FkN;

sim('miniprojekt1');
 
    hold on;
    subplot(3,2,3);
    plot(ans.tout,ans.tw1);
    xlabel('t[s]');
    ylabel('T[°C]');
    title('dFk=0.2*FkN');
    legend('0.7*FkN','0.9*FkN','FkN');
    hold off;

    
    hold on;
    subplot(3,2,4);
    plot(ans.tout,ans.tw2);
    xlabel('t[s]');
    ylabel('T[°C]');
    title('dFk=0.2*FkN');
    legend('0.7*FkN','0.9*FkN','FkN');
    hold off;
end;
Fk03=[TzewN-2 TzewN TzewN+1 ];
for i=1:3
%warunki poczatkowe
Tzew0=Fk03(i);
Tkz0=TkzN;
Fk0=FkN;

%stan równowagi
c=cpp*rop*Fk0;
E=[c+Ks1+K0, -K0; c+K0 -K0-c-Ks2];
F=[c*Tkz0+Ks1*Tzew0; -Ks2*Tzew0];
G=inv(E)*F;
Tw10=G(1);
Tw20=G(2);

dFk=0;
dTzew=2;

sim('miniprojekt1');
 
    hold on;
    subplot(3,2,5);
    plot(ans.tout,ans.tw1);
    xlabel('t[s]');
    ylabel('T[°C]');
    title('dTzew=2°C');
    legend('TzewN-2°C','TzewN','TzewN+1°C');
    hold off;

    
    hold on;
    subplot(3,2,6);
    plot(ans.tout,ans.tw2);
    xlabel('t[s]');
    ylabel('T[°C]');
    title('dTzew=2°C');
    legend('TzewN-2°C','TzewN','TzewN+1°C');
    hold off;
    
    

end;
