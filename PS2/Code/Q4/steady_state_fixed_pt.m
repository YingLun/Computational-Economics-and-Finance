function f = steady_state_fixed_pt(val,alpha_k,alpha_h,s_k,s_h,...
                        delta_k,delta_h,n,g)
%This function compute the value of the functions characterizing the steadt
%state of the human capital augmented Solow grotwh model.

k = val(1);
h = val(2);
y = k^alpha_k*h^alpha_h;

f = [...
    s_k*y-(n+g+delta_k-1)*k;...
    s_h*y-(n+g+delta_h-1)*h];

end