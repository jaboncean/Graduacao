% Programa para calcular as 4 posições da grade em volta de uma partícula
% lagrangeana

clear all
close all
clc

% Carregando campo de velocidade
U = load('UD.dat');
V = load('VD.dat');
% Criando vetores de -1 a 1, divididos em 21 elementos
x = linspace(-1,1,21);
y = linspace(-1,1,21);
% Criando uma grade para tender o deslocamento da velocidade
x2 = linspace(-1.05,0.95,21);
y2 = linspace(-1.05,0.95,21);
% Criando matriz com os vetores x e y
[X,Y]= meshgrid(x,y);
% [X2,Y2]= meshgrid(x2,y2);
[X3,Y3] = meshgrid(x2,y);
[X4,Y4] = meshgrid(x,y2);

% Definindo posição (x,y) da partícula lagrangeana
XP = -0.5*cos(pi/3);
YP = -0.5*sin(pi/3);
% XP = 0.2811
% YP = 0.7749
% Calculando dx e dy
dx = x(2) - x(1);
dy = y(2) - y(1);
 % Definindo o ponto do corner (canto) esquerdo inferior à partícula
I1 = floor((XP-X(1,1))/dx)+1; % Valor de X contando a origem
J1 = floor((YP-Y(1,1))/dy)+1; % Valor de Y contando a origem
% Definindo o ponto do corner direito inferior à partícula
I2 = I1 + 1 ;
J2 = J1;
% Definindo o ponto do corner direito superior à partícula
I3 = I2;
J3 = J2 +1;
% Definindo o ponto do corner esquerdo superior à partícula
I4 = I3 - 1;
J4 = J3;   

I1u = floor((XP-X4(1,1))/dx)+1; % Valor de X contando a origem
J1u = floor((YP-Y4(1,1))/dy)+1; % Valor de Y contando a origem
% Definindo o ponto do corner direito inferior à partícula
I2u = I1u + 1 ;
J2u = J1u;
% Definindo o ponto do corner direito superior à partícula
I3u = I2u;
J3u = J2u +1;
% Definindo o ponto do corner esquerdo superior à partícula
I4u = I3u - 1;
J4u = J3u;   

I1v = floor((XP-X3(1,1))/dx)+1; % Valor de X contando a origem
J1v = floor((YP-Y3(1,1))/dy)+1; % Valor de Y contando a origem
% Definindo o ponto do corner direito inferior à partícula
I2v = I1v + 1 ;
J2v = J1v;
% Definindo o ponto do corner direito superior à partícula
I3v = I2v;
J3v = J2v +1;
% Definindo o ponto do corner esquerdo superior à partícula
I4v = I3v - 1;
J4v = J3v;   


%
R = 0.5;
G = 1;
Vel = G/R;
T = 2*pi*R/Vel;
nt = 400;
dt = T/nt;
%
figure(1)
mesh(X,Y,Y*0);
view(0,90);

hold on 
% % Plotando o campo de velocidade, sobre a grade, na cor preta
quiver(X4,Y4,U,V*0,'k')
 
quiver(X3,Y3,U*0,V,'k')
% % Plotando o ponto em que a partícula se encontra
plot(XP,YP,'og')
 % % Plotando o ponto origem da grade
plot(X(1,1),Y(1,1),'*g')
% % Plotando os corners (cantos), em torno do ponto no qual a partícula se
% % encontra - V

 plot(X3(J1v,I1v),Y3(J1v,I1v),'sr')
 plot(X3(J2v,I2v),Y3(J2v,I2v),'*r')
 plot(X3(J3v,I3v),Y3(J3v,I3v),'*r')
 plot(X3(J4v,I4v),Y3(J4v,I4v),'*r')
% Plotando os corners (cantos), em torno do ponto no qual a partícula se
% encontra - U
 plot(X4(J1u,I1u),Y4(J1u,I1u),'sb')
 plot(X4(J2u,I2u),Y4(J2u,I2u),'*b')
 plot(X4(J3u,I3u),Y4(J3u,I3u),'*b')
 plot(X4(J4u,I4u),Y4(J4u,I4u),'*b')
 hold off

