function Q5
clc; clear;

EqulibriumFunc = @(q)func(q,1.6);

n=[2;5;10];

for i =1:length(n)
    
ini_Jac=eye(n(i));
ini_val = ones(n(i),1);

eps = 1.e-10;
del = 1.e-10;
max_it = 10000;
stop_crit = [eps,del,max_it];

q = Broyden_Method(EqulibriumFunc,ini_Jac,ini_val,stop_crit);
disp(['Equilibrium Output q = ',num2str(q')]);
end
end

function f = func( q,lambda )
% This function gives the equilibrium output levels.

n=length(q);
xi = 0.6;
f = zeros(n,1);

for i = 1:n
   xi = xi+(i-1)*0.2/(n-1);
   f(i) = sum(q)^(-1/lambda)-1/lambda*sum(q)^(-1/lambda-1)*q(i)-xi*q(i);
end

end