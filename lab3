%lab4
%Michal Dos 263498
%PN 13:15


clear all; close all; clc;

symulacja = 'dos_lab4_si.slx';

t0=0; %czas skoku
a=8; %wspolczynnik x'
b=9; %wspolczynnik x
u0=12; %Wymuszenie
du=0; %skok

warunki_poczatkowe=[0,14,0,11]; 
titles=[" x'(0)=0" " x'(0)=14" " x(0)=0" " x(0)=11"];

%rozwiazania symulacyjne
figure
for i=1:4
   x0=warunki_poczatkowe(i);
   sim(symulacja);
   subplot(2,2,i);
   plot(ans.tout,ans.xout); 
   grid on;
   title(strcat('Rozwiazanie symulacyjne dla ',titles(i))); 
   xlabel('t[s]');
   ylabel('x(t)');
end

%rozwiazania analityczne
figure;

u0 = ones([1,101])*12;
t = 0:0.1:10;
C1 =  4/3;
C2 =  -4/3 * exp((-9/8)*t);
xwy = 2/3;
xsz1 = C1 + C2 + xwy;

xlabel('t');
ylabel('x(t)');
title('u(t)=1, x.(0)=0, x(0)=2');
plot(t, C1,'--g');
plot(t,C2,'--b');
plot(t,xsz1, 'k');
plot(t,u0, '-.r');

hold off;



figure;

subplot(221)
x2= 4/3 + (-4/3) * exp((-9/8)*t);
xw2=12*ones(1,length(t));

hold on;
plot(t,x2);
plot(t,xw2,'--');

grid on;
ylabel('x2(t)');
xlabel('t[s]');
legend('Rozwiazanie','Rozwiazanie wymuszone');
title(strcat('Rozwiazanie analityczne dla ',titles(2)))

