function [MR] = calMR_recovr(recover_cases,death_cases)
%calMR calculate mortality rate with a specific lag
MR = death_cases(1:end)./(death_cases(1:end)+recover_cases(1:end))*100;
end


