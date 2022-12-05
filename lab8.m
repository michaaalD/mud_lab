%Lab08

clear all;
close all;
clc;
g=9.81;
t0=5;


%zbiornik gorny
A1=8; 
Aw1=0.8; 
H1=4;

%zbiornik dolny
A2=8; 
Aw2=0.8;
H2=3;

%wspolczynniki linearyzacji
a2=Aw2*sqrt(2*g*H2)/H2;
a1=(Aw1*sqrt(2*g*(H1-H2)))/(H1-H2);


fwej1max = a1*(H1-H2);
fwej2max = a2*H2-fwej1max;

dfwej1=0.1*fwej1max;
fwej2 = 0.1*fwej2max;
dfwej2 =0;

Vfwej0_1 = [0 0.5*fwej1max 0.9*fwej1max];

% Rownania stanu
A =[-a1/A1 a1/A1; a1/A2 -(a1+a2)/A2];
B = [1/A1 0; 0 1/A2];
C= [1,0;0,1];
D= [0,0;0,0];

figure(1)
for i = 1:3
    fwej1 = Vfwej0_1(i);
    %punkty rownowagi
    h1=fwej1/a1+(fwej2+fwej1)/a2;
    h2=(fwej1+fwej2)/a2;
    
    h0= [h1 h2];
    sim('');
    
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
    fwej1 = Vfwej0_1(i);
    h1=fwej1/a1+(fwej2+fwej1)/a2;
    h2=(fwej1+fwej2)/a2;
    fwej1=0;
    sim('');
    
  
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
