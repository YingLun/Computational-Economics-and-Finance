function roots = Newton_Method(func,Jac,...
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

while cont
    it = it+1;
    xnew = xold-Jac(xold)\func(xold);
    if (norm(xold-xnew)<=eps*(1+norm(xnew))) || (it==max_it)
        cont = false;
    end
    xold = xnew;
end

if norm(func(xnew))<=del
    disp(['Convergence after ',num2str(it),' iterations.'])
    roots = xnew;
else
    disp('Convergence failed.')
    roots = [];
end

end