clear all
close all
clc

t = xlsread('corte_chuvas.ods');

total = t(:,3);
diascomchuva = t(:,5);

total = wrev(total);
diascomchuva = wrev(diascomchuva);
diascomchuva(264,1) = 10;
diascomchuva(295,1) = 3;
diascomchuva(326,1) = 6;

t2 = linspace(1,360,360);
t3 = linspace(1,120,120);

figure(1)
plot(t2,total,'b','linewidth',3)
hold on
plot(t2,diascomchuva,'r','linewidth',2)

title('Precipitação total mensal da estação 02141005 (1990-2019) - Rio Paraíba do Sul (São Fidélis-RJ)','fontsize',16,'fontweight','bold')
xlabel('Meses','fontsize',14,'fontweight', 'bold')
ylabel('Precipitação(mm/mes)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [0 24 48 72 96 120 144 168 192 216 240 264 288 312 336 360],'XTickLabel',...
    {'Jan-1990','1992','1994','1996','1998','2000','2002','2004',...
    '2006','2008','2010','2012','2014','2016','2018',...
    'Dez-2019',},...
    'XTickLabelRotation',45);

set(legend,...
    'Position',[0.778070177948265 0.825145562034333 0.111052629069278 0.0594978149671221]);

xlim([0 360])
grid on
set(gca,'FontSize',16,'fontweight','bold')
%
hold off
%
figure(2)
plot(t3,total(1:120,1),'b','linewidth',3)
hold on
plot(t3,diascomchuva(1:120,1),'g','linewidth',2)

mddec1=mean(total(1:120));
mddec1vec=mddec1*ones(1,120);
hold on
plot(t3,mddec1vec,'r','linewidth',3)
hold off

title('Precipitação total mensal da estação 02141005 (1990-1999) - Rio Paraíba do Sul (São Fidélis-RJ)','fontsize',16,'fontweight','bold')
xlabel('Meses','fontsize',14,'fontweight', 'bold')
ylabel('Precipitação(mm/mes)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [1 24 48 72 96 120],'XTickLabel',...
    {'Jan-1990','1992','1994','1996','1998','Dez-1999'},...
    'XTickLabelRotation',45);

set(legend,...
    'Position',[0.778070177948265 0.825145562034333 0.111052629069278 0.0594978149671221]);

xlim([1 120])
grid on
set(gca,'FontSize',16,'fontweight','bold')
%
hold off
%
figure(3)
plot(t3,total(121:240,1),'b','linewidth',3)
hold on
plot(t3,diascomchuva(121:240,1),'g','linewidth',2)
mddec2=mean(total(121:240));
mddec2vec=mddec2*ones(1,120);
hold on
plot(t3,mddec2vec,'r','linewidth',3)


title('Precipitação total mensal da estação 02141005 (2000-2009) - Rio Paraíba do Sul (São Fidélis-RJ)','fontsize',16,'fontweight','bold')
xlabel('Meses','fontsize',14,'fontweight', 'bold')
ylabel('Precipitação(mm/mes)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [1 24 48 72 96 120],'XTickLabel',...
    {'Jan-2000','2002','2004',...
    '2006','2008','Dez-2009'},...
    'XTickLabelRotation',45);

set(legend,...
    'Position',[0.778070177948265 0.825145562034333 0.111052629069278 0.0594978149671221]);

xlim([1 120])
grid on
set(gca,'FontSize',16,'fontweight','bold')
%
hold off
%
figure(4)
plot(t3,total(241:360,1),'b','linewidth',3)
hold on
plot(t3,diascomchuva(241:360,1),'g','linewidth',2)
mddec3=mean(total(241:360));
mddec3vec=mddec3*ones(1,120);
hold on
plot(t3,mddec3vec,'r','linewidth',3)


title('Precipitação total mensal da estação 02141005 (2010-2019) - Rio Paraíba do Sul (São Fidélis-RJ)','fontsize',16,'fontweight','bold')
xlabel('Meses','fontsize',14,'fontweight', 'bold')
ylabel('Precipitação(mm/mes)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [1 24 48 72 96 120],'XTickLabel',...
    {'Jan-2010','2012','2014',...
    '2016','2018','Dez-2019'},...
    'XTickLabelRotation',45);

set(legend,...
    'Position',[0.778070177948265 0.825145562034333 0.111052629069278 0.0594978149671221]);

xlim([1 120])
grid on
set(gca,'FontSize',16,'fontweight','bold')
%
hold off
%