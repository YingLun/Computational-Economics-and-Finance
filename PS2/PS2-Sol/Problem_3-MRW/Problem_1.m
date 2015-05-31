clear all; close all; 
%clc

%% Get Data
data    = xlsread('MRW92QJE-data.xls');
X       =  data(:, [1, 3:end]);

% get rid of countries with missing data
D       = isnan(X);
   Dsum = sum(D,2);
   
    % first method of doing this;
    Xnew1 = [];
    for j = 1:length(X)
        if Dsum(j,1) == 0;
            Xnew1 = [Xnew1; X(j,:)];
        end
    end
   
    % second method of doing this;
    Dx = logical(Dsum == 0);
    Xnew2 = X(Dx,:);

% note: Xnew(:,1) = country number, Xnew(:,2) = non-oil dummy, Xnew(:,3) =
% intermediate dummy, Xnew(:,4) = oecd dummy, Xnew(:,5) = gdp/adult 1960,
% Xnew(:,6) = gdp/adult 1985, Xnew(:,7) = gdp growth, Xnew(:,8) = pop
% growth, Xnew(:,9) = i/y, Xnew(:,10) = school

% generate sub samples
DN = logical(Xnew2(:,2) == 1);
XN = Xnew2(DN,:); % non-oil

DI = logical(Xnew2(:,3) == 1);
XI = Xnew2(DI,:); % intermediate

DO = logical(Xnew2(:,4) == 1);
XO = Xnew2(DO,:); % oecd


%% Regression: Sub-Sample N

% regression:   dependent variable: difference in log gdp
%               independent variables: constant, log(y60), log(i/gdp),
%               log(n+g+d), log(school)

[rowsN, colsN]  = size(XN);
YN              = log(XN(:,6)) - log(XN(:,5));
XNreg           = [ones(rowsN,1), log(XN(:,5)), log(XN(:,9)/100), log(XN(:,8)/100+0.05), log(XN(:,10)/100)];
    
    % regression coefficients 
    betaN1      = inv(XNreg'*XNreg) * (XNreg'*YN);
    betaN2      = XNreg\YN; % alternative and much faster way of doing least squares

    % standard errors 
    [sN]        = stderr(XNreg,YN,betaN1,rowsN-5);
    
    
%% Regression: Sub-Sample I

% regression:   dependent variable: difference in log gdp
%               independent variables: constant, log(y60), log(i/gdp),
%               log(n+g+d), log(school)

[rowsI, colsI]  = size(XI);
YI              = log(XI(:,6)) - log(XI(:,5));
XIreg           = [ones(rowsI,1), log(XI(:,5)), log(XI(:,9)/100), log(XI(:,8)/100+0.05), log(XI(:,10)/100)];
    
    % regression coefficients 
    betaI1      = inv(XIreg'*XIreg) * (XIreg'*YI);
    betaI2      = XIreg\YI; % alternative and much faster way of doing least squares

    % standard errors 
    [sI]        = stderr(XIreg,YI,betaI1,rowsI-5);
 

%% Regression: Sub-Sample O

% regression:   dependent variable: difference in log gdp
%               independent variables: constant, log(y60), log(i/gdp),
%               log(n+g+d), log(school)

[rowsO, colsO]  = size(XO);
YO              = log(XO(:,6)) - log(XO(:,5));
XOreg           = [ones(rowsO,1), log(XO(:,5)), log(XO(:,9)/100), log(XO(:,8)/100+0.05), log(XO(:,10)/100)];

    % regression coefficients 
    betaO1      = inv(XOreg'*XOreg) * (XOreg'*YO);
    betaO2      = XOreg\YO; % alternative and much faster way of doing least squares

    % standard errors 
    [sO]        = stderr(XOreg,YO,betaO1,rowsO-5);

%% Implied Speed of Convergence: see MRW, p.423, eq. (16): use result from coefficient on ln(Y60) (MRW say so on p. 428)
lambdaa         = -log([betaN1(2,1), betaI1(2,1), betaO1(2,1)]+1)/25;

%% Print Results

fprintf('                                                                   \n');
fprintf('                   Non-Oil         Intermediate        OECD        \n\n');
fprintf('sample size        %8.2d           %8.2d               %8.2d       \n\n', rowsN, rowsI, rowsO);
fprintf('constant           %8.4f           %8.4f               %8.4f       \n', betaN1(1,1), betaI1(1,1), betaO1(1,1));
fprintf('standard error     %8.4f           %8.4f               %8.4f       \n\n', sN(1,1), sI(1,1), sO(1,1));
fprintf('log(y60)           %8.4f           %8.4f               %8.4f       \n', betaN1(2,1), betaI1(2,1), betaO1(2,1));
fprintf('standard error     %8.4f           %8.4f               %8.4f       \n\n', sN(2,1), sI(2,1), sO(2,1));
fprintf('log(i/y)           %8.4f           %8.4f               %8.4f       \n', betaN1(3,1), betaI1(3,1), betaO1(3,1));
fprintf('standard error     %8.4f           %8.4f               %8.4f       \n\n', sN(3,1), sI(3,1), sO(3,1));
fprintf('log(n+g+d)         %8.4f           %8.4f               %8.4f       \n', betaN1(4,1), betaI1(4,1), betaO1(4,1));
fprintf('standard error     %8.4f           %8.4f               %8.4f       \n\n', sN(4,1), sI(4,1), sO(4,1));
fprintf('log(school)        %8.4f           %8.4f               %8.4f       \n', betaN1(5,1), betaI1(5,1), betaO1(5,1));
fprintf('standard error     %8.4f           %8.4f               %8.4f       \n\n', sN(5,1), sI(5,1), sO(5,1));
fprintf('implied lambdaa    %8.4f           %8.4f               %8.4f       \n', lambdaa);


