% main file to run Newton minimization
clear all
close all

% function f1:
func = 'f1';
funcd = 'f1d';
funcdd = 'f1dd';

% plot of function 1:
xvec = [-2.0:0.01:1.0];
fvec = feval(func,xvec);
figure;
plot(xvec,fvec,'b-','Linewidth',2);
xlabel('x');
ylabel('f(x)');
title('function f1 of ex. 1');
print -depsc f1.eps

% solution for function minimum
x0=1.0;
[xm,fm] = newtonmin(func,funcd,funcdd,x0);
disp(['optimal x-value: ', num2str(xm)]);
disp(['function value: ', num2str(fm)]);

% solution with Matlab solver:
xmnew = fminunc(func,x0);
dist = abs(xm-xmnew);
epsi = 0.0001;
if (dist>epsi)
    warning('something is wrong with the stupid Matlab routine: function values differ');
end;


% function f2:
func = 'f2';
funcd = 'f2d';
funcdd = 'f2dd';

% plot of function 1:
xvec = [-1.5:0.01:-0.5];
fvec = feval(func,xvec);
fvec = -fvec;
figure;
plot(xvec,fvec,'b-','Linewidth',2);
xlabel('x');
ylabel('f(x)');
title('function f2 of ex. 1');
print -depsc f2.eps

% solution for function minimum
x0=1.0;
[xm,fm] = newtonmin(func,funcd,funcdd,x0);
disp(['optimal x-value: ', num2str(xm)]);
disp(['function value: ', num2str(fm)]);

diary off
diary close