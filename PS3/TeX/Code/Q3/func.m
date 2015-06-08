function KuhnTucker = func(varible,k1,h1)
% This function deals with the Kuhn Tucker equations for Q3

%varibles
c1 = varible(1);
c2 = varible(2);
u1 = varible(3);
u2 = varible(4);
alphak = varible(5);
alphah = varible(6);
ik = varible(7);
ih = varible(8);

%parameters
k = 2;
gamma = 2;
beta = 0.96;
rk = 0.1;
rh = 1.4;
eta = 0.8;
sigma_k = 0.05;
sigma_h = 0.05;

%Garcia-Zangwill trick
alphak_plus = (max(0,alphak))^k;
alphak_minus = (max(0,-alphak))^k;
alphah_plus = (max(0,alphah))^k;
alphah_minus = (max(0,-alphah))^k;

% equations for KuhnTucker
KuhnTucker = zeros(8,1);

KuhnTucker(1) = c1^(-gamma)+u1;
KuhnTucker(2) = beta*c2^(-gamma)+u2;
KuhnTucker(3) = alphak_plus+u1-u2*(1+rk);
KuhnTucker(4) = alphah_plus+u1-u2*rh*eta*((1-sigma_h)*h1+ih)^(eta-1);
KuhnTucker(5) = alphak_minus-((1-sigma_k)*k1+ik);
KuhnTucker(6) = alphah_minus-ih;
KuhnTucker(7) = c1-(rk*k1+rh*h1^eta-ik-ih);
KuhnTucker(8) = c2-((1+rk)*((1-sigma_k)*k1+ik)+rh*((1-sigma_h)*h1+ih)^eta);




end