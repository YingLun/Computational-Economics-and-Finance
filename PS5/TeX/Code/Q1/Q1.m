% Q1
cepath='/Users/baoyangming/Dropbox/gsefm/2015SoSe/Computational Economics/Applied Computational Economics and Finance/compecon/';
path([cepath 'cetools;' cepath 'cedemos'],path);
clc;clear

%% functions
f1 = @(x)x.^4;
f2 = @(x)x.^6;
f3 = @(x)1./(1+x.^2);

%% Monte carlo

montec11 = montec(f1,100);
montec12 = montec(f1,1000);
montec13 = montec(f1,10000);
montec14 = montec(f1,50000);

montec21 = montec(f2,100);
montec22 = montec(f2,1000);
montec23 = montec(f2,10000);
montec24 = montec(f2,50000);

montec31 = montec(f3,100);
montec32 = montec(f3,1000);
montec33 = montec(f3,10000);
montec34 = montec(f3,50000);

%% Gaussian Quadrature
n = [2 3 4 5 7];
q1 = zeros(5,1);
for ii=1:5
    q1(ii) = gaussianq(f1,n(ii));
end

q2 = zeros(5,1);
for ii=1:5
    q2(ii) = gaussianq(f2,n(ii));
end

q3 = zeros(5,1);
for ii=1:5
    q3(ii) = gaussianq(f3,n(ii));
end
