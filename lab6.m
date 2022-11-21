close all
clear all
clc

t0=;
g=9.81;

A1= ;
Aw1= ;
H1= ;

A2= ;
Aw2= ;
H2=; 

a1=Aw1*sqrt(2*g*H1)/H1;
a2=Aw2*sqrt(2*g*H2)/H2;

fwe1max=a1*H1;
fwe2max=abs(a2*H2-a1*H1);

%pierwszy przypadek - skok w zbiorniku 1, zbiornik 2 const
fwe20=0.1*fwe2max;
dfwe2=0;
Vfwe10=[0,0.5*fwe1max,0.9*fwe1max];
dfwe1=0.1*fwe1max;

fig1=figure();
for i=1:3
    h10=Vfwe10(i)/a1;
    h20=fwe20/a2;
    fwe10=Vfwe10(i); 
    sim();
    subplot(211);
    hold on;
    grid on;
    plot(ans.tout,ans.h1);
    xlabel('Time [s]')
    ylabel('h1(t)');
    title('Odpowiedź zbiornika nr. 1 na wymuszenie w zbiorniku nr. 1');
    subplot(212);
    hold on;
    grid on;
    plot(ans.tout,ans.h2);
    xlabel('Time [s]')
    ylabel('h2(t)');
    title('Odpowiedź zbiornika nr. 2 na wymuszenie w zbiorniku nr. 1');
end
figure(fig1)
subplot(211);
legend('fwe1=0','fwe1=0.5*fwe1max','fwe1=0.9*fwe1max');
subplot(212);
legend('fwe1=0','fwe1=0.5*fwe1max','fwe1=0.9*fwe1max');

%drugi przypadek - skok w zbiorniku 2, zbiornik 1 const
dfwe1=0;
dfwe2=0.2*fwe2max;
Vfwe20=[0,0.5*fwe2max,0.9*fwe2max];
fwe10=0.1*fwe1max;

fig2=figure();
for i=1:3
    h10=fwe10/a1;
    h20=Vfwe20(i)/a2;
    fwe20=Vfwe20(i);
    sim();
    subplot(211);
    hold on;
    grid on;
    plot(ans.tout,ans.h1);
    xlabel('Time [s]')
    ylabel('h1(t)');
    title('Odpowiedź zbiornika nr. 1 na wymuszenie w zbiorniku nr. 2');
    subplot(212);
    hold on;
    grid on;
    plot(ans.tout,ans.h2);
    xlabel('Time [s]')
    ylabel('h2(t)');
    title('Odpowiedź zbiornika nr. 2 na wymuszenie w zbiorniku nr. 2');
end
figure(fig2)
subplot(211);
legend('','','fwe1=0.1*fwe1max');
subplot(212);
legend('fwe2=0','fwe2=0.5*fwe2max','fwe2=0.9*fwe2max');
