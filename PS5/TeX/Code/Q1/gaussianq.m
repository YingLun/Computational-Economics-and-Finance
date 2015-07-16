function q = gaussianq(f,n)

mu = 0;
var = 1;
[x,w] = qnwnorm(n,mu,var);
fval = feval(f,x);

if size(fval,2)>1
    q = fval*w;
else
    q = fval'*w;
end