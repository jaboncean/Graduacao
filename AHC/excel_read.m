clear all
close all
clc 

t = xlsread('vazoes_C_58974000.csv');

ini1 = 7;  % Linha que começa a serie temporal
fim1 = 366; % Linha que termina a serie temporal

ini2 = 17;  % Coluna que começa os dados diários
fim2 = 47;  % Coluna que termina os dados diários

% Aqui é feita uma varredura em todos os dados e salvos em
% uma única linha

for i=ini1:fim1;
    for j=ini2:fim2;
    vazao(1,31*(i-(ini1-1)-1)+j-(ini2-1)) = t(i,j);
    end
end

vazao(isnan(vazao)) = [];% Apagando os valores NaN

vazao = vazao';

% Salvando para ser aberto no Excel
% xlswrite('transposto_vazao.xlsx',vazao);



vazao_ordenada = sort(vazao,'descend');
% xlswrite('transposto_vazao_ordenado.xlsx',vazao_ordenada);


hierarq = linspace(1,10957,10957);

for i=1:10957;
    prob(i) = (hierarq(i)/10957)*100;
   
end

prob = prob'

Q90 = vazao_ordenada(9862);
vec = Q90*ones(1,9862);

vecp = prob(1:9862)

plot(prob,vazao_ordenada,'b','linewidth',2.5)
hold on 
plot(vecp, vec, 'r', 'linewidth', 2)

title('Vazão x Probabilidade de Excedência ou Igualdade','fontsize',16,'fontweight','bold')
xlabel('Probabilidade de Excedência ou Igualdade (%)','fontsize',14,'fontweight', 'bold')
ylabel('Vazão(m^3/s)','fontsize',14,'fontweight', 'bold')
grid on
set(gca,'FontSize',16,'fontweight','bold')
annotation('textarrow',[0.686459087617668 0.813178855901521],...
    [0.410572052401747 0.168122270742358],'TextColor',[1 0 0],...
    'String',{'Q90 = 245.08 m³/s'},...
    'FontWeight','bold',...
    'FontSize',20);
