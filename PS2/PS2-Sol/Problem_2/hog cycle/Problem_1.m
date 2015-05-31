function ex22main

clc
close all

% parametrization
a=3.0;
b=0.5;
c=1.0;
d=1.0;
df=0.1;
ord=1;  % order of equations
pseye=1.0;
maxit=200;
tol=sqrt(eps);

% Solution via LU decomposition
if ( abs(pseye-1.0)<0.0001 )
    mat=[1 b; 1 -d];
    dat_vec=[a; c];
    [L,U]=lu(mat);
    xvec=mat\dat_vec;
    pstar=xvec(1);
    qstar=xvec(2);
    disp(['q and p are ', num2str([qstar,pstar])]);
end

% illustration of excess demand:
qvec=[0.0:0.01:a]';
fvec=equil(qvec,a,b,c,d,pseye);
plot(qvec,fvec,'b-','Linewidth',2);

% solution via fzero:
qstar=[1.0,a];
qstar=fzero(@equil,qstar,[],a,b,c,d,pseye);

% alternative calling syntax:
% qstar=2.0;
% qstar=fzero(@equil,qstar,[],a,b,c,d);

% associated equilibrium price
pstar=demand(qstar,a,b);
disp(['q and p are ', num2str([qstar,pstar])]);

% illustration
pdem=demand(qvec,a,b);
psup=supply(qvec,c,d,pseye);
figure; hold on;
plot(qvec,pdem,'b-','Linewidth',2);
plot(qvec,psup,'r--','Linewidth',2);
plot(qstar,pstar,'ko','Linewidth',2,'Markersize',10);

% soluation via simple fixed point iteration
q=0.1;
p=0.1;
if (ord==1),
    [qstar,ic]=fpiter([q,p],a,b,c,d,pseye,maxit,tol,df,ord);
    disp(['iteration number ', num2str(ic)]);
else
    [qstar,ic]=fpiter([q,p],a,b,c,d,pseye,maxit,tol,df,ord);
    disp(['iteration number ', num2str(ic)]);
end;
pstar=demand(qstar,a,b);
disp(['q and p are ', num2str([qstar,pstar])]);

end

%-----------------------------------
function [q,ic]=fpiter(x,a,b,c,d,pseye,ni,tol,df,ord)

q=x(1);
p=x(2);
for ic=1:ni
    if (ord==1),
        p=demand(q,a,b);
        qnew=invsupply(p,c,d,pseye);
        dist=abs(q-qnew);
        if (dist<tol), return; end;
        q=df*qnew+(1.0-df)*q;
    elseif (ord==2),
        q=invdemand(p,a,b);
        pnew=supply(q,c,d,pseye);
        dist=abs(p-pnew);
        if (dist<tol), return; end;
        p=df*pnew+(1.0-df)*p;
    else 
        error('no such case');
        return
    end;
end;
warning('no convergence');

end
%-----------------------------------

%-----------------------------------
function func=equil(q,a,b,c,d,pseye)

func=b*q+d*q.^pseye-(a-c);

end
%-----------------------------------


%-----------------------------------
function p=demand(q,a,b)

p=a-b*q;

end
%-----------------------------------


%-----------------------------------
function q=invdemand(p,a,b)

q=1.0/b*(a-p);

end
%-----------------------------------


%-----------------------------------
function p=supply(q,c,d,pseye)

p=c+d*q.^pseye;

end
%-----------------------------------


%-----------------------------------
function q=invsupply(p,c,d,pseye)

q=((p-c)/d).^(1.0/pseye);

end
%-----------------------------------
