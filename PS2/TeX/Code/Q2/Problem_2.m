
%% 2.2
clc;clear;

f1=@(x)x^3+4-1/x;
[x1, ~] = bisection(f1,[0.1;1],[10^-6;10^-6]);
disp(['the root is' ' ' num2str(x1)]); 

f2=@(x)-exp(-x)+exp(-x^2);
[x2, ~] = bisection(f2,[0.2;2],[10^-6;10^-6]);
disp(['the root is' ' ' num2str(x2)]); 


%% 2.3
f = @(q)q^0.5+0.5*q-2;

% with bisection
[q, ~] = bisection(f,[1;2],[10^-6;10^-6]);
disp(['the root is' ' ' num2str(q)]); 
% with fzero
q = fzero(f,1);
disp(['the root is' ' ' num2str(q)]); 
% Gauss seidel fixed point
a = 3;
b = 0.5;
c = 1;
d = 1;
psi = 0.5;

%X=[q,p]

g1 = @(X)X(2)-a+b*X(1);
g2 = @(X)X(2)-c-d*X(1)^psi;
dg1 = @(X)b;
dg2 = @(X)1;

g = {g1,g2};
dg = {dg1,dg2};

ini_val = [0.1;0.1];
eps = 0.00001;
del = 0.001;
max_it = 10000;
dampening = 1;
stop_crit = [eps,del,max_it];

X = gauss_seidel(g,dg,ini_val,stop_crit,dampening);

%X=[p,q]
g1 = @(X)X(1)-a+b*X(2);
g2 = @(X)X(1)-c-d*X(2)^psi;
dg1 = @(X)1;
dg2 = @(X)-d*psi*X(2)^(psi-1);

g = {g1,g2};
dg = {dg1,dg2};
X = gauss_seidel(g,dg,ini_val,stop_crit,dampening);

dampening = 0.5;
X = gauss_seidel(g,dg,ini_val,stop_crit,dampening);