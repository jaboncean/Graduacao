%========Falta revisão=========




close all
clear all
clc

%=====Função pro gradiente====
Uv = @(x,y) sin(y) + cos(x+pi/2) 
u = @(y) sin(y);
v = @(x) cos(x+pi/2);
ROT = @(x,y) -sin(x+pi/2) - cos(y) ;

range = linspace (-8, 8, 41);
[X, Y] = meshgrid (range, range);

Z = ROT(X, Y);
figure(1)
surfc (X, Y, Z);



ZX = u(Y);
ZY = v(X); 

Q = Uv (X, Y);
figure(2)
axis equal
colormap(jet)
contourf(X,Y,Q)
hold on
quiver(X,Y,ZX,ZY,2,"w")
hold off
colorbar






%=====Rotacional========
u = @(x) sin(y);
v = @(y) cos(x+pi/2);
ROT = @(x,y) -sin(x+pi/2) - cos(y) ;




