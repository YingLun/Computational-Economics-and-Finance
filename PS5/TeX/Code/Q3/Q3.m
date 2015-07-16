%Q3
clc;clear

%% 1
mu = 0;
sigma =0.25;
n=100;

y1 = 1.02;
Ey1 = 1.02;

[z,w] = qnwnorm(n,0,1);
y2 = @(z)exp(mu+sigma*z);
y2fval = feval(y2,z);
Ey2 = w'*y2fval;

%% 2
gamma = 1.5;

E1 = (y1^(1-gamma)-1)/(1-gamma);

f2 = @(y2)(y2.^(1-gamma)-1)/(1-gamma);
fval = feval(f2,y2fval);
E2 = w'*fval;
disp('Since E1>E2, he will choose project 1.')

%% 3

eps         = 1e-5;
del         = 1e-5;
max_it      = 1e6;
ini_Jac     = 1;
ini_val     = 0.5;
stop_crit   = [eps,del,max_it];

s = @(gamma)udiff(gamma);
gamma = Inverse_Broyden_Method(s,ini_Jac,ini_val,stop_crit);
disp(['gamma is equal to ',num2str(gamma)]);


