function intemc = montec(f,n)
% Monte carlo Integration

sum = 0;
x = randn(n,1);

for ii=1:n    
    fval = feval(f,x(ii));
    sum = fval+sum;
end


intemc = sum/n;


