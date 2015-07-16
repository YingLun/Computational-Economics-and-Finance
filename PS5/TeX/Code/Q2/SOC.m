function output = SOC(r,rf,W0,Wmin,alpha,gamma,ii,jj)
%This function computes the FOC values given parameters.
%   INPUT:
%       r: Txn matrix of returns
%      rf: scalar of risk-free rate
%      W0: scalar of initial wealth
%    Wmin: scalar of minimum wealth
%   alpha: nx1 vector of portfolio weights
%   gamma: scalar of relative risk aversion coefficient
%   ii,jj: scalars of asset label
%
%   OUTPUT:
%   output: Tx1 vector of output

output  = -gamma.*(((1+rf+(r-rf)*alpha).*W0-Wmin).^(-gamma-1)).*(r(:,ii)-rf).*(r(:,jj)-rf)*W0^2;

end

