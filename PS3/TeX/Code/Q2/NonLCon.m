function [Con,ConEq] = NonLCon(C,W,a0,r)
%This function computes the constraint conditions.

T       = length(C);
A       = [a0;zeros(T,1)];
for t=1:T
    A(t+1) = (1+r)*A(t)-C(t)+W(t);
end

Con     = -A(T+1);

ConEq  = -(C+A(2:end)-A(1:end-1)*(1+r)-W);
end

