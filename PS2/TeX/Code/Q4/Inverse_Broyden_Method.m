function roots = Inverse_Broyden_Method(func,ini_Jac,...
                               ini_val,...
                               stop_crit)
%This function perform the Newton's method for root-finding problem.
%        func: a function handle for value of the root-finding problem.
%         Jac: a function handle of the Jacobian function of the problem
%     ini_val: initial value
%   stop_crit: stopping criteria = [eps,del,max_it]

eps = stop_crit(1);
del = stop_crit(2);
max_it = stop_crit(3);
it = 0;
cont = true;

if length(ini_val)==size(ini_val,2)
    xold = ini_val';
else
    xold = ini_val;
end

B = inv(ini_Jac);
fold = func(xold);

while cont
    it = it+1;
    
    xnew = xold-B*fold;
    fnew = func(xnew);
    dx = xnew-xold;
    df = fnew-fold;
    B  = B+((dx-B*df)*dx'*B)/(dx'*B*df);
    if (norm(xold-xnew)<=eps*(1+norm(xnew))) || (it==max_it)
        cont = false;
    end
    xold = xnew;
    fold = fnew;
end

if norm(func(xnew))<=del
    disp(['Convergence after ',num2str(it),' iterations.'])
    roots = xnew;
else
    disp('Convergence failed.')
    roots = [];
end

end