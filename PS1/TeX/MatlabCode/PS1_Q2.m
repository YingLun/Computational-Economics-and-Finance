% Computational Economics
% PS1 - Q2 Determine the output gap

clear, clc

%import data
[data,txt] = xlsread('data/OECD-Germany_Greece_GDP_Linux.xls');
%% 2.1

logGDP_Germany = log(data(1,:))';
logGDP_Greece = log(data(2,:))';

%% 2.2

trend_Germany = hpfilter(logGDP_Germany,1600);
trend_Greece = hpfilter(logGDP_Greece,1600);

%% 2.3

t = datenum(txt,'QQ-YYYY');
X = [ones(length(t),1) t];
beta_Germany = (X'*X)\(X'*logGDP_Germany);
beta_Greece = (X'*X)\(X'*logGDP_Greece);

logGDP_Germany_hat = X*beta_Germany;
logGDP_Greece_hat = X*beta_Greece;

%% 2.4

hp_gap_Germany =  exp(logGDP_Germany-trend_Germany);
hp_gap_Greece =  exp(logGDP_Greece-trend_Greece);
ols_gap_Germany = exp(logGDP_Germany-logGDP_Germany_hat);
ols_gap_Greece = exp(logGDP_Greece-logGDP_Greece_hat);

%% 2.5

figure(1)
subplot(2,1,1)
title('Germany')
hold on
plot(t,logGDP_Germany,'-b');
plot(t,trend_Germany,'-r');
plot(t,logGDP_Germany_hat,'-g')
hold off
datetick('x','qq-yyyy')
legend('log GDP','HP Trend','Linear Trend')


subplot(2,1,2)
hold on
plot(t,logGDP_Greece,'-b');
plot(t,trend_Greece,'-r');
plot(t,logGDP_Greece_hat,'-g')
hold off
datetick('x','qq-yyyy')
legend('log GDP','HP Trend','Linear Trend')

figure(2)
subplot(2,1,1)
title('Germany')
hold on
plot(t,log(hp_gap_Germany),'-b');
plot(t,log(ols_gap_Germany),'-r');
plot(t,zeros(length(t),1),'-g');
hold off
datetick('x','qq-yyyy')
legend('hp gap','ols gap','0')

subplot(2,1,2)
hold on
title('Greece')
plot(t,log(hp_gap_Greece),'-b');
plot(t,log(ols_gap_Greece),'-r');
plot(t,zeros(length(t),1),'-g')
hold off
datetick('x','qq-yyyy')
legend('HP Gap','OLS Gap','0')
