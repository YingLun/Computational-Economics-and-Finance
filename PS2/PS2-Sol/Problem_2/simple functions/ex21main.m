% main file to run Newton minimization
clear all
close all

func = 'g1';

% plot of function g1:
xvec = [0.1:0.01:1.0];
fvec = feval(func,xvec);
figure;
plot(xvec,fvec,'b-','Linewidth',2);
xlabel('x');
ylabel('f(x)');
title('function g1 of ex. 2.1');
print -depsc ex21g1a.eps

% plot of function g1 again:
xvec = [-2.0:0.01:-1.0];
fvec = feval(func,xvec);
figure;
plot(xvec,fvec,'b-','Linewidth',2);
xlabel('x');
ylabel('f(x)');
title('function g1 of ex. 2.1');
print -depsc ex21g1b.eps

% solution for zero of g1
a = 0.1;
c = 10;
x0 = 1.0;
xm = biseczero(func,a,c);
disp(['optimal x-value: ', num2str(xm)]);


func = 'g2';

% plot of function g2:
xvec = [-1:0.01:2];
fvec = feval(func,xvec);
figure;
plot(xvec,fvec,'b-','Linewidth',2);
xlabel('x');
ylabel('f(x)');
title('function g2 of ex. 2.1');
print -depsc ex21g2a.eps

% plot function g2 again:
xvec = [-1:0.01:10];
fvec = feval(func,xvec);
figure;
plot(xvec,fvec,'b-','Linewidth',2);
xlabel('x');
ylabel('f(x)');
title('function g2 of ex. 2.1');
print -depsc ex21g2a.eps


% illustration: function value at high x:
x = 100;
fval = feval(func,x);
disp(['function value for x=', num2str(x), ' is ', num2str(fval)]);


% solution for zero of g2
a = 0.1;
c = 10.0;
x0 = 1.0;
xm = biseczero(func,a,c);
disp(['optimal x-value: ', num2str(xm)]);
