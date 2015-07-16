% simple portfolio choice problem
clear all;
close all;

rf = 0.02;
er = 0.1;
r = [rf-er;rf+er];
p = 0.1;
c = -3;

% for plot:
n=200;

er = r-rf;
prob = [p; 1-p];
RF = 1+rf;

% explicit solution: 
if c==2,
    alph = -RF*(prob'*er)/(prob'*er.^2);
    disp(' ');
    disp(['explicit solution for c=2: ', num2str(alph)]);
    disp(' ');
end;

% numeric solution (for c=2, this is a test of the solver):
alphnum=fzero('pfchoice', 0, [], RF, er, prob, c, 1);
disp(' ');
disp(['numeric solution of unconstrained problem for c= ', num2str(c), ' : ', num2str(alphnum)]);
disp(' ');
w1=prob'*(1+rf+alphnum*er);

% plot:
alphvec=linspace(alphnum-1,alphnum+1,n)';
f=zeros(n,1);
for i=1:n,
    f(i)=-feval('pfchoice',alphvec(i), RF, er, prob, c, 3);
end;
plot(alphvec, f);

% shadow value for alph=1:
disp(' ');
if (alphnum>1) || (alphnum<0),
    mu=feval('pfchoice',1,RF, er, prob, c, 1);
    if alphnum<0,
        mu=-mu;
    end;
    disp(['shadow value for constrained problem: ', num2str(mu)]);
    disp(' ');
end;    

if (false)
% TEST of Miranda-Fackler ncpsolve:
% notice: does not converge if optset is enabled
disp(' ');
disp('TEST of MF-Toolbox');
optset('ncpsolve','type','smooth');
x=ncpsolve('testncp',0,inf,0);
disp(' ');

% use ncpsolve for PF-Choice problem:
disp(' ');
optset('ncpsolve','type','minmax');
alphncp=ncpsolve('pfchoice', 0, 1, alphnum, RF, er, prob, c, 2);
disp(['numeric solution for c= ', num2str(c), ' using ncpsolve ', ': ', num2str(alphncp)]);
disp(' ');
end

% use MATLAB internal function fminbnd:
alphminbnd = fminbnd('pfchoice',0,1,[],RF,er,prob,c,3); 
disp(' ');
disp(['numeric solution for c= ', num2str(c), ' using fminbnd ', ': ', num2str(alphminbnd)]);
disp(' ');

% use MATLAB internal function fmincon:
alphmincon=fmincon('pfchoice',0,[1;-1],[1;0],[],[],[],[],[],[],RF,er,prob,c,3); 
disp(' ');
disp(['numeric solution for c= ', num2str(c), ' using fmincon ', ': ', num2str(alphmincon)]);
disp(' ');

% now, we may make our lifes even more complicated by not substituting out
% the equality constraints and using ncpsolve and fmincon accordingly.
