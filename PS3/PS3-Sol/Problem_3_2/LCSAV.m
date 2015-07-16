%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Life cycle saving problem %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all

global sigma betta r T w;


sigma = 5;            % risk aversion parameter
betta = 0.99;          % time discount factor
T = 5;                 % time horizon
r = 0.02;              % interest rate
epsi = 1.0e-04;

w = zeros(T,1);        % initial endowment
w(1) = 10;

sst = zeros(T,1);
for t=1:T              % starting point for minimization
    sst(t) = (T-t)/T*2;
end

% i. Minimization using Matlab's Nelder Mead algorithm
[ssol_1,uval,exitflag] = fminsearch('utilsum',sst);  
if (exitflag==1),
    disp('successful convergence');
else
    disp('there is some problem');
end;

% % ii. Minimization using Michael Reiter's BFGS
% ssol_old = ssol;
% [ssol,uval,g,niter] = bfgs(@utilsum,sst,sqrt(eps),0,0);  % Minimization
% epsi=1e-4;
% if ( any(abs(g)>epsi) ),
%     disp('there is some problem');
% else
%     disp('successful convergence');
% end;

% iii. Minimization using Matlab's fminunc
[ssol_2,fval,exitflag] = fminunc('utilsum',sst);  
if (exitflag==1),
    disp('successful convergence');
else
    disp('there is some problem');
end;

c_1 = cons(ssol_1);
c_2 = cons(ssol_2);

agevec=[1:T]';
plot(agevec,c_1,'-o',agevec,c_2,'+');          % Figures of the consumption profile
xlabel('period');
ylabel('consumption');
% axis([0 (T+1) 0 5]);

% analytical solution:
consgr = (betta*(1+r))^(1/sigma);
c(1)=1.0;
pvi = w(1);
pvc = c(1);
for t=2:T,
    c(t)=c(t-1)*consgr;
    df = (1+r)^(1-t);
    pvi = pvi + df*w(t);
    pvc = pvc + df*c(t);
end;
% update consumption:
fac = pvi/pvc;
c = c*fac;

% difference between analytical solution and Nelder-Mead solution:
dist = abs(c - c_1);
figure; plot(dist);
if ( any(abs(dist)>epsi) ),
    maxdist = max(dist);
    disp(['maximum distance between Nelder-Mead solution and analytical solution is ', num2str(maxdist)]);
end;

% difference between analytical solution and fminunc solution:
dist = abs(c - c_2);
figure; plot(dist);
if ( any(abs(dist)>epsi) ),
    maxdist = max(dist);
    disp(['maximum distance between Fmin-Unc solution and analytical solution is ', num2str(maxdist)]);
end;