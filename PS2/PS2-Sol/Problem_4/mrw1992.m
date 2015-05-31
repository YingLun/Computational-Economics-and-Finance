function [xp] = mrw1992(x,y)


k = x(1,1); h = x(2,1);
sk = y(1,1); sh = y(2,1); n = y(3,1); g = y(4,1); deltak = y(5,1); deltah = y(6,1); z = y(7,1); alphak = y(8,1); alphah = y(9,1);

xp = [(sk*z*k^(alphak)*h^(alphah)+(1-deltak)*k)/((1+n)*(1+g));...
    (sh*z*k^(alphak)*h^(alphah)+(1-deltah)*h)/((1+n)*(1+g))];
