function F = Obj(C,theta,beta)
%OBJ computes the function value of the objective function.
%   INPUT:
%           C = T*1 vector of comsumption stream
%       theta = relative risk aversion coefficient
%        beta = discount factor
%
%   OUTPUT:
%           F = function value

T       = length(C);
dis_fac = beta.^((0:T-1)');
if theta==1
    theta = theta+1e-7;
end
F       = -sum(dis_fac.*((C.^(1-theta)-1)/(1-theta)));

disp(['F = ',num2str(-F)])

end

