function [x,fx,ef,iter] = invbroyden(f,x,cc)

% convergence criteria
tole = cc(1,1); told = cc(2,1); maxiter = cc(3,1);

% newton algorithm
[fx] = f(x); 
n = length(x); B = eye(n,n);
for j = 1:maxiter
    xp = x - B*fx;
    fxp = f(xp);
    
    xd = xp-x; fxd = fxp - fx;
    Bp = B + (xd-B*fxd)*xd'*B / (xd'*B*fxd);
    D = (norm(x-xp) <= tole*(1+norm(xp)) && norm(fx) <= told);
    if D == 1; 
        break;
    else
        x = xp; fx = fxp; B = Bp; 
    end
end
ef = 0; if D == 1; ef = 1; end
iter = j;