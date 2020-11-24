t = xlsread('corte_chuvas.ods');

total = t(:,3);
diascomchuva = t(:,5);

total = wrev(total);
diascomchuva = wrev(diascomchuva);

t2 = linspace(1,360,360);
t3 = linspace(1,12,12);
t4 = linspace(0.3,12.6, 12);
t5 = linspace(0.3,30.6,30);
t6 = linspace(1,30,30);

for j = 0:30;
    for i = 1:12;
        if j == 30;
        break 
        end
        md(j+1, i) = total(i+j*12);
    end
end

for i = 1:12;
mdmeses(i) = mean(md(:,i));
end

for i = 1:30;
mdanos(i) = mean(md(i,:));
end

mdtotano = mean(mdanos);
mdan = mdtotano*ones(1,30);

mdtot = mean(mdmeses);
mdmen = mdtot*ones(1,12);

figure(1)
plot(t4,mdmen,'r','linewidth', 4)
hold on 
bar(t3,mdmeses,'b')
hold off

title('Médias históricas mensais de precipitação total da estação 02141005 (1990-2019) - Rio Paraíba do Sul (São Fidélis-RJ)','fontsize',16,'fontweight','bold')
xlabel('Meses','fontsize',14,'fontweight', 'bold')
ylabel('Precipitação(mm/mes)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [1 2 3 4 5 6 7 8 9 10 11 12],'XTickLabel',...
    {'Jan','Fev','Mar','Abr','Maio','Jun','Jul','Ago','Set','Out','Nov','Dez'});
grid on
set(gca,'FontSize',16,'fontweight','bold')


figure(2)
plot(t6,mdan,'r','linewidth',4)
hold on
plot(t6,mdanos,'b','linewidth',4)

title('Médias anuais de precipitação total da estação 02141005 (1990-2019) - Rio Paraíba do Sul (São Fidélis-RJ)','fontsize',16,'fontweight','bold')
xlabel('Anos','fontsize',14,'fontweight', 'bold')
ylabel('Precipitação(mm/mes)','fontsize',14,'fontweight', 'bold')
set(gca,'FontSize',16,'FontWeight','bold','XTick',...
    [1 4 7 10 13 16 19 22 25 28  30],'XTickLabel',...
    {'1990','1993','1996','1999','2002','2005','2008','2011','2014','2017','2019'});
grid on
set(gca,'FontSize',16,'fontweight','bold')