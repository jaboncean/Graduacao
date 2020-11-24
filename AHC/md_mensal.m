clear all
close all
clc

mdmen = [1224.22 979.84 911.31 693.91 491.09 420.56 367.75 335.17 336.78 380.53 594.98 932.74]
mdmen2 = mean(mdmen);  % 639.073
mdmen2vec = mdmen2*ones(1,12);
vecx = linspace(0.3,12.6, 12)
vecx1 = linspace(1,12,12)


plot(vecx,mdmen2vec,'r','linewidth', 4)
hold on 
bar(vecx1,mdmen,'b')

title('Médias mensais de vazão','fontsize',16,'fontweight','bold')
xlabel('Meses','fontsize',14,'fontweight', 'bold')
ylabel('Vazão(m^3/s)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [1 2 3 4 5 6 7 8 9 10 11 12],'XTickLabel',...
    {'Jan','Fev','Mar','Abr','Maio','Jun','Jul','Ago','Set','Out','Nov','Dez'});
grid on
set(gca,'FontSize',16,'fontweight','bold')
