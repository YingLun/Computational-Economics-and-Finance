f1=@(x)func1(x);
f2=@(x)func2(x);
[x1,fx1,ef1] = newton(f1,0,[10^-6;10^-6;1e4]);
[x2,fx2,ef2] = newton(f2,0,[10^-6;10^-6;1e4]);
