% Programa para calcular as 4 posi��es da grade em volta de um ponto
% lagrangeano

% 16/07/2020

clear all
close all
clc



% Carregando campo de velocidade
A = load('velo');

% Criando matrizes 21x21 com zeros
U = zeros(21,21);
V = zeros(21,21);

% Separando as componentes U e V do campo de velocidade
U = A(1:21,:);
V = A(22:42,:);

% Criando vetores de -1 a 1, divididos em 21 elementos
x = linspace(-1,1,21);
y = linspace(-1,1,21);

% Criando matriz com os vetores x e y
[X,Y]= meshgrid(x,y);

% Definindo posi��o (x,y) da part�cula lagrangeana
XP = 0.6*cos(pi/6);
YP = 0.6*sin(pi/6);

% Calculando dx e dy
dx = x(2) - x(1);
dy = y(2) - y(1);

% Os pontos s�o definidos de forma anti-hor�ria

% Definindo o ponto do corner (canto) esquerdo inferior � part�cula
I1 = floor((XP-X(1,1))/dx)+1; % Valor de X contando a origem
J1 = floor((YP-Y(1,1))/dy)+1; % Valor de Y contando a origem

% Definindo o ponto do corner direito inferior � part�cula
I2 = I1 + 1 ;
J2 = J1;

% Definindo o ponto do corner direito superior � part�cula
I3 = I2;
J3 = J2 +1;

% Definindo o ponto do corner esquerdo superior � part�cula
I4 = I3 - 1;
J4 = J3;

% Gerando figura com a malha XY e colocando para visualiz�-la em 2D
figure(1)
mesh(X,Y,Y*0);
view(0,90);

hold on 
% Plotando o campo de velocidade, sobre a grade, na cor preta
quiver(X,Y,U,V,'k')
% Plotando o ponto em que a part�cula se encontra
plot(XP,YP,'+r')
% Plotando o ponto origem da grade
plot(X(1,1),Y(1,1),'*g')
% Plotando os corners (cantos), em torno do ponto no qual a part�cula se
% encontra
plot(X(J1,I1),Y(J1,I1),'*r')
plot(X(J2,I2),Y(J2,I2),'*r')
plot(X(J3,I3),Y(J3,I3),'*r')
plot(X(J4,I4),Y(J4,I4),'*r')


% Usando interpola��o 2-D da fun��o do matlab (convencional)
Ui = interp2(X,Y,U,XP,YP);
Vi = interp2(X,Y,V,XP,YP);

% for zz = 1:21;
%     X(22,zz) = 0;
%     Y(22,zz) = 0;
%     U(22,zz) = 0;
%     V(22,zz) = 0;
% end
% 
% for zy = 1:21;
% %    X(zy,22) = 0;
% %    Y(zy,22) = 0;
% %    U(zy,22) = 0;
% %    V(zy,22) = 0;
% 
% end
% 

% hold on
% % Plotando a velocidade da part�cula.
% %quiver(XP,YP,Ui,Vi,0.0118,'MaxHeadSize',1);
% axis equal
% hold off

del_x = XP - X(J1,I1); % X - X0
delta_x = X(J1,I2) - X(J1,I1); % X1 - X0
del_y = YP - Y(J1,I1); % Y - Y0
delta_y = Y(J4,I1) - Y(J1,I1); % Y1 - Y0
ddx = del_x/delta_x;
ddy = del_y/delta_y;

% Usando equa��o para interpola��o em 2-D
Uint2d = (ddx*ddy*U(J3,I3))+(ddy*(1-ddx)*U(J4,I4))+(ddx*(1-ddy)*U(J2,I2))+((1-ddx-ddy+ddx*ddy)*U(J1,I1))
Vint2d = (ddx*ddy*V(J3,I3))+(ddy*(1-ddx)*V(J4,I4))+(ddx*(1-ddy)*V(J2,I2))+((1-ddx-ddy+ddx*ddy)*V(J1,I1))









