function [s] = stderr(X,Y,b,df)

% input arguments: independent variable matrix X, dependent variable vector
% Y, regression coefficient vector b, degrees of freedom

epsil       = Y - X*b;
varcovar    = inv(X'*X) * (epsil'*epsil)/df;

s           = diag(varcovar).^(0.5);