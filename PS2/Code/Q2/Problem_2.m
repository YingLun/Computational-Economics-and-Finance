function Exercise_2
%% 2.2
clc;clear;

f1=@(x)x^3+4-1/x;
[x1 fx1] = bisection(f1,[0.1;1],[10^-6;10^-6]);
disp(['the root is' ' ' num2str(x1)]); 

f2=@(x)-exp(-x)+exp(-x^2);;
[x2 fx2] = bisection(f2,[0.2;2],[10^-6;10^-6]);
disp(['the root is' ' ' num2str(x2)]); 


%% 2.3
f = @(q)q^2+2*q-4;

% with bisection
[q fx1] = bisection(f,[1;2],[10^-6;10^-6]);
disp(['the root is' ' ' num2str(q)]); 
% with fzero
q = fzero(f,1);
disp(['the root is' ' ' num2str(q)]); 
% Gauss seidel fixed point
A=[1 0.5;1 -1];
y = [3 1];


end