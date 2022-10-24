% Michal Dos 263498
% grupa poniedzialek 13.15
% lab 2

%% rownanie ax'' + bx' + cx = ku



close all; clear; clc; hold on; grid on;

% subplot(2,3,1)

u0 = ones([1,101])*1/2;
t = 0:0.1:10;
C1 =  -8/3*exp((-3/2)*t);
C2 =  4*exp((-1)*t);
xwy = 2/3;
xsz1 = C1 + C2 + xwy;

xlabel('t');
ylabel('x(t)');
title('u(t)=1, x.(0)=0, x(0)=2');
plot(t, C1,'--g');
plot(t,C2,'--b');
plot(t,xsz1, 'k');
plot(t,u0, '-.r');

legend( 'x1(t) = -(8/3)*exp((-3/2)*t' , 'x2(t) = 4*exp((-1)*t',  'x(t) = x1(t)+x2(t)+x0(t)','x0(t) = 2');
hold off;
