% 1.- Usando o campo de velocidades (u , v ) definido na notas de aula. Plotar
% o campo de velocidades para a intensidade do vórtice igual a Γ=2m2/s.

clear all
close all
clc

% Criando vetores de -1 a 1, divididos em 21 elementos
x = linspace(-1,1,21);
y = linspace(-1,1,21);

% Criando matriz com os vetores x e y
[X,Y]= meshgrid(x,y);

% Os pontos são definidos de forma anti-horária
G = 2;
u = -G*Y./(X.^2+Y.^2);
v = G*X./(X.^2+Y.^2);

% Gerando grade e campo de velocidade
figure(1)
mesh(X,Y,Y*0)
view(0,90)
axis equal
hold on
quiver(X,Y,u,v,'k','linewidth',1.5)
