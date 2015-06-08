%Problem 4
clear, clc

%% Parameters
rf  = 0.02;
rl  = -0.08;
rh  = 0.12;
phi = -3;
p   = 0.1;

%% Q2
f   = @(alpha)-obj_fun(alpha,phi,rf,rh,rl,p);
alpha_q2 = fminunc(f,0.5);
plot(alpha_q2-1:0.1:alpha_q2+1,-f(alpha_q2-1:0.1:alpha_q2+1))

%% Q3
alpha_q3a = fminbnd(f,0,1);
alpha_q3b = fmincon(f,0.5,[],[],[],[],0,1);