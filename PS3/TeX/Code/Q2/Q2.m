% Problem 2
clear, clc

%% Parameters
theta   = 0.5;
T       = 10;
W       = [10;zeros(T-1,1)];
a0      = 0;
beta    = 0.99;
r       = 0.05;

F       = @(C)Obj(C,theta,beta);
Cons    = @(C)NonLCon(C,W,a0,r);

%% Initialization
cc      = [0.001;0.001;10000];
Hf      = eye(T);
C0      = ones(T,1);

%% Optimization
C       = fmincon(@(C)Obj(C,theta,beta),C0,-eye(T),zeros(T,1),[],[],[],[],@(C)NonLCon(C,W,a0,r));

%% theta->1
theta   = 1+1e-7;
C_star  = fmincon(@(C)Obj(C,theta,beta),C0,-eye(T),zeros(T,1),[],[],[],[],@(C)NonLCon(C,W,a0,r));