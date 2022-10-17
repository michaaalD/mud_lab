% Michal Dos 263498
% Poniedzialek 13.15 TP
% Lab 1

clear; clc; close all;
hold on; grid on;

% Dane o wartosciach nominalnych

QgN= 1000;     % nominalna wartosc mocy grzejnika
TwewN = 20;    % nominalna temperatura wewnatrz
TzewN = -20;   % nominalna temperatura na zewnatrz
TpN = 10;      % nominalna temperatura "przewodzenia" sufitu
a = 0.4;        % wspolczynnik do wyliczania Kcw
b = 0.6;        % wspolczynnik do wyliczania Kcwp

%Wartosci wspolcznikow wyliczane ze wzorow:

Kcp = (5*QgN)/(5*(TpN-TzewN));
Kcw = (a*QgN)/(TwewN-TzewN);
Kcwp = (b*QgN)/(TwewN-TpN);

Qg = 0:500:5500;
Tzew = -30:5:30;

%Temperatury wyliczane ze wzorów:


%% ogolny uklad rownan
% 0 = Qg - Kcw(Twew - Tzew) - Kcwp(Twew - Tp)
% 0 = Kcwp(Twew - Tp) - Kcp(Tp - Tzew)

%% wzor na Twew
% Kcwp(Twew - Tp) = Kcp(Tp - Tzew)
% Qg = Kcw(Twew - Tzew) - Kcp(Tp - Tzew)
% Qg + Kcp(Tp - Tzew) = Kcw(Twew - Tzew)
% (Qg + Kcp(Tp - Tzew))/Kcw + Tzew = Twew

%% wzor na Tp
% Qg + Kcw(Twew - Tzew) = Kcp(Tp - Tzew)
% (Qg + Kcw(Twew - Tzew))/Kcp + Tzew = Tp


Twew = (Qg + Kcp*(Tp - Tzew))/Kcw + Tzew ;
Tp = (Qg + Kcw*(Twew - Tzew))/Kcp + Tzew ;

%wykresy
figure(1)
for i=1:length(Tzew)
    plot(Tzew,Twew);
    plot(-20,20,'o');
    xlabel('Tzew');
    ylabel('Twew');
    title('Charakterystyka Twew(Tzew)');
end

%Charakterystyka Tp(Tzew)
figure(2)
for j=1:length(Tzew)
    plot(Tzew,Tp);
    plot(-20,10,'o');
    xlabel('Tzew');
    ylabel('Tp');
    title('Charakterystyka Tp(Tzew)');
    
end
