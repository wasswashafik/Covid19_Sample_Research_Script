clear;
clc;
close all;

% load data
% covid-19 data
% confirmed_cases = readtable("covid19_confirmed_12countries.xlsx");
% death_cases = readtable("covid19_death_12countries.xlsx");
% recovered_cases = readtable("covid19_recovered_12countries.xlsx");
% sars data
confirmed_cases = readtable("sars_total.xlsx");
death_cases = readtable("sars_death.csv");

datasize = size(confirmed_cases);
num_country = datasize(2)-1;
countries = confirmed_cases.Properties.VariableNames;

% Daily
% calculate mortality rate for each country and plot it


for i = 1:num_country
    tmp_confirmed_cases = confirmed_cases{:,i+1};
    tmp_death_cases = death_cases{:,i+1};
    % calculate new confirmed cases
    tmp_new_confirmed = tmp_confirmed_cases(2:end)-tmp_confirmed_cases(1:end-1);
    tmp_new_death = tmp_death_cases(2:end)-tmp_death_cases(1:end-1);
    
    % find the index of first case 
    start_index = find(tmp_confirmed_cases~=0,1);
    tmp_confirmed_cases = tmp_confirmed_cases(start_index:end);
    tmp_death_cases = tmp_death_cases(start_index:end);
    tmp_new_confirmed = tmp_new_confirmed(start_index:end);
    tmp_new_death = tmp_new_death(start_index:end);
    
    
    % calculate death rates/increase
    lag1 = 5;
    deleted_day = 1 ;
    NominalMR = calMR(tmp_confirmed_cases,tmp_death_cases,0);
    MR0 = calMR(tmp_new_confirmed,tmp_new_death,0);
    MRlag = calMR(tmp_new_confirmed,tmp_new_death,lag1);
    %replace inf with 0
    MR0(MR0==Inf) = 0;
    MRlag(MRlag==Inf) = 0;
    MR0(MR0<0) = 0;
    MRlag(MRlag<0) = 0;
    % plot 
    figure;
    hold on;
    
    % plot death rate
    % yyaxis left
    plot(confirmed_cases{start_index:end,1},NominalMR);
    plot(confirmed_cases{start_index+1:end,1},MR0);
    plot(confirmed_cases{start_index+lag1+deleted_day:end,1},MRlag(deleted_day:end));
    ylabel("Mortality Rate(%)");
    
    mdl = fitlm([1:length(MRlag)-deleted_day+1],MRlag(deleted_day:end),'linear')
    % plot new confirmed cases
    % yyaxis right
    % daily new confirmed cases
    % plot(confirmed_cases{start_index+1:end,1},tmp_new_confirmed)
    laglegend = strcat(strcat("lag = ",num2str(lag1))," days");
    legend("NominalMR","lag = 0 days",laglegend,"Daily Increase",'Location','northwest');
    ylabel("Number of daily new cases")
    xlabel("Date");
    
    title(countries{i+1});
end
% 
% % Weekly
% % convert daily increase to weekly increase
% new_confirmed_cases = confirmed_cases(2:end,:);
% new_death_cases = death_cases(2:end,:);
% new_confirmed_cases{:,2:end} = confirmed_cases{2:end,2:end} - confirmed_cases{1:end-1,2:end};
% new_death_cases{:,2:end} = death_cases{2:end,2:end}-death_cases{1:end-1,2:end};
% new_confirmed_cases.Week = week(new_confirmed_cases{:,1});
% new_death_cases.Week = week(new_death_cases{:,1});
% 
% weekly_new_confirmed = varfun(@sum,new_confirmed_cases(:,2:end),'GroupingVariables','Week');
% weekly_new_death = varfun(@sum,new_death_cases(:,2:end),'GroupingVariables','Week');
% weekly_new_confirmed = removevars(weekly_new_confirmed,{'GroupCount'});
% weekly_new_death = removevars(weekly_new_death,{'GroupCount'});
% weekly_new_confirmed = weekly_new_confirmed(1:end-1,:);
% weekly_new_death = weekly_new_death(1:end-1,:);
% 
% for i = 1:num_country
%     tmp_confirmed_cases = weekly_new_confirmed{:,i+1};
%     tmp_death_cases = weekly_new_death{:,i+1};
%     
%     % find the index of first case 
%     start_index = find(tmp_confirmed_cases~=0,1);
%     tmp_confirmed_cases = tmp_confirmed_cases(start_index:end);
%     tmp_death_cases = tmp_death_cases(start_index:end);
%     
%     % calculate death rates/increase
%     MR0 = calMR(tmp_confirmed_cases,tmp_death_cases,0);
%     MR7 = calMR(tmp_confirmed_cases,tmp_death_cases,1);
% 
%     % plot 
%     figure;
%     hold on;
%     
%     % plot death rate
%     Nominal_MR = death_cases{110,i+1}/confirmed_cases{110,i+1}*100;
%     plot([0,20],[Nominal_MR,Nominal_MR]);
%     %yyaxis left
%     plot(weekly_new_confirmed{start_index:end,1},MR0);
%     plot(weekly_new_confirmed{start_index+1:end,1},MR7);
%     ylabel("Mortality Rate(%)");
%     
%     % plot new confirmed cases
%     %yyaxis right
%     %plot(confirmed_cases{start_index+1:end,1},tmp_new_confirmed)
%     
%     legend("Nominal MR","lag = 0 days","lag = 7 days",'Location','northwest');
%     %ylabel("Number of daily new cases")
%     xlabel("Week");
%     
%     
%     title(countries{i+1});
% end
% 
