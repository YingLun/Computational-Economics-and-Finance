function s = udiff(gamma)
% this function is for Q3

y1 = 1.02;
E1 = (y1^(1-gamma)-1)/(1-gamma);

n = 100;
[z,w] = qnwnorm(n,0,1);
y2 = @(z)exp(0.25*z);
y2fval = feval(y2,z);
f2 = @(y2)(y2.^(1-gamma)-1)/(1-gamma);
fval = feval(f2,y2fval);
E2 = w'*fval;

s = E2-E1;