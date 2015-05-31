%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% biseczero.m calculates a zero of the %
% function 'func' between the points a %
% and c by the bisection method        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function xz = biseczero(func,a,c)

eps = 1e-5;           % precision parameter in stopping rule 

fa = feval(func,a);
fc = feval(func,c);

if (fa*fc>0 | (a>c) )
    error('initial points unsuitable!')
end

dist = c-a;

while dist>eps         
    b = (a+c)/2;       % calculation of midpoint
    fb = feval(func,b);

    if fa*fb<0
        c = b;
        fc = fb;
    elseif fb*fc<0
        a = b;
        fa = fb;
    end
    
    dist = c - a;
end

xz = b;
        