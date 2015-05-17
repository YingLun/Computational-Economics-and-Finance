function [x fx] = bisection(f,x,cc )
% This function calculate the root for f using bisection method.

xl = x(1,1);
xh = x(2,1);
fl = f(xl);
fh = f(xh);

tole = cc(1,1);
told = cc(2,1);

if fl*fh>0
    disp('initial [xl, xh] don''t bracket a root');
    x = -Inf; fx = -Inf; ef = 0;
    return
end

% bisection
while (xh-xl)>tole*(1+abs(xl)+abs(xh)) || abs(fm)>told
    xm = (xl+xh)/2;
    fm = f(xm);
    if fl*fm < 0
        xh = xm; fh = fm;
    else
        xl = xm; fl = fm;
    end

end
x = xm; fx = fm;  
end
