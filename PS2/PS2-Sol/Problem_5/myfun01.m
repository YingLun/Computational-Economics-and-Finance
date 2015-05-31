function [fx] = myfun01(q)

global zeta n lambda

fx = sum(q)^(-1/lambda) - 1/lambda * sum(q)^(-1/lambda-1) * q - zeta.*q;
