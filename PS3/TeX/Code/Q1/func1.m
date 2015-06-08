function [f1,df1,ddf1] = func1(x)
f1 = 2*x^3-x^2-3*x+2;
df1 = 6*x^2-2*x-3;
ddf1 = 12*x-2;
end
