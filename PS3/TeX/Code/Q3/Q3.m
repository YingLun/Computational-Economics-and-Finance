%Q3

clear, clc

ini_val = ones(8,1);


% i) 
k1=1; h1=5;
KuhnTucker = @(varible)func(varible,k1,h1);
solution1 = fsolve(KuhnTucker,ini_val);
% lambda = alpha+
lambdak1 = (max(0,solution1(5)))^2;
lambdah1 = (max(0,solution1(6)))^2;

% ii) 
k1=1; h1=1;
KuhnTucker = @(varible)func(varible,k1,h1);
solution2 = fsolve(KuhnTucker,ini_val);
lambdak2 = (max(0,solution2(5)))^2;
lambdah2 = (max(0,solution2(6)))^2;

% iii) 
k1=1; h1=0.2;
KuhnTucker = @(varible)func(varible,k1,h1);
solution3 = fsolve(KuhnTucker,ini_val);
lambdak3 = (max(0,solution3(5)))^2;
lambdah3 = (max(0,solution3(6)))^2;





