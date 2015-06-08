function U = obj_fun(alpha,phi,rf,rh,rl,p)
%This function calcualtes the expected utility value of given parameters.

U   = p.*(1./phi).*(1+rf+alpha.*(rl-rf)).^phi+...
        (1-p).*(1./phi).*(1+rf+alpha.*(rh-rf)).^phi;

end

