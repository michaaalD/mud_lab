% Michal Dos; nr indeksu : 263498
% Poniedzialek 13.15 TP
% Lab 1

clear; clc; close all;


% Dane o wartosciach nominalnych

QgN= 1000;      % nominalna wartosc mocy grzejnika
TwewN = 20;     % nominalna temperatura wewnatrz
TzewN = -20;    % nominalna temperatura na zewnatrz
TpN = 10;       % nominalna temperatura poddasza
a = 0.4;        % wspolczynnik do wyliczania Kcw
b = 0.6;        % wspolczynnik do wyliczania Kcwp

%Wartosci wspolcznikow wyliczane ze wzorow:

Kcp = (b*QgN)/((TpN-TzewN));
Kcw = (a*QgN)/(TwewN-TzewN);
Kcwp = (b*QgN)/(TwewN-TpN);

Qg = 500:500:2500;
Tzew = -20:5:30;

%Temperatury wyliczane ze wzorów:


%% ogolny uklad rownan
% 0 = Qg - Kcw(Twew - Tzew) - Kcwp(Twew - Tp)
% 0 = Kcwp(Twew - Tp) - Kcp(Tp - Tzew)

%% wzor 
% Kcwp(Twew - Tp) = Kcp(Tp - Tzew)
% Qg = Kcw(Twew - Tzew) - Kcp(Tp - Tzew)
% Qg + Kcp(Tp - Tzew) = Kcw(Twew - Tzew)
% (Qg + Kcp(Tp - Tzew))/Kcw + Tzew = Twew

%% wzor na Tp
% Qg + Kcw(Twew - Tzew) = Kcp(Tp - Tzew)
% (Qg + Kcw(Twew - Tzew))/Kcp + Tzew = Tp

% 
%Twew = ((QgN *(Kcwp+Kcp))/((Kcw*Kcwp) + (Kcw * Kcp) + (Kcwp*Kcp)))+ Tzew ;
%Tp = ( (QgN * Kcwp) /( (Kcw*Kcwp) + (Kcw*Kcp) + (Kcwp*Kcp))) + Tzew ;

figure(1)
hold on; grid on
for i=1:length(Qg)
    Twew = ( (Qg(i)*(Kcwp+Kcp)) / ((Kcw*Kcwp)+(Kcw*Kcp)+(Kcwp*Kcp)) ) + Tzew;
    plot(Tzew,Twew);
    display(Twew);
    display(Tzew(i));
    title('Wykres Twew(Tzew)');
    xlabel('Tzew');
    ylabel('Twew');
    plot(-20,20,'o','MarkerSize',10);
end

 figure(2)
 hold on; grid on
 for i=1:length(Tzew)
    Twew =( (Qg *(Kcwp+Kcp)) / ( (Kcw*Kcwp) + (Kcw * Kcp) + (Kcwp*Kcp) ))+ Tzew(i);    
    display(Twew);
    plot(Qg,Twew);
    title('Wykres Twew(Q)');
    xlabel('Q');
    ylabel('Twew');
    plot(1000,20,'o','MarkerSize',10);
end


% for i=1:length(Tzew)
%     display(Tzew(i))
% end
% 


