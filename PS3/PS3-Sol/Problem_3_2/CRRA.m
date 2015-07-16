%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% caculates CRRA utility function %
% with risk aversion sigma        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function u=CRRA(c)

global sigma;

if c<1e-5
    u = - 1e50;
else
    u = (c^(1-sigma))/(1-sigma);
end