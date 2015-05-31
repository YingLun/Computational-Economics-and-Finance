clear all;
clc

% parameterization
sk = 0.200; sh = 0.200; n = 0.010; g = 0.015; deltak = 0.100; deltah = 0.060; z = 1.000; alphak = 0.3300; alphah = 0.3300;
params = [sk; sh; n; g; deltak; deltah; z; alphak; alphah];
cc = [1e-8;1e-8;100];
% 
% analytic solution
k_star=((sk/(n+g+n*g+deltak))^(1-alphah)*(sh/(n+g+n*g+deltah))^alphah)^(1/(1-alphak-alphah));
h_star=((sk/(n+g+n*g+deltak))^alphak    *(sh/(n+g+n*g+deltah))^(1-alphak))^(1/(1-alphak-alphah));
x_star=[k_star; h_star];

% function handle
x0 = [3;3];
f = @(x) mrw1992SS(x,params); fstring = 'mrw1992SS';

% newton algorithm
tic;
fprintf('newton \n')
[x01,fx01,ef01,iter01] = newton(f,x0,cc); cputime = toc;
if (~isreal(x01)) % depending on the initial guess, the algorithm may enter negative consumption or capital and return complex values, e.g. x0=[1;1]
    if (~any(imag(x01)))
        disp('WARNING: solution contains imaginary part which is zero')
    else
        disp('ERROR: solution contains imaginary part, try different starting value');
        return
    end
end
fprintf('exitflag: %.2d; solution: k = % 6.4f, h = %6.4f \n',ef01,x01);
fprintf('number of iterations: %.3d; cputime: %6.4f\n',iter01,cputime);
disp(['infinity norm: ' num2str(norm(x01-x_star,Inf))])

fprintf('newton with higher accuracy (by 1e-4)\n')
cc2=cc;
cc2(1:2)=cc2(1:2)/10000;
cc2(3) = cc2(3)*1000;
tic;
[x01b,fx01b,ef01b,iter01b] = newton(f,x0,cc2); cputime = toc;
if (~isreal(x01b))
    if (~any(imag(x01b)))
        disp('WARNING: solution contains imaginary part which is zero')
    else
        disp('ERROR: solution contains imaginary part, try different starting value');
        return
    end
end
% fprintf('exitflag: %.2d; solution: k = % 6.4f, h = %6.4f \n',ef01,x01);
fprintf('number of iterations: %.3d; cputime: %6.4f\n',iter01b,cputime);
disp(['infinity norm: ', num2str(norm(x01b-x_star,Inf))])
disp(' ')

% broyden algorithm
tic;
fprintf('broyden \n')
[x02,fx02,ef02,iter02] = broyden(f,x0,cc); cputime = toc;
if (~isreal(x02))
    if (~any(imag(x02)))
        disp('WARNING: solution contains imaginary part which is zero')
    else
        disp('ERROR: solution contains imaginary part, try different starting value');
        return
    end
end
fprintf('exitflag: %.2d; solution: k = % 6.4f, h = %6.4f \n',ef02,x02);
fprintf('number of iterations: %.3d; cputime: %6.4f\n\n',iter02,cputime);

% inverse broyden algorithm
tic;
fprintf('inverse broyden \n')
[x03,fx03,ef03,iter03] = invbroyden(f,x0,cc); cputime = toc;
if (~isreal(x03))
    if (~any(imag(x03)))
        disp('WARNING: solution contains imaginary part which is zero')
    else
        disp('ERROR: solution contains imaginary part, try different starting value');
        return
    end
end
fprintf('exitflag: %.2d; solution: k = % 6.4f, h = %6.4f \n',ef03,x03);
fprintf('number of iterations: %.3d; cputime: %6.4f\n\n',iter03,cputime);

% fixed point iteration
fprintf('fixed point iteration \n')
tic;
TS = x0; 
for j = 1:1000
    [xp] = mrw1992(x0,params);
    if norm(x0-xp) <= cc(1,1)*(1+norm(xp))
        break;
    else
        TS = [TS,xp]; x0 = xp;
    end
end
cputime = toc; iter04 = j; 
if (~isreal(x03))
    if (~any(imag(x03)))
        disp('WARNING: solution contains imaginary part which is zero')
    else
        disp('ERROR: solution contains imaginary part, try different starting value');
        return
    end
end
fprintf('exitflag: NA; solution: k = % 6.4f, h = %6.4f \n',x0);
fprintf('number of iterations: %.3d; cputime: %6.4f\n\n',iter04,cputime);

figure;
plot([1:iter04],TS(1,:),'--k', [1:iter04],TS(2,:), '-b', 'LineWidth', 2.5)
hold on
line(get(gca,'xlim'), [k_star k_star]); % Adapts to x limits of current axes
line(get(gca,'xlim'), [h_star h_star]); % Adapts to x limits of current axes
hold off
xlabel('Iteration','FontSize',16)
ylabel('paths of k and h','FontSize',16)
legend('k','h', 'Location','Best')
set(gca,'FontSize',16)


