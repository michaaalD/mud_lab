%% lab 7 13.15 

clear; close all; clc;
g=9.81;

%zbiornik 1
A1=8; % powierzchnia dna 
Aw1=0.8; % powierzchnia otworu
H1=4;    %wysokosc zbironika
a1=Aw1* sqrt(2*g*(H1-H2))/(H1-H2);  %wspolczyunnik linearyzacjii
fwej1max = a1*(H1-H2);              % max trumien fwej1
dfwej1 = 0.1*fwej1max;
Vfwej0_1=[0,0.5*fwej1max,0.9*fwej1max];

%zbiornik 2
A2=8;
Aw2=0.8;
H2=3;
a2=Aw2*sqrt(2*g*H2)/H2;
fwej2max=a2*H2 - fwej1max;
fwej0_2=0.1*fwej2max;
dfwej2=0;


%skok w zbiorniku 1, zbiornik 2 const

for i=1:3
    h10=Vfwej0_1(i)/a1;
    h20=(fwej0_2+Vfwej0_1(i))/a2;
    fwej0_1=Vfwej0_1(i); 
    sim('dos_lab6sim.slx');
    subplot(211);
    hold on;
    grid on;
    plot(ans.tout,ans.h1);
    xlabel(' czas [s]')
    ylabel('H1(t)');
    title('Odpowiedź zbiornika 1 na skok w zbiorniku 1');
    subplot(212);
    hold on;
    grid on;
    plot(ans.tout,ans.h2);
    xlabel('czas [s]')
    ylabel('H2(t)');
    title('Odpowiedź zbiornika 2 na skok w zbiorniku 1');
end

subplot(211);
legend('fwej0_1=0','fwej0_1=0.5*fwej1max','fwej0_1=0.9*fwe1max');
subplot(212);
legend('fwej0_1=0','fwej0_1=0.5*fwej0_1max','fwej0_1=0.9*fwej1max');

