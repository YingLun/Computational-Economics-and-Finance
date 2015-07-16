function C0 = Opt_Comp(W0,r_min,r_max,gamma,p)
%This function computes the optimal consumption C0*
%   INPUT:
%       W0: initial wealth
%    r_min: return at bad state
%    r_max: return at good state
%    gamma: risk aversion coefficient
%        p: probability of good state
%
%   OUTPUT:
%       C0: optimal consumption at t=0

%% Initialization
eps         = 1e-5;
del         = 1e-5;
max_it      = 1e6;
ini_Jac     = eye(length(W0));
ini_val     = W0/2;
func        = @(C)((p*(W0*(1+r_max)-C).^(-gamma)+(1-p)*(W0*(1+r_min)-C).^(-gamma)).^(-1/gamma)-C);
stop_crit   = [eps,del,max_it];

%% Compute C0
C0          = Inverse_Broyden_Method(func,ini_Jac,ini_val,stop_crit);

end

