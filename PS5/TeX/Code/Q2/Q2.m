clear, clc
close all
addpath('/Users/YingLun/Documents/Dropbox/Academic/Postgraduate/GSEFM/PhD/year 2/summersemester/Computational Economics/Applied Computational Economics and Finance/compecon/CEtools');

%% Parameters
rf      = 0.02;

mu      = [0.04,0.06];
Sig1    = 0.1;
Sig2    = 0.2;
rho     = 0.5;
Sigma   = [Sig1^2,rho*Sig1*Sig2;rho*Sig1*Sig2,Sig2^2];

W0      = 100;
Wmin    = (0:10:50)';

gamma   = 1;

tole    = 1e-10; 
told    = 1e-10; 
maxiter = 1e7;
cc      = [tole;told;maxiter];

%% Solving unconstrained problem
n       = [7,7];
[r,w]   = qnwnorm(n,mu,Sigma);
al_hat  = zeros(2,length(Wmin));
ini_al  = [0;0];
for ii=1:length(Wmin)
    fun             = @(alpha)ExpR(r,rf,W0,Wmin(ii),alpha,gamma,w);
    al_hat(:,ii)    = broyden(fun,ini_al,cc);
    ini_al          = al_hat(:,ii);
end

%% Solving constrained problem
amin    = 0;
amax    = 1;
% optset('ncpsolve','type','minmax')
% optset('ncpsolve','maxit',100)
% optset('ncpsolve','showiters',false)
al_hat2 = zeros(2,length(Wmin));
ini_al  = [0.5;0.5];
for ii=1:length(Wmin)
    fun             = @(alpha)ExpR(r,rf,W0,Wmin(ii),alpha,gamma,w);
    al_hat2(:,ii)   = ncpsolve(fun,amin,amax,ini_al);
    ini_al          = al_hat2(:,ii);
end