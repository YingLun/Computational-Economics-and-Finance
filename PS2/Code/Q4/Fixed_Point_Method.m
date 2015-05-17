function [roots,xi] = Fixed_Point_Method(func,...
                               ini_val,...
                               stop_crit,saved_val)
%This function perform the fixed point method for root-finding problem.
%        func: a function handle for value of the root-finding problem.
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

if saved_val
    xi = [xold, zeros(length(ini_val),max_it)];
else
    xi = [];
end

while cont
    it = it+1;
    xnew = func(xold);
    if (norm(xold-xnew)<=eps*(1+norm(xnew))) || (it==max_it)
        cont = false;
    end
    xold = xnew;
    if saved_val
        xi(:,it+1) = xnew;
    end
end

if saved_val
    xi = xi(:,1:it+1);
end

if norm(func(xnew)-xnew)<=del
    disp(['Convergence after ',num2str(it),' iterations.'])
    roots = xnew;
else
    disp('Convergence failed.')
    roots = [];
end

end