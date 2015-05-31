function [x,fx,ef,iter] = newton(f,x,cc)

% convergence criteria
tole = cc(1,1); told = cc(2,1); maxiter = cc(3,1);

% newton algorithm
for j = 1:maxiter
    [fx,dfx] = f(x); 
    xp = x - dfx\fx;
    D = (norm(x-xp) <= tole*(1+norm(xp)) && norm(fx) <= told);
    if D == 1; 
        break;
    else
        x = xp;
    end
end
ef = 0; if D == 1; ef = 1; end
iter = j;