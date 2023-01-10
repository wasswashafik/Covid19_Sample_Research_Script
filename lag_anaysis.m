clear;
clc;
close all;

% load data
confirmed_cases = readtable("covid19_confirmed_12countries.xlsx");
death_cases = readtable("covid19_death_12countries.xlsx");
recovered_cases = readtable("covid19_recovered_12countries.xlsx");
% sars data
% confirmed_cases = readtable("sars_total.xlsx");
% death_cases = readtable("sars_death.csv");
% mers data
% mersdata = readtable("DailyMERS.xlsx");
% confirmed_cases = mersdata(:,[1,3]);
% death_cases = mersdata(:,[1,4]);
% confirmed_cases.Properties.VariableNames(2) = "Global";

% calculate mortality rate for each country and plot it
datasize = size(confirmed_cases);
num_country = datasize(2)-1;
countries = confirmed_cases.Properties.VariableNames;
results = table('Size',[num_country 8],...
        'VariableTypes',["string",repmat("double",1,7)]...
        ,'VariableNames',{'Country','Lag','Beta','SE_Beta','pValue_Beta','EstimationCFR','SE_CFR','pValue_CFR'});

% for i = 2:2
%     tmp_confirmed_cases = confirmed_cases{:,i+1};
%     tmp_death_cases = death_cases{:,i+1};
%     %tmp_recovered_cases = recovered_cases{:,i+1};
%     
%     % find the index of first case 
%     start_index = find(tmp_confirmed_cases~=0,1);
%     tmp_confirmed_cases = tmp_confirmed_cases(start_index:end);
%     tmp_death_cases = tmp_death_cases(start_index:end);
%     %tmp_recovered_cases = tmp_recovered_cases(start_index:end);
%     
%     lag = 4;
%     deleted_day = 0;
%     MR0 = calMR(tmp_confirmed_cases,tmp_death_cases,0);
%     MRlag = calMR(tmp_confirmed_cases,tmp_death_cases,lag);
%     
%     
% %     % parameter tunning
% %     deleted_day = 0;
% %     lag = 0;
% %     beta = inf;
% %     for lag1 = 1:30
% %         % calculate death rates
% %         MR0 = calMR(tmp_confirmed_cases,tmp_death_cases,0);
% %         MRlag = calMR(tmp_confirmed_cases,tmp_death_cases,lag1);
% %         %recovered method
% %         %MR_recovered = calMR_recovr(tmp_recovered_cases,tmp_death_cases);
% %         tmp_mdl = fitlm([1:length(MRlag)-deleted_day],MRlag(deleted_day+1:end),'linear');
% %         if abs(tmp_mdl.Coefficients.Estimate(2))< beta
% %             mdl = tmp_mdl;
% %             lag = lag1;
% %             beta = tmp_mdl.Coefficients.Estimate(2);
% %         end
% %     end
% %     MRlag = calMR(tmp_confirmed_cases,tmp_death_cases,lag);
%     
%     % plot 
%     figure;
%     hold on;
%     
%     % plot death rate
%     % yyaxis left
%     plot(confirmed_cases{start_index:end,1},MR0);
%     plot(confirmed_cases{start_index+lag+deleted_day:end,1},MRlag(deleted_day+1:end));
%     ylabel("Case Fatality Rate(%)");
%     
%     % plot total cases
%     %yyaxis right
%     %plot(confirmed_cases{start_index:end,1},tmp_confirmed_cases)
%     laglegend = strcat(strcat("cCFR(lag = ",num2str(lag))," days)");
%     legend("cCFR",laglegend,'Location','northwest');
%     %ylabel("Confirmed Cases")
%     xlabel("Date"); 
%     title(countries{i+1});
%     
%     % result
%     mdl = fitlm([1:length(MRlag)-deleted_day],MRlag(deleted_day+1:end),'linear');
%     results.Country(i) = convertCharsToStrings(countries{i+1});
%     results.Lag(i) = lag;
%     results{i,3:5} = mdl.Coefficients{2,[1,2,4]};
%     results{i,6:8} = mdl.Coefficients{1,[1,2,4]};
% 
% end







