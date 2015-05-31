function [fx,dfx] = mrw1992SS(x,y)


k = x(1,1); h = x(2,1);
sk = y(1,1); sh = y(2,1); n = y(3,1); g = y(4,1); deltak = y(5,1); deltah = y(6,1); z = y(7,1); alphak = y(8,1); alphah = y(9,1);

fx = [k - (sk*z*k^(alphak)*h^(alphah)+(1-deltak)*k)/((1+n)*(1+g));...
    h - (sh*z*k^(alphak)*h^(alphah)+(1-deltah)*h)/((1+n)*(1+g))];

dfx = [1 - (sk*alphak*z*k^(alphak-1)*h^(alphah) + (1-deltak))/((1+n)*(1+g)), - (sk*z*alphah*k^(alphak)*h^(alphah-1))/((1+n)*(1+g));...
    - (sh*alphak*z*k^(alphak-1)*h^(alphah))/((1+n)*(1+g)), 1 - (sh*alphah*z*k^(alphak)*h^(alphah-1)+(1-deltah))/((1+n)*(1+g))];