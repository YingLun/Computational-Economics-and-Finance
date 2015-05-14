% Computational Economics
% PS1 - Q1

clear, clc
close all
format long

disp('---------------------------------------------')
disp('Problem 1')
disp('---------------------------------------------')
disp(' ')


%% 1.5

% first order
A = [1 0.5;1 -1];
y = [3 1]';
% second order
A2 = [1 -1; 1 0.5];
y2 = [1 3]';

max_it = 1000;
tol=1e-6;
rng('default');
Q = tril(A);
Q2 = tril(A2);
x_init = [0.1,0.1]';
x=x_init;

% convegence case; order 1
for it=1:max_it
    it;
    dx1(:,it)=Q\(y-A*x);
    x=x+dx1(:,it);
    if norm(dx1(:,it))<tol
    disp(['Converged at iteration #: ', num2str(it)])
    disp(['The solution vector is: ', num2str(x')])
    disp(' ')
    break
    end
    if it>=max_it, disp('No Convergence'), end
end

% nonconvergence case; order 2
x=x_init;
for it=1:max_it
    it;
    dx2(:,it)=Q2\(y2-A2*x);
    x=x+dx2(:,it);
    if norm(dx2(:,it))<tol
    disp(['Converged at iteration #: ', num2str(it)])
    disp(['The solution vector is: ', num2str(x')])
    disp(' ')
    break
    end
    if it>=max_it, disp('No Convergence'), end
end

%plot
figure1 = figure('name','convergence case');
plot(dx1(1,:),'r','linewidth',1.2);

figure2 = figure('name','nonconvergence case');
plot(dx2(1,:),'b','linewidth',1.2);


%% 1.6
lambda = linspace(0.1,0.9,9)';
telapsed = zeros(1,length(lambda));
x=x_init;
for k=1:length(lambda)
    tstart = tic;
    for it=1:max_it
        dx3=lambda(k)*Q2\(y2-A2*x);
        x=x+dx3;
        if norm(dx3)<tol
            disp(['Converged at iteration #: ', num2str(it)])
            disp(['The solution vector is: ', num2str(x')])
            disp(' ')
            break
        end
        if it>=max_it, disp('No Convergence'), end
    end
    telapsed(k) = toc(tstart);
end
disp(['fastest lambda for convergence is: ', num2str(min(telapsed))])