clc;clear;
cepath='/Users/YingLun/Documents/Dropbox/Academic/Postgraduate/GSEFM/PhD/Year 2/Summersemester/computational economics/Applied Computational Economics and Finance/compecon/';
path([cepath 'cetools;' cepath 'cedemos'],path);

%% Parameters

r_min   = -0.08;
r_max   = 0.12;
gamma   = 2;
p       = 0.5;

func    = @(W0)Opt_Comp(W0,r_min,r_max,gamma,p);

W_max   = 50;
W_min   = 0.5;

n_node  = 15;

%% Compute the Chebyshev approximation

fspace  = fundefn('cheb',n_node,W_min,W_max);
W_grid  = funnode(fspace);

C0_hat  = func(W_grid);
T_hat   = funbas(fspace,W_grid);
alpha   = (T_hat'*T_hat)\(T_hat'*C0_hat);

W_new   = linspace(0.5,50,1000)';
T_new   = funbas(fspace,W_new);

C0_new  = T_new*alpha;

true_C  = func(W_new);
fig     = plot(true_C,C0_new);
% print('-dpng',fig)

disp(['Max. percentage error = ',num2str(max((true_C-C0_new)./true_C)*100),'%'])