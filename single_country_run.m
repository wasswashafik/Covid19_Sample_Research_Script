for i = 11:12
    tmp_confirmed_cases = confirmed_cases{:,i+1};
    tmp_death_cases = death_cases{:,i+1};
    %tmp_recovered_cases = recovered_cases{:,i+1};
    
    % find the index of first case 
    start_index = find(tmp_confirmed_cases~=0,1);
    tmp_confirmed_cases = tmp_confirmed_cases(start_index:end);
    tmp_death_cases = tmp_death_cases(start_index:end);
    %tmp_recovered_cases = tmp_recovered_cases(start_index:end);
    
    lag = 0;
    deleted_day = 0;
    MR0 = calMR(tmp_confirmed_cases,tmp_death_cases,0);
    MRlag = calMR(tmp_confirmed_cases,tmp_death_cases,lag);
    
    % plot 
    figure;
    hold on;
    
    % plot death rate
    % yyaxis left
    plot(confirmed_cases{start_index:end,1},MR0);
    plot(confirmed_cases{start_index+lag+deleted_day:end,1},MRlag(deleted_day+1:end));
    ylabel("Case Fatality Rate(%)");
    
    % plot total cases
    %yyaxis right
    %plot(confirmed_cases{start_index:end,1},tmp_confirmed_cases)
    laglegend = strcat(strcat("cCFR(lag = ",num2str(lag))," days)");
    legend("cCFR",laglegend,'Location','northwest');
    %ylabel("Confirmed Cases")
    xlabel("Date"); 
    title(countries{i+1});
    
    % result
    mdl = fitlm([1:length(MRlag)-deleted_day],MRlag(deleted_day+1:end),'linear');
    results.Country(i) = convertCharsToStrings(countries{i+1});
    results.Lag(i) = lag;
    results{i,3:5} = mdl.Coefficients{2,[1,2,4]};
    results{i,6:8} = mdl.Coefficients{1,[1,2,4]};

end

filename = 'result.xlsx';
writetable(results,filename,'Sheet',2);