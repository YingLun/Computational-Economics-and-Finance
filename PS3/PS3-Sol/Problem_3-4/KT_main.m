clear all; close all;
clc

%% Parameterization
globalvarKT

gam = 2;        % coefficient of relative risk aversion
bet = 0.96;     % time preference
rk = 0.1;       % aggregate return to physical capital
rh = 1.4;      % aggregate return to human capital
eta = 0.8;      % curvature of individual return to human capital
dk = 0.05;      % depreciation rate on physical capital
dh = 0.05;      % depreciation rate on human capital
k = 2;          % curvature of alpha functions

options     = optimset('Display','off', 'MaxIter', 2000, 'MaxFunEvals', 2000, 'TolX', 1e-10, 'TolFun', 1e-10);

%% Solve Model
xini            = [1; 1;-5.5; 1; 1; -3.8; 1;1];

y1              = [1; 5];
f1              = @(x) KTeqs(x,y1);
[x1, fv1, ef1]  = fsolve(f1, xini, options);

if (ef1 == 1 && isreal(x1))
    converged='fsolve converged';
elseif (ef1 ~= 1)
    converged = ['ERROR: fsolve didn"t converge, exitflag = ',num2str(ef1)];
else
    converged = ['ERROR: solution contains imaginary part, exitflag = ',num2str(ef1)];
end
k2= (1-dk) *y1(1) + x1(3);
fprintf('%s k1 = %7.4f; h1 = %7.4f; %s \n', 'Initial values:', y1', converged)
fprintf('Optimal choices: c1 = %7.4f; c2 = %7.4f; ik = %7.4f; ih = %7.4f; k2 = %7.4f  \n', x1(1:4,1)', k2)
if (x1(4) == 0 && k2 == 0)
    disp('Irreversibility and borrowing constraints bind')
elseif (x1(4) == 0 )
    disp('Only irreversibility constraint binds')
elseif (k2 == 0)
    disp('Only borrowing constraint binds')
end
disp(' ');

y2              = [1; 1];
f2              = @(x) KTeqs(x,y2);
[x2, fv2, ef2]  = fsolve(f2, xini, options);

if (ef2 == 1 && isreal(x2))
    converged='fsolve converged';
elseif (ef2 ~= 1)
    converged = ['ERROR: fsolve didn"t converge, exitflag = ',num2str(ef2)];
else
    converged = ['ERROR: solution contains imaginary part, exitflag = ',num2str(ef2)];
end
k2= (1-dk) *y2(1) + x2(3);
fprintf('%s k1 = %7.4f; h1 = %7.4f; %s \n', 'Initial values:', y2', converged)
fprintf('Optimal choices: c1 = %7.4f; c2 = %7.4f; ik = %7.4f; ih = %7.4f; k2 = %7.4f  \n', x2(1:4,1)', k2)
if (x2(4) == 0 && k2 == 0)
    disp('Irreversibility and borrowing constraints bind')
elseif (x2(4) == 0 )
    disp('Only irreversibility constraint binds')
elseif (k2 == 0)
    disp('Only borrowing constraint binds')
else
    disp('No constraint binds')
end
disp(' ');


y3              = [1; 0.2];
f3              = @(x) KTeqs(x,y3);
[x3, fv3, ef3]  = fsolve(f3, xini, options);

if (ef3 == 1 && isreal(x3))
    converged='fsolve converged';
elseif(ef3 ~= 1)
    converged = ['ERROR: fsolve didn"t converge, exitflag = ',num2str(ef3)];
else
    converged = ['ERROR: solution contains imaginary part, exitflag = ',num2str(ef3)];
end
k2= (1-dk) *y3(1) + x3(3);
fprintf('%s k1 = %7.4f; h1 = %7.4f; %s \n', 'Initial values:', y3', converged)
fprintf('Optimal choices: c1 = %7.4f; c2 = %7.4f; ik = %7.4f; ih = %7.4f; k2 = %7.4f  \n', x3(1:4,1)', k2)
if (x3(4) == 0 && k2 == 0)
    disp('Irreversibility and borrowing constraints bind')
elseif (x3(4) == 0 )
    disp('Only irreversibility constraint binds')
elseif (k2 == 0)
    disp('Only borrowing constraint binds')
end
disp(' ');
