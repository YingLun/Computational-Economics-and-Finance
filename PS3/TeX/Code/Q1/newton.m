function [x,fx,ef] = newton(f,x,cc)

tole = cc(1,1);
told = cc(2,1);
maxiter = cc(3,1);
ef = 0;

for j = 1:maxiter
   [fx,dfx,ddfx] = f(x);
   xp = x-ddfx\dfx';
   if norm(x-xp)<=tole*(1+norm(xp))
       ef=2;break;
   else
       x=xp;
   end
end

if norm(dfx)<=told*(1+norm(xp))
   if ef == 2; ef=1;
   else ef =3;
   end
end