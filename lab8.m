
%Lab08

clear all;
close all;
clc;
g=9.81;
t0=5;


%zbiornik gorny
A1=4; Aw1=0.4; H1=9;

%zbiornik dolny
A2=4; Aw2=0.4; H2=6;

%wspolczynniki linearyzacji
a2=sqrt(2*g*Aw2*Aw2/H2);
a1=sqrt((2*g*Aw1*Aw1)/(H1-H2));

%maksymalne wartosci przeplywu wejsciowego
Fwe1max = a1*(H1-H2);
Fwe2max = a2*H2-Fwe1max;

dFwe1=0.1*Fwe1max;
Fwe2 = 0.1*Fwe2max;
dFwe2 =0;

Fwe1tab = [0 0.5*Fwe1max 0.9*Fwe1max];

% Rownania stanu
A =[-a1/A1 a1/A1; a1/A2 -(a1+a2)/A2];
B = [1/A1 0; 0 1/A2];
C= [1,0;0,1];
D= [0,0;0,0];

figure(1)
for i = 1:3
    Fwe1 = Fwe1tab(i);
    %punkty rownowagi
    h1=Fwe1/a1+(Fwe2+Fwe1)/a2;
    h2=(Fwe1+Fwe2)/a2;
    
    h0= [h1 h2];
    sim('rowstansim08');
    
    subplot(2,1,1);
    hold on;
    plot(ans.tout,ans.gornyrow);
    xlabel('t[s]');
    ylabel('h(t)');
    title('Zbiornik gorny (metoda rownan stanu)');
    hold off;

    subplot(2,1,2);
    hold on;
    plot(ans.tout,ans.dolnyrow);
    xlabel('t[s]');
    ylabel('h(t)');
    title('Zbiornik dolny (metoda rownan stanu)');
    hold off;
end

%Transmitancja
L1 = [A2 a1+a2];
L2 = [a1];
L3 = [A1 a1];
L4 = [a1];
MS = [A1*A2 (A1*a1+A1*a2+A2*a1) a1*a2];

figure(2)
for i = 1:3
    Fwe1 = Fwe1tab(i);
    h1=Fwe1/a1+(Fwe2+Fwe1)/a2;
    h2=(Fwe1+Fwe2)/a2;
    Fwe1=0;
    sim('transmitancjasim');
    
  
    subplot(2,1,1); 
    hold on;
    plot(ans.tout,ans.gornytr);
    xlabel('t[s]');
    ylabel('h(t)');
    title('Zbiornik gorny (metoda transmitancji) ');
    hold off;

    subplot(2,1,2);
    hold on;
    plot(ans.tout,ans.dolnytr);
    xlabel('t[s]');
    ylabel('h(t)');
    title('Zbiornik dolny (metoda transmitancji) ');
    hold off;
end
