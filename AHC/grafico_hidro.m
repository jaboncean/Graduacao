clear all
close all
clc

xfile = xlsread('vazões_Paraíba_Sul2.xlsx',2);
xfile(isnan(xfile)) = [];

for i = 391:420;
    ano(i-390) = xfile(i);
end
for j = 361:390;
    mdano(j-360) = xfile(j);
end

ano = wrev(ano)
mdano = wrev(mdano)






plot(ano, mdano,'b','linewidth',4)
title('Médias anuais de vazão','fontsize',16,'fontweight','bold')
xlabel('Anos','fontsize',14,'fontweight', 'bold')
ylabel('Vazão(m^3/s)','fontsize',14,'fontweight', 'bold')
xticks([1990 1995 2000 2005 2010 2015 2019])
xlim([1990 2019])
grid on
set(gca,'FontSize',16,'fontweight','bold')