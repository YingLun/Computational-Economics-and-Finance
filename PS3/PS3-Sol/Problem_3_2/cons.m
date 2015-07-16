%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculates consumption profile %
% from saving profile            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function c = cons(s)

global T r w;

c(1) = w(1)-s(1);                       % first period

for t=2:(T-1)                           % interior periods
    c(t) = w(t) - s(t) + (1+r)*s(t-1); 
end

c(T) = w(T) + (1+r)*s(T-1);             % last period
