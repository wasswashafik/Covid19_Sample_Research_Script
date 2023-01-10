function [MR] = calMR(confirmed_cases,death_cases,lag)
%calMR calculate mortality rate with a specific lag
MR = death_cases(1+lag:end)./confirmed_cases(1:end-lag)*100;
end

