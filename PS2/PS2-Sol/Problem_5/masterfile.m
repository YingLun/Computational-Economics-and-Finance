close all; clear all 
clc;

global zeta n lambda


%% part 1
lambda = 1.6; n = 2; zeta = linspace(0.6,0.8,n)';

x0 = ones(n,1); cc = [1e-10; 1e-10; 1000];
[x01a,fx01a,ef01a,numit01a] = gennewton(@myfun01,x0,cc);                                  
disp(['solution for n=',num2str(n)]);
disp(num2str(x01a));
disp(' ');


%% part 2
lambda = 1.6; n = 5; zeta = linspace(0.6,0.8,n)';

x0 = ones(n,1); cc = [1e-10; 1e-10; 1000];
[x01b,fx01b,ef01b,numit01b] = gennewton(@myfun01,x0,cc);                                  
disp(['solution for n=',num2str(n)]);
disp(num2str(x01b));
disp(' ');

%% part 3
lambda = 1.6; n = 10; zeta = linspace(0.6,0.8,n)';

x0 = ones(n,1); cc = [1e-10; 1e-10; 1000];
[x01c,fx01c,ef01c,numit01c] = gennewton(@myfun01,x0,cc);                                  
disp(['solution for n=',num2str(n)]);
disp(num2str(x01c));
disp(' ');