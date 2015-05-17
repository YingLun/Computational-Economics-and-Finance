function roots = gauss_seidel(func, deri_func, ini_val, stop_crit,dampening)
%This function implement the Gauss-Seidel fixed point iteration.
%        func: a set of function handles in a cell object.
%   deri_func: a set of derivative functions
%     ini_val: initial value
%   stop_crit: stopping criteria = [eps,del,max_it]
eps = stop_crit(1);
del = stop_crit(2);
max_it = stop_crit(3);

it = 0;
cont = true;

if length(ini_val)==size(ini_val,2)
    xi = ini_val';
else
    xi = ini_val;
end

X_rec = zeros(2,max_it);

no_func = length(func);
x_tilde = zeros(no_func,1);

while cont
    it = it+1;
    xtmp_old = xi;
    for ifun = 1:no_func
        x_tilde(ifun) = xi(ifun) - func{ifun}(xi)/deri_func{ifun}(xi);
        xi(ifun) = dampening*x_tilde(ifun)+(1-dampening)*xi(ifun);
    end
    
%     for ifun = 1:no_func
%         x_tilde(ifun) = xi(ifun) - func{ifun}(xi)/deri_func{ifun}(xi);
%     end
%     xi = dampening*x_tilde+(1-dampening)*xi;

    if (norm(xtmp_old-xi)<=eps*(1+norm(xi))) || (it==max_it)
        cont = false;
    end
    X_rec(:,it) = xi;
end

fval = zeros(no_func,1);
for ifun = 1:no_func
    fval(ifun) = func{ifun}(xi);
end
if norm(fval)<=del
    disp(['Convergence after ',num2str(it),' iterations.'])
    roots = xi;
else
    disp('Convergence failed.')
    roots = [];
end

end

