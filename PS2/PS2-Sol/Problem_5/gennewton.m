function [x,fx,ef,numit] = gennewton(f,x,cc,varargin)

% input arguments:      f           function handle
%                       x           starting values
%                       cc          convergence criteria
%                       varargin    either empty or string 'Newton' or 'Broyden'


%% get convergence criteria, exit flags and dimensionality
tole = cc(1,1); told = cc(2,1); maxiter = cc(3,1);          % assign convergence criteria
ef = 0;                                                     % 0 == no convergence; 1 == convergence;
n = numel(x);                                               % n-dimesnional rootfinder;


%% determine method
nvarargs = length(varargin);
if nvarargs == 1
    method = varargin{1};
else
    method = 'Newton';
end


%% root finding algorithm
h = 1e-6; dfx = zeros(n,n);      
if strcmp(method,'Newton') == 1
    for j0 = 1:maxiter
        if nargout(f) == 2                                      % Jacobian provided;
            [fx, dfx] = f(x);              
        elseif nargout(f) == 1                                  % Jacobian not provided;
            fx = f(x);                    
            for j1 = 1:n                                        % two-sided approximations of Jacobian;
                haux = zeros(n,1); haux(j1,1) = h;   
                dfx(:,j1) = (f(x+haux) - f(x-haux))/(2*h); 
            end
        end
        xp = x - dfx\fx;                                        % Newton step
        D = (norm(x-xp)<=tole*(1+norm(xp)) && norm(fx)<=told);  % check for convergence
        if D == 1;
            ef = 1; break;
        else 
            x = xp;
        end
    end
elseif strcmp(method,'Broyden') == 1
    fx = f(x);                    
    for j1 = 1:n                                        % two-sided approximations of Jacobian;
        haux = zeros(n,1); haux(j1,1) = h;   
        dfx(:,j1) = (f(x+haux) - f(x-haux))/(2*h); 
    end
    for j0 = 1:maxiter
        xp  = x - dfx\fx;
        D = (norm(x-xp)<=tole*(1+norm(xp)) && norm(fx)<=told);  % check for convergence
        if D == 1;
            ef = 1; break;
        else 
            fxp = f(xp);
            dfx = dfx + ( ((fxp-fx) - dfx*(xp-x))*(xp-x)' )/( (xp-x)'*(xp-x) );
            x = xp; fx = fxp;
        end
    end   
else 
    error('method %s not specified \n', method);    
end
numit = j0;
if j0 == maxiter
    x = Inf; fx = Inf; 
end

end