%%%%%%%%%%%%%%%%%%%%%%%
% Newton minimization %
% Ex. 1.1             %
%%%%%%%%%%%%%%%%%%%%%%%

function [xm,fm] = newtonmin(func,funcd,funcdd,x0)

eps = 1e-5;   % precision parameter in stopping rule
xold = x0;

f0 = feval(func,x0);

iter = 0;
maxit = 100;
xold = x0;
fd = feval(funcd,x0);
fdd = feval(funcdd,x0);

while abs(fd)>eps
   
    iter = iter + 1;
    xnew = xold - fd/fdd;
    fd = feval(funcd,xnew);
    fdd = feval(funcdd,xnew);
    xold = xnew;
    
    if iter>maxit;
        break
    end
end

% for it = 1:maxit,
%    
%     xnew = xold - fd/fdd;
%     fd = feval(funcd,xnew);
%     fdd = feval(funcdd,xnew);
%     xold = xnew;
%     
%     if abs(fd)<eps,
%         break
%     end
% end



if iter>100
    error('Newton did not converge')
else
    xm = xold;
    fm = feval(func,xm);
end