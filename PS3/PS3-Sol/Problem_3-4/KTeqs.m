function  [foc] = KTeqs(x,y)

globalvarKT

% control variables
c1 = x(1,1); c2 = x(2,1); 
ik = x(3,1); ih = x(4,1); 
alphak = x(5,1); alphah = x(6,1);
mu1 = x(7,1); mu2 = x(8,1);

% state variables
k1 = y(1,1); h1 = y(2,1);

% Kuhn-Tucker equations
foc(1,1) = c1^(-gam) + mu1;
foc(2,1) = bet * c2^(-gam) + mu2;
foc(3,1) = max(alphak,0)^k + mu1 -mu2*(1+rk);
foc(4,1) = max(alphah,0)^k + mu1 -mu2*rh*eta*((1-dh)*h1+ih)^(eta-1);
foc(5,1) = max(-alphak,0)^k -((1-dk)*k1 + ik);
foc(6,1) = max(-alphah,0)^k -ih;
foc(7,1) = c1 - (rk*k1 + rh*h1 - ik - ih);
foc(8,1) = c2 - ((1+rk)*((1-dk)*k1 + ik) + rh*((1-dh)*h1+ih)^(eta));

