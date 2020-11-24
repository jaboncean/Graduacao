% Lista 1 exercicio 7
%
% U(x,y)= (sin(x),sin(y));
%
close all
clear all
clc
U = @(x) sin(x);
V = @(y) sin(y);
DIV = @(x,y) cos(x)+cos(y);
%
range = linspace (-8, 8, 31);
[X, Y] = meshgrid (range, range);
%
Z = DIV(X, Y);
ZX = U(X);
ZY = V(Y); 
figure(1)
surfc (X, Y, Z);
%
figure(2)
axis equal
colormap(jet)
contourf(X,Y,Z)
hold on
quiver(X,Y,ZX,ZY,2,"w")
hold off
colorbar
