function [ExpOut,fjac] = ExpR(r,rf,W0,Wmin,alpha,gamma,w)
%This function computes the expectation given parameters.
%   INPUT:
%       r: Txn matrix of returns
%      rf: scalar of risk-free rate
%      W0: scalar of initial wealth
%    Wmin: scalar of minimum wealth
%   alpha: nx1 vector of portfolio weights
%   gamma: scalar of relative risk aversion coefficient
%       w: Tx1 vector of probabilities
%
%   OUTPUT:
%   ExpOut: nx1 vector of expectation
%     fjac: nxn matrix of Jacobian

n       = size(r,2);
ExpOut  = zeros(n,1);
for ii=1:n
    ExpOut(ii)     = w'*FOC(r,rf,W0,Wmin,alpha,gamma,ii);
end

% if need fjac
if nargout>1
    I       = eye(n);
    fjac    = zeros(n);
    for ii=1:n
        if -alpha(ii)<ExpOut(ii) && ExpOut(ii)<1-alpha(ii)
            for jj=1:n
                fjac(ii,jj) = w'*SOC(r,rf,W0,Wmin,alpha,gamma,ii,jj);
            end
        else
            fjac(ii,:)  = -I(ii,:);
        end
    end
end
end

