% 2.- Considere que no tempo de referência t=0, a partícula P se encontra
% em(xp, yp)=(Rcosθ,Rsin θ) e (R,θ)=(0.5 ,10º). Traçar a trajetória 
% da partícula até o tempo t=T=2π R/√(u^2+v^2). Usar como passo de
% tempo a) Δt=T /200 , b) Δt=T/ 400 , c) Δt=T /800, d) Δt=T/1600 ,
% e) Δt=T /3200 , f) Δt=T /6400 .

close all
clear all
clc

% Criando vetores de -1 a 1, divididos em 21 elementos
x = linspace(-1,1,21);
y = linspace(-1,1,21);

% Criando matriz com os vetores x e y
[X,Y]= meshgrid(x,y);

% Os pontos são definidos de forma anti-horária
G = 1;
u = -G*Y./(X.^2+Y.^2);
v = G*X./(X.^2+Y.^2);
R = 0.5;
Vel = sqrt((u.*u)+(v.*v));
T = 2*pi*R./Vel;
% nt = [200 400 800 1600 3200 6400];
% dt = T/nt(1,1);

% Definindo posição (x,y) da partícula lagrangeana
XP = R*cosd(10);
YP = R*sind(10);

up = -G*YP/(XP^2+YP^2);
vp = G*XP/(XP^2+YP^2);
Velp = sqrt(up*up+vp*vp);
Tp = 2*pi*R/Velp;
nt = [200 400 800 1600 3200 6400];
dt = Tp./nt;

figure(1)
subplot(3,2,1);
mesh(X,Y,Y*0)
view(0,90)
axis equal
hold on
plot(XP,YP,'g+')
title('dt = T/200');
% 
%
for n = 1:nt(1)+1;
    
up = -G*YP./(XP.^2+YP.^2);
vp = G*XP./(XP.^2+YP.^2);
XPN = XP+up*dt(1);
YPN = YP+vp*dt(1);

hold on

plot(XPN,YPN,'b+')

XP = XPN;
YP = YPN;
end

XP = R*cosd(10);
YP = R*sind(10);

up = -G*YP/(XP^2+YP^2);
vp = G*XP/(XP^2+YP^2);
Velp = sqrt(up*up+vp*vp);
Tp = 2*pi*R/Velp;
nt = [200 400 800 1600 3200 6400];
dt = Tp./nt;

subplot(3,2,2);
mesh(X,Y,Y*0)
view(0,90)
axis equal
hold on
plot(XP,YP,'g+')
title('dt = T/400');

for n = 1:nt(2)+1;
    
up = -G*YP./(XP.^2+YP.^2);
vp = G*XP./(XP.^2+YP.^2);
XPN = XP+up*dt(2);
YPN = YP+vp*dt(2);

hold on

plot(XPN,YPN,'b+')

XP = XPN;
YP = YPN;
end

XP = R*cosd(10);
YP = R*sind(10);

up = -G*YP/(XP^2+YP^2);
vp = G*XP/(XP^2+YP^2);
Velp = sqrt(up*up+vp*vp);
Tp = 2*pi*R/Velp;
nt = [200 400 800 1600 3200 6400];
dt = Tp./nt;

subplot(3,2,3);
mesh(X,Y,Y*0)
view(0,90)
axis equal
hold on

plot(XP,YP,'g+')
title('dt = T/800');

for n = 1:nt(3)+1;
    
up = -G*YP./(XP.^2+YP.^2);
vp = G*XP./(XP.^2+YP.^2);
XPN = XP+up*dt(3);
YPN = YP+vp*dt(3);

hold on

plot(XPN,YPN,'b+')

XP = XPN;
YP = YPN;
end

XP = R*cosd(10);
YP = R*sind(10);

up = -G*YP/(XP^2+YP^2);
vp = G*XP/(XP^2+YP^2);
Velp = sqrt(up*up+vp*vp);
Tp = 2*pi*R/Velp;
nt = [200 400 800 1600 3200 6400];
dt = Tp./nt;

subplot(3,2,4);
mesh(X,Y,Y*0)
view(0,90)
axis equal
hold on

plot(XP,YP,'g+')
title('dt = T/1600');

for n = 1:nt(4)+1;
    
up = -G*YP./(XP.^2+YP.^2);
vp = G*XP./(XP.^2+YP.^2);
XPN = XP+up*dt(4);
YPN = YP+vp*dt(4);

hold on

plot(XPN,YPN,'b+')

XP = XPN;
YP = YPN;
end

XP = R*cosd(10);
YP = R*sind(10);

up = -G*YP/(XP^2+YP^2);
vp = G*XP/(XP^2+YP^2);
Velp = sqrt(up*up+vp*vp);
Tp = 2*pi*R/Velp;
nt = [200 400 800 1600 3200 6400];
dt = Tp./nt;

subplot(3,2,5);
mesh(X,Y,Y*0)
view(0,90)
axis equal
hold on

plot(XP,YP,'g+')
title('dt = T/3200');

for n = 1:nt(5)+1;
    
up = -G*YP./(XP.^2+YP.^2);
vp = G*XP./(XP.^2+YP.^2);
XPN = XP+up*dt(5);
YPN = YP+vp*dt(5);

hold on

plot(XPN,YPN,'b+')

XP = XPN;
YP = YPN;
end


XP = R*cosd(10);
YP = R*sind(10);

up = -G*YP/(XP^2+YP^2);
vp = G*XP/(XP^2+YP^2);
Velp = sqrt(up*up+vp*vp);
Tp = 2*pi*R/Velp;
nt = [200 400 800 1600 3200 6400];
dt = Tp./nt;

subplot(3,2,6);
mesh(X,Y,Y*0)
view(0,90)
axis equal
hold on

plot(XP,YP,'g+')
title('dt = T/6400');

for n = 1:nt(6)+1;
    
up = -G*YP./(XP.^2+YP.^2);
vp = G*XP./(XP.^2+YP.^2);
XPN = XP+up*dt(6);
YPN = YP+vp*dt(6);

hold on

plot(XPN,YPN,'b+')

XP = XPN;
YP = YPN;
end



