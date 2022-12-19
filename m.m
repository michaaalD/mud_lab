%% Michał Dos miniprojekt PN 13.15
 

TkzN=35;   TzewN=-20;      %wejscia
TwewN=20; TpN=15;                               % wyjscia

       
qkN=20000;
Vw=2.5*8*9; %m^3
Vp=0.5*Vw; %m^3
cp=1000; %cieplo wlasciwe powietrza
rop=1.2;%gestosc powietrza

Tkz=TkzN;
Twew=TwewN;
Tp=TpN;
Tzew=TzewN;
fk=qkN/(cp*rop*Tkz); %wejscie
dTzew=0;
dTkz=0;
dfk=0;

K1=(cp*fk*rop*(Tkz - Twew))/(5*Twew-4*Tzew-Tp);
Kp=(1/4) *K1;
K2=(K1*(Twew-Tp))/(4*(Tp-Tzew));
Cvw=cp*rop*Vw;
Cvp=cp*rop*Vp;
 
% Rownania stanu
A=[(-(cp*fk*rop)-K1-Kp)/Cvw Kp/Cvw; Kp/Cvp -(Kp+K2)/Cvp];
B=[K1/Cvw (Cvp*fk*rop)/Cvw; K2/Cvp 0];
C=[1,0;0,1];
D=[0,0;0,0];

figure(1)
for i = 1:3
    
    
    %punkty rownowagi
    %Twew=(cp*fk*rop*Tkz + K1*Tzew + Kp*Tp)/(cp*fk*rop+K1+Kp);
    %Tp=(Kp*Twew + K2*Tzew)/(Kp+K2);
    
    T0= [Twew Tp];
    sim('miniprojekt_rownania_stanu.slx');
    
    subplot(2,1,1);
    hold on;
    plot(ans.tout,ans.Twew_out);
    xlabel('czas[s]');
    ylabel('T(C)');
    title('Twew (rownania stanu)');
    hold off;

    subplot(2,1,2);
    hold on;
    plot(ans.tout,ans.Tp_out);
    xlabel('t[s]');
    ylabel('T(C)');
    title('Tp (rownania stanu)');
    hold off;
end


% %Transmitancje
% L1 = [A2 a1+a2];
% L2 = [a1];
% L3 = [A1 a1];
% L4 = [a1];
% Ms = [A1*A2 (A1*a1+A1*a2+A2*a1) a1*a2];
% 
% figure(2)
% for i = 1:3
%    
%     sim('miniprojekt_transmitancje.slx');
%     
%   
%     subplot(2,1,1); 
%     hold on;
%     plot(ans.tout,ans.zbiornik1);
%     xlabel('t[s]');
%     ylabel('T(C)');
%     title('Twew');
%     hold off;
% 
%     subplot(2,1,2);
%     hold on;
%     plot(ans.tout,ans.zbiornik2);
%     xlabel('t[s]');
%     ylabel('T(C)');
%     title('Tp');
%     hold off;
% end
% 
% 
% 
% 
% 

% 
% Tkz=TkzN;
% Twew=TwewN;
% Tp=TpN;
% %Tzew=TzewN;
% fk=qkN/(cp*rop*Tkz); %wejscie
% dTzew=0;
% dTkz=0;
% dfk=0;
% figure(2);
% for i=1:3
% 
%     %punkty rownowagi
%     %Twew=(cp*fk*rop*Tkz + K1*Tzew + Kp*Tp)/(cp*fk*rop+K1+Kp);
%     %Tp=(Kp*Twew + K2*Tzew)/(Kp+K2);
%     
%      
%     sim('miniprojekt1_sim.slx');
%     subplot(211);
%     hold on;
%     grid on;
%     plot(ans.tout,ans.Twew_out);
%     xlabel(' czas [s]')
%     ylabel('Twew(C)');
% 
%     subplot(212);
%     hold on;
%     grid on;
%     plot(ans.tout,ans.Tp_out);
%     xlabel('czas [s]')
%     ylabel('Tp(C)');
% end