% 
% % Usando equação para interpolação em 2-D
 del_xu = XP - X4(J1u,I1u); % X - X0
 delta_xu = X4(J1u,I2u) - X4(J1u,I1u); % X1 - X0
 del_yu = YP - Y4(J1u,I1u); % Y - Y0
 delta_yu = Y4(J4u,I1u) - Y4(J1u,I1u); % Y1 - Y0
 ddxu = del_xu/delta_xu;
 ddyu = del_yu/delta_yu;
 
 del_xv = XP - X3(J1v,I1v); % X - X0
 delta_xv = X3(J1v,I2v) - X3(J1v,I1v); % X1 - X0
 del_yv = YP - Y3(J1v,I1v); % Y - Y0
 delta_yv = Y3(J4v,I1v) - Y3(J1v,I1v); % Y1 - Y0
 ddxv = del_xv/delta_xv;
 ddyv = del_yv/delta_yv;
 
 
 % Interpolação
Uint2d = (ddxu*ddyu*U(J3u,I3u))+(ddyu*(1-ddxu)*U(J4u,I4u))+(ddxu*(1-ddyu)*U(J2u,I2u))+((1-ddxu-ddyu+ddxu*ddyu)*U(J1u,I1u));
Vint2d = (ddxv*ddyv*V(J3v,I3v))+(ddyv*(1-ddxv)*V(J4v,I4v))+(ddxv*(1-ddyv)*V(J2v,I2v))+((1-ddxv-ddyv+ddxv*ddyv)*V(J1v,I1v));    


% 
% 
 for n = 1:nt;
% 
%     
I1u = floor((XP-X4(1,1))/dx)+1; % Valor de X contando a origem
J1u = floor((YP-Y4(1,1))/dy)+1; % Valor de Y contando a origem
% Definindo o ponto do corner direito inferior à partícula
I2u = I1u + 1 ;
J2u = J1u;
% Definindo o ponto do corner direito superior à partícula
I3u = I2u;
J3u = J2u +1;
% Definindo o ponto do corner esquerdo superior à partícula
I4u = I3u - 1;
J4u = J3u;   

I1v = floor((XP-X3(1,1))/dx)+1; % Valor de X contando a origem
J1v = floor((YP-Y3(1,1))/dy)+1; % Valor de Y contando a origem
% Definindo o ponto do corner direito inferior à partícula
I2v = I1v + 1 ;
J2v = J1v;
% Definindo o ponto do corner direito superior à partícula
I3v = I2v;
J3v = J2v +1;
% Definindo o ponto do corner esquerdo superior à partícula
I4v = I3v - 1;
J4v = J3v;   
%  % 
% 
 del_xu = XP - X4(J1u,I1u); % X - X0
 delta_xu = X4(J1u,I2u) - X4(J1u,I1u); % X1 - X0
 del_yu = YP - Y4(J1u,I1u); % Y - Y0
 delta_yu = Y4(J4u,I1u) - Y4(J1u,I1u); % Y1 - Y0
 ddxu = del_xu/delta_xu;
 ddyu = del_yu/delta_yu;
 
 del_xv = XP - X3(J1v,I1v); % X - X0
 delta_xv = X3(J1v,I2v) - X3(J1v,I1v); % X1 - X0
 del_yv = YP - Y3(J1v,I1v); % Y - Y0
 delta_yv = Y3(J4v,I1v) - Y3(J1v,I1v); % Y1 - Y0
 ddxv = del_xv/delta_xv;
 ddyv = del_yv/delta_yv;
 

Uint2d = (ddxu*ddyu*U(J3u,I3u))+(ddyu*(1-ddxu)*U(J4u,I4u))+(ddxu*(1-ddyu)*U(J2u,I2u))+((1-ddxu-ddyu+ddxu*ddyu)*U(J1u,I1u));
Vint2d = (ddxv*ddyv*V(J3v,I3v))+(ddyv*(1-ddxv)*V(J4v,I4v))+(ddxv*(1-ddyv)*V(J2v,I2v))+((1-ddxv-ddyv+ddxv*ddyv)*V(J1v,I1v));  


 XQ = XP+Uint2d*dt;
 YQ = YP+Vint2d*dt;
% 
% 
% 

% 
 hold on
 plot(XP,YP,'+r')
 
 XP = XQ;
 YP = YQ;
%  plot(X3(J1,I1),Y3(J1,I1),'*r')
%  plot(X3(J2,I2),Y3(J2,I2),'*r')
%  plot(X3(J3,I3),Y3(J3,I3),'*r')
%  plot(X3(J4,I4),Y3(J4,I4),'*r')
% Plotando os corners (cantos), em torno do ponto no qual a partícula se
% encontra - U
%  plot(X4(J1,I1),Y4(J1,I1),'*b')
%  plot(X4(J2,I2),Y4(J2,I2),'*b')
%  plot(X4(J3,I3),Y4(J3,I3),'*b')
%  plot(X4(J4,I4),Y4(J4,I4),'*b')
  drawnow
 axis equal
% 
 end

 
 

