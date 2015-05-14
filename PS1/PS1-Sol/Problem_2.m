
function Problem_2
% This script is very messy.
clc
close all
clear all

disp('---------------------------------------------')
disp('Problem 2')
disp('---------------------------------------------')
disp(' ')

data= xlsread('data/OECD-Germany_Greece_GDP_Linux.xls');
GDP_Germany = data(1,:)';
GDP_Greece = data(2,:)';

quarters = linspace(1995.01,2014.04,length(data))'; % I have no idea why this works.

figure;
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

opt_germany=1;
outgap(GDP_Germany,quarters,[],opt_germany)

opt_germany=0;
outgap(GDP_Greece,quarters,[],opt_germany)

function outgap(gdp,year,og_imf,opt_germany)
lngdp=log(gdp);
[m,n]=size(gdp);

% Determine the trend using the HP-Filter (with lambda=100)
lambda=1600;
tlngdp=hpfilter(lngdp,lambda);
tgdp=exp(tlngdp);

% Determine the trend by linear regression for each country
X = [ones(m,1),[0:m-1]'];
betta = X\lngdp;
lintlngdp = X*betta;
lintgdp=exp(lintlngdp);

% Output gap: gdp-tgdp/tgdp
og=zeros(m,n);
og_ln=zeros(m,n);
og_tln=zeros(m,n);
og_lin=zeros(m,n);
for j=1:n
    for i=1:m
        og_ln(i,j)=((lngdp(i,j)-tlngdp(i,j))/tlngdp(i,j))*100;
        og(i,j)=((gdp(i,j)-tgdp(i,j))/tgdp(i,j))*100;
        og_tln(i,j)=((lngdp(i,j)-lintlngdp(i,j))/lintlngdp(i,j))*100;
        og_lin(i,j)=((gdp(i,j)-lintgdp(i,j))/lintgdp(i,j))*100;
    end
end

% Figures
% Figure 1: log of GDP and Trend 
%figure;
if (opt_germany)
    subplot(2,2,1)
else
    subplot(2,2,2)
end
plot(year, lngdp(:,1),'k', year, tlngdp(:,1),'r--', year, lintlngdp(:,1),'b--', 'Linewidth', 2);
xlim([min(year),max(year)]);
xlabel('year','FontSize',16);
ylabel('log y_t','FontSize',16);
legend('Time series', 'HP-Trend', 'Linear Trend', 'Location','SouthEast')
set(gca,'FontSize',16)
if (opt_germany)
    title('GDP and Trend, Germany','FontSize',16);    
else
    title('GDP and Trend, Greece','FontSize',16);
end

% Figure 2: Output Gap and zero-line
null=zeros(m,n);
%figure;
if (opt_germany)
    subplot(2,2,3)
    plot(year, og(:,1),'r', year, og_lin(:,1),'b', year, null(:,1),'k:', 'Linewidth', 2);
    title('Output Gap Germany','FontSize',16);
    xlim([min(year),max(year)]);
    xlabel('year','FontSize',16);
    legend('HP-filter', 'Linear model', 'Location','South')
    set(gca,'FontSize',16)
else
    subplot(2,2,4)
    plot(year, og(:,1),'r', year, og_lin(:,1),'b', year, null(:,1),'k:', 'Linewidth', 2);
    title('Output Gap Greece','FontSize',16);
    xlim([min(year),max(year)]);
    xlabel('year','FontSize',16);
    legend('HP-filter', 'Linear model', 'Location','South')
    set(gca,'FontSize',16)
end

end % end function

end % end m-file