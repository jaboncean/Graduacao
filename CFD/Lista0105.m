%Lista 1 exercicio 6
%
% T(x,y)=-2x+3y;
%
close all
clear all
clc

%=======Inserir Funções=========
%T = @(x,y) (x.^2 + y.^2);
T = @(x,y) (-2*x.^2 + 3*y.^2);
%T = @(x,y) sin (sqrt (x.^2 + y.^2)) ./ sqrt (x.^2 + y.^2);
%T = @(x,y) 

%======Tamanho Matriz==========
range = linspace (-8, 8, 41);
[X, Y] = meshgrid (range, range);

Z = T (X, Y);
figure(1)
surfc (X, Y, Z);

[ZX, ZY] = gradient (Z);
figure(2)
axis equal
colormap(jet)

contourf(X,Y,Z)
hold on
quiver(X,Y,ZX,ZY,2,'w')

hold off
colorbar
