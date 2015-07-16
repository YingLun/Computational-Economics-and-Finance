clear, clc

%% Parameters

beta    = 0.96;
alpha   = 0.36;
delta   = 0.06;

m       = 9;
N       = 100;

%% Chebyshev approximation

Kstar   = ((1/beta+delta-1)/alpha)^(1/(alpha-1));
fspace  = fundefn('cheb',m,0.5*Kstar,1.5*Kstar);
K_grid  = funnode(fspace);
T_hat   = funbas(fspace,K_grid);

C_hat   = K_grid.^alpha;
theta   = (T_hat'*T_hat)\(T_hat'*C_hat);

K_uni   = nodeunif(N,0.5*Kstar,1.5*Kstar);
T_new   = funbas(fspace,K_uni);
C_new   = T_new*theta;

fig     = figure;
plot(K_uni,C_new);
print(fig,'-dpng','Q4_5')

%% Path of capital
K_t     = zeros(100,1);
K_t(1)  = 0.5*Kstar;
for t=1:99
    K_t(t+1) = K_Policy(K_t(t),alpha,beta,delta);
end
fig     = figure;
plot(1:100,K_t);
print(fig,'-dpng','Q4_6')

%% Approximation error
% K
K_rand  = 0.5*Kstar+Kstar.*rand(1000,1);
T_rand  = funbas(fspace,K_rand);
C_rand  = T_rand*theta;
% K'
Kprime  = K_Policy(K_rand,alpha,beta,delta);
Tprime  = funbas(fspace,Kprime);
Cprime  = Tprime*theta;
% Error
R       = Cprime-C_rand*beta.*(1+alpha*Kprime.^(alpha-1)-delta);
E       = R./C_rand;

disp(['Max. absolute error = ',num2str(max(abs(E)))])
disp(['Avg. absolute error = ',num2str(mean(abs(E)))])