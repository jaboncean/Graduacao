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

mesi = 1;
mesf = 30;
for i = ini1:11:fim1;
    for m = mesi:mesf;
        for j = 1:12;
        ano(j,m) = t(j-1+ini1,9);
        end
        mdano(m) = sum(ano(:,m)/12); 
    end
end 


for i = 7:366;
    tudo(i) = t(i,9);
end

tudo = wrev(tudo);

max(tudo)

tdorg = sort(tudo)

plot(tudo)

