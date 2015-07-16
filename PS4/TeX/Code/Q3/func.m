function alpha = func(p,gamma)
% function for Q3

c = (p/(1-p)).^(-1./gamma);
alpha = max(min(10.2.*(1-c)./(1+c),1),0);

end