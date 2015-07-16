clc;clear;
% cepath='/Users/baoyangming/Dropbox/gsefm/2015SoSe/Computational Economics/Applied Computational Economics and Finance/compecon/';
% path([cepath 'cetools;' cepath 'cedemos'],path);

% Set domain of interpolation

a =   -1;
b =   1;

%% using Chebychev polynomials for n equidistant nodes. 
% for some large n
n_big=1000;

% define a vector of equidistant nodes, x
x_big = nodeunif(n_big,a,b);
% define the function space for Chebychev polynomials and 
% calculate the matrix of basis functions, T
fspace_big = fundefn('cheb',n_big,a,b);
T_big = funbas(fspace_big,x_big);
% calculate the function values at x
y_big = feval(@func,x_big');
% finally get the polynomial coefficients.
c_big=(T_big'*T_big)^(-1)*(T_big'*y_big');
y_bar = T_big*c_big;

figure('Name','Comparison using equidistant nodes');

for n=5:15
        
    xnode = nodeunif(n,a,b);  
    fspace = fundefn('cheb',n,a,b);
    T = funbas(fspace,xnode);
    % calculate the function values at x
    y = feval(@func,xnode);   
    c=(T'*T)^(-1)*(T'*y);   
    
    % plot the residual
    T_use=funbas(fspace,x_big);
    y_tilda=T_use*c;    
    res = y_big'-y_tilda;
    
    subplot(3,4,n-5+1);
    plot(x_big,res,'k','LineWidth',1.2);
    title(strcat('n=',num2str(n)));
end



%% Repeat the exercise using Chebychev nodes
clearvars -except a b;
% for some large n
n_big = 1000;
% define the function space for Chebychev polynomials and 
% calculate the matrix of basis functions, T
fspace_big = fundefn('cheb',n_big,a,b);
x_big = funnode(fspace_big);
T_big = funbas(fspace_big,x_big);

% calculate the function values at x
y_big = feval(@func,x_big);

% finally get the polynomial coefficients.
c_big=(T_big'*T_big)^(-1)*T_big'*y_big;
y_bar = T_big*c_big;

figure('Name','Comparison using Chebychev nodes');
for n=5:15
    % calculate the matrix of basis functions, B
    fspace = fundefn('cheb',n,a,b);
    xnode = funnode(fspace);
    T = funbas(fspace,xnode);
    
    % calculate the function values at x
    y = feval(@func,xnode);
    
    % finally get the polynomial coefficients.
    c=(T'*T)^(-1)*(T'*y);  
    
    
    % plot the residual
    T_use=funbas(fspace,x_big);
    y_tilda=T_use*c;    
    res = y_bar-y_tilda;
    
    subplot(3,4,n-5+1);
    plot(x_big,res,'k','LineWidth',1.2);
    title(strcat('n=',num2str(n)));
end




