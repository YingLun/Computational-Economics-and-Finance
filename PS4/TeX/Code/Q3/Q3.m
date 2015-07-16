
clc;clear;


% parameters
p = 0.8; % probability
gamma_min = 1;
gamma_max = 50;
n_node = 15;
fspace  = fundefn('cheb',n_node,gamma_min,gamma_max);
gamma_grid  = funnode(fspace);
T = funbas(fspace,gamma_grid);
y =  func(p,gamma_grid);
c = (T'*T)\(T'*y);

gamma = linspace(1,50,1000);
T_new = funbas(fspace,gamma');
alpha = T_new*c;


% plot alpha against gamma
plot(gamma,alpha,'k','LineWidth',1.2);
ylabel('$\alpha$','Interpreter','latex');
xlabel('$\gamma_i$','Interpreter','latex');
title('$\alpha$ against $\gamma_i$','Interpreter','latex');