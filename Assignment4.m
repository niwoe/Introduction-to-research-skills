%{
Title: Sustainability of future demand for lithium-ion batteries
content: Quantitative analysis of projected energy storage needs and capacity
sources of default values : 
[g/kWh] of lithium for a battery : Morgan Stanley, Global Lithium Research,
13.09.2018, https://linkback.morganstanley.com/web/sendlink/webapp/f/7pb1532o-3q5n-g01d-9747-005056013700?store=0&d=UwBSZXNlYXJjaF9NUwAyMWQ5MDVlNC1iNmJiLTExZTgtODYyNS1kNDgyNmJhNGY2OTI%3D&user=di1o3sc4yv07s-321&__gda__=1789121908_06f840205215d06755d7580118e1bb1c
Global Lithium reserve [tons of LCE] : US Geological Survey, Mineral
commodity summaries, 2021, https://pubs.usgs.gov/periodicals/mcs2021/mcs2021.pdf
final energy consumption in 2050 [TWh] : EnerOutlook 2050 , Enerdata , https://eneroutlook.enerdata.net/forecast-world-final-energy-consumption.html
Author: Nicolas Woerle
EPFL 
Created: 25/10/2021
Last update: 25/10/2021
%}
clc 
close all 
clear all 

%% INPUT
prompt = {'[g/kWh] of lithium for a battery (not LCE)'...
    ,'Global Lithium reserve [tons of LCE]'...
    ,'final energy consumption in 2050 [TWh]'...
    ,'storage time [Hours]'};

dlgtitle = 'Inputs';
dims = [1 120];
definput = {'150','80000000',...
'139560','6 12 24 168'};
answer = inputdlg(prompt,dlgtitle,dims,definput);  

% ACQUISITION OF PARAMETERS
% Energy density
gkWh = str2num(answer{1}) ;

% global lithium reserve 
res = str2num(answer{2}) ;

% final energy consumption in 2050
fin50 = str2num(answer{3}) ;

% storage time vector 
times = str2num(answer{4}) ;

%% CALCULATION
% corresponding storage capacity [TWh]
stor = times/8760*fin50;

% tons of lithium for a TWh of storage 
tTWh = Convert_gkWhTOtTWh(gkWh);

% convesrion of LCE in Li
resLi = res / 5.3 ; 

% storage needed / storage possible 
ratio = stor * tTWh / resLi ; 

%% RESULTS 
figure 
set(gcf, 'WindowState', 'maximized');
bar(ratio)
set(gca,'xticklabel',times)
xlabel('storage time required according to the scenario [Hours]') 
ylabel('ratio between required and possible storage')
title('Global energy storage capacity according to the scenario (if the ratio is less than 1 then storage is possible)')
text(1:length(ratio),ratio,num2str(ratio'),'vert','bottom','horiz','center'); 
box off

