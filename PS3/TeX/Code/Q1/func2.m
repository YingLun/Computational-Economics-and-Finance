function [f2, df2, ddf2] = func2(x)

f2 = -x*exp(-x);
df2 =  (x-1)*exp(-x);
ddf2 = (2-x)*exp(-x);
end