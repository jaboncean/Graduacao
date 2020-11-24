% Rotina para trabalhar dados de vazão da ANA


clear all
close all
clc

t = xlsread('vazoes_C_58974000.csv');

ini1 = 7;  % Linha que começa a serie temporal
fim1 = 366; % Linha que termina a serie temporal

t1 = datetime(1990,01,01);
t2 = datetime(2019,12,31);


for i = ini1:fim1;
    vz(i-6) = t(i,9);
end

vazao = wrev(vz);
figure(1)
plot(t4,vazao,'b','linewidth',3)

title('Médias mensais de vazão da estação 58974000 (1990-2019) - Rio Paraíba do Sul (Campos-RJ)','fontsize',16,'fontweight','bold')
xlabel('Meses','fontsize',14,'fontweight', 'bold')
ylabel('Vazão(m^3/s)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [0 24 48 72 96 120 144 168 192 216 240 264 288 312 336 360],'XTickLabel',...
    {'Jan-1990','1992','1994','1996','1998','2000','2002','2004',...
    '2006','2008','2010','2012','2014','2016','2018',...
    'Dez-2019',},...
    'XTickLabelRotation',45);
xlim([0 360])
grid on
set(gca,'FontSize',16,'fontweight','bold')


mdvz1 = mean(vazao(1:120));
mdvz2 = mean(vazao(121:240));
mdvz3 = mean(vazao(241:360));

MD1 = mdvz1*ones(120,1);
MD2 = mdvz2*ones(120,1);
MD3 = mdvz3*ones(120,1);

figure(2)
plot(t4(1:120),vazao(1:120),'b','linewidth',3);
hold on 
plot(t4(1:120),MD1,'r','linewidth',3);
hold off

title('Médias mensais de vazão da estação 58974000 (1990-1999) - Rio Paraíba do Sul (Campos-RJ)','fontsize',16,'fontweight','bold')
xlabel('Meses','fontsize',14,'fontweight', 'bold')
ylabel('Vazão(m^3/s)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [0 24 48 72 96 120],'XTickLabel',...
    {'Jan-1990','1992','1994','1996','1998','Dez-1999',},...
    'XTickLabelRotation',45);
xlim([0 120])
grid on
set(gca,'FontSize',16,'fontweight','bold')

figure(3)
plot(t4(1:120),vazao(121:240),'b','linewidth',3)
hold on 
plot(t4(1:120),MD2,'r','linewidth',3);
hold off

title('Médias mensais de vazão da estação 58974000 (2000-2009) - Rio Paraíba do Sul (Campos-RJ)','fontsize',16,'fontweight','bold')
xlabel('Meses','fontsize',14,'fontweight', 'bold')
ylabel('Vazão(m^3/s)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [0 24 48 72 96 120],'XTickLabel',...
    {'Jan-2000','2002','2004','2006','2008','Dez-2009',},...
    'XTickLabelRotation',45);
xlim([0 120])
grid on
set(gca,'FontSize',16,'fontweight','bold')

figure(4)
plot(t4(1:120),vazao(241:360),'b','linewidth',3)
hold on 
plot(t4(1:120),MD3,'r','linewidth',3);
hold off

title('Médias mensais de vazão da estação 58974000 (2010-2019) - Rio Paraíba do Sul (Campos-RJ)','fontsize',16,'fontweight','bold')
xlabel('Meses','fontsize',14,'fontweight', 'bold')
ylabel('Vazão(m^3/s)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [0 24 48 72 96 120],'XTickLabel',...
    {'Jan-2010','2012','2014','2016','2018','Dez-2019',},...
    'XTickLabelRotation',45);
xlim([0 120])
grid on
set(gca,'FontSize',16,'fontweight','bold')