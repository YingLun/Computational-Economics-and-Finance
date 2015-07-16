function Kprime = K_Policy(K,alpha,beta,delta)
%This function computes the capital policy rule.


%% Initialization
eps         = 1e-6;
del         = 1e-4;
max_it      = 1e6;
ini_Jac     = eye(length(K));
ini_val     = K;
func        = @(Kprime)((beta*(1+alpha*Kprime.^(alpha-1)-delta)).^(1/alpha).*K-Kprime);
stop_crit   = [eps,del,max_it];

%% Compute C0
Kprime      = Inverse_Broyden_Method(func,ini_Jac,ini_val,stop_crit);

end

