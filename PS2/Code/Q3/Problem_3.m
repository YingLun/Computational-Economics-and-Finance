clc;clear

%% 3.1
% load data
[data txt]= xlsread('MRW92QJE-data.xls');
data(:,2) = [];

% delete countries with missing data
No_Countries = size(data,1);
index = [];
for iCountry = 1:No_Countries
   if sum(isnan(data(iCountry,:)))>0
      index=[index iCountry]; 
   end
end
data(index,:)=[];

%% 3.2
index_nonoil = [];
index_inter = [];
index_oecd = [];

for iCountry = 1:length(data)
    % non-oil countries
   if data(iCountry,2)==1
      index_nonoil = [index_nonoil iCountry]; 
   end
   % intermediate countries
   if data(iCountry,3)==1
      index_inter = [index_inter iCountry]; 
   end
   % oecd countries
   if data(iCountry,4)==1
      index_oecd = [index_oecd iCountry]; 
   end
   
end

nonoil_country = data(index_nonoil,:);
inter_country = data(index_inter,:);
oecd_country = data(index_oecd,:);

%% 3.3
%nonoil
gdp60_nonoil = log(nonoil_country(:,5));
gdp85_nonoil = log(nonoil_country(:,6));
iy_nonoil = log(nonoil_country(:,9));
school_nonoil = log(nonoil_country(:,10));

y_nonoil = gdp85_nonoil-gdp60_nonoil;
X_nonoil = [ones(size(y_nonoil,1),1) gdp60_nonoil iy_nonoil ...
    log(nonoil_country(:,8)+5) school_nonoil];
Beta_nonoil = (X_nonoil'*X_nonoil)\(X_nonoil'*y_nonoil);
sigma_nonoil = var(y_nonoil-X_nonoil*Beta_nonoil)*...
     (X_nonoil'*X_nonoil/size(y_nonoil,1))^(-1)./size(y_nonoil,1);
 
%intermediate country
gdp60_inter = log(inter_country(:,5));
gdp85_inter = log(inter_country(:,6));
iy_inter = log(inter_country(:,9));
school_inter = log(inter_country(:,10));

y_inter = gdp85_inter-gdp60_inter;
X_inter = [ones(size(y_inter,1),1) gdp60_inter iy_inter ...
    log(inter_country(:,8)+5) school_inter];
Beta_inter = (X_inter'*X_inter)\(X_inter'*y_inter);
sigma_inter = var(y_inter-X_inter*Beta_inter)*...
     (X_inter'*X_inter/size(y_inter,1))^(-1)./size(y_inter,1); 
 
%oecd country
gdp60_oecd = log(oecd_country(:,5));
gdp85_oecd = log(oecd_country(:,6));
iy_oecd = log(oecd_country(:,9));
school_oecd = log(oecd_country(:,10));

y_oecd = gdp85_oecd-gdp60_oecd;
X_oecd = [ones(size(y_oecd,1),1) gdp60_oecd iy_oecd ...
    log(oecd_country(:,8)+5) school_oecd];
Beta_oecd = (X_oecd'*X_oecd)\(X_oecd'*y_oecd);
sigma_oecd = var(y_oecd-X_oecd*Beta_oecd)*...
     (X_oecd'*X_oecd/size(y_oecd,1))^(-1)./size(y_oecd,1); 
 
%% 3.4 

R2_nonoil = 1 -   var(y_nonoil-mean(y_nonoil))\var(y_nonoil-X_nonoil*Beta_nonoil)...
    *((length(y_nonoil)-1)/(length(y_nonoil)-1-length(Beta_nonoil)));
R2_inter = 1 -   var(y_inter-mean(y_inter))\var(y_inter-X_inter*Beta_inter)...
    *((length(y_inter)-1)/(length(y_inter)-1-length(Beta_inter)));
R2_oecd = 1 -   var(y_oecd-mean(y_oecd))\var(y_oecd-X_oecd*Beta_oecd)...
    *((length(y_oecd)-1)/(length(y_oecd)-1-length(Beta_oecd)));


clearvars -except Beta* R2* sigma*

Beta = [Beta_nonoil Beta_inter Beta_oecd];
Std_Beta = [(diag(sigma_nonoil)).^0.5 (diag(sigma_inter)).^0.5 (diag(sigma_oecd)).^0.5];
R2 = [R2_nonoil R2_inter R2_oecd];