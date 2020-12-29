clear all
close all
clc
% Carregando campo de velocidade
A = load('velo');

% Criando matrizes 21x21 com zeros
U = zeros(21,21);
V = zeros(21,21);

%  qr = 1.5*[-1:1/10:1];
%  U = 0*ones(21,21);
% % 
%  V = -ones(21,21).*qr;

% Separando as componentes U e V do campo de velocidade
U = A(1:21,:);
V = A(22:42,:);

% Criando vetores de -1 a 1, divididos em 21 elementos
x = linspace(-1,1,21);
y = linspace(-1,1,21);

% Criando matriz com os vetores x e y
[X,Y]= meshgrid(x,y);

% Calculando dx e dy
dx = x(2) - x(1);
dy = y(2) - y(1);

% Definindo valores das constantes R e Vel.
R = 0.5;
Vel = 2;
T = 2*pi*R./Vel;
nt = 600;
del_t = T/nt;
dt = T/nt;
% Altura da rugosidade do fundo (ks)
% Areia grossa (0.03m)
% Areia média e fina (0.02m)
% Argila (0.01m)
ks = 0.02;
% Constante admensional de dispersão longitudinal (kL)
kL = 13;
% Constante admensional de difusão turbulenta lateral (kT)
kT = 1;
% Gravidade 
g = 9.8;
% Profundidade total da água (H = h + n)
% H = 1 + 0.5.*randn(21) + 13;
% H = ones(21,21)*13;
H = 10;

% Massa específica do ar (Kg/m^3)
rhoar = 1.292;
% Massa específica do fluido (Kg/m^3)
rhoagua = 1026;
% Coeficiente de fricção de Darcy-Weisbach (lambda)
lambda = 8/((5.75*log10(12.27*(H/ks)))^2);
% Coeficiente de rugosidade de Chezy (m^1/2 * s^-1)
C = sqrt(8*g/lambda);

 p = U*H;
 q = V*H;
% 
% 
Dxx1 = ((kL*(p.^2) + kT*(q.^2))*sqrt(g))./(C*sqrt((p.^2)+(q.^2)))/50000;
Dyy1 = ((kL*(q.^2) + kT*(p.^2))*sqrt(g))./(C*sqrt((p.^2)+(q.^2)))/50000;

part = 500;
XP = R*cosd(10);
YP = R*sind(10);

XPvec(1) = XP;
YPvec(1) = YP;
for i = 1:part;



XPmax = XP + dx/1;
XPmin = XP - dx/1;
YPmax = YP + dy/1;
YPmin = YP - dy/1;
Yrg = linspace(YPmin,YPmax, 1000);
Xrg = linspace(XPmin,XPmax, 1000);

randx(i) = Xrg(randperm(length(Xrg),1));
randy(i) = Yrg(randperm(length(Yrg),1));

% APLICAR IDEIA DE POISON

plot(randx, randy, '+b')

% O retangulo tem area delta x e delta y, sendo o ponto central o XP e YP
% Utilizar distribuição de Poison nessa área da mancha.
% XP + dx/2 
% XP - dx/2
% Area dx*dy centrado em XP e YP

XPvec(i) = randx(i);
YPvec(i) = randy(i);

end

for n = 1:nt;


for i = 1:part;
    
phi = randn;
psi = randn;
% Definindo o ponto do corner (canto) esquerdo inferior à partícula
I1(n,i) = floor((XPvec(n,i)-X(1,1))/dx)+1; % Valor de X contando a origem
J1(n,i) = floor((YPvec(n,i)-Y(1,1))/dy)+1; % Valor de Y contando a origem
% Definindo o ponto do corner direito inferior à partícula
I2(n,i) = I1(n,i) + 1 ;
J2(n,i) = J1(n,i);
% Definindo o ponto do corner direito superior à partícula
I3(n,i) = I2(n,i);
J3(n,i) = J2(n,i) +1;
% Definindo o ponto do corner esquerdo superior à partícula
I4(n,i) = I3(n,i) - 1;
J4(n,i) = J3(n,i);

% Definindo deltas para facilitar o uso da equação de interpolação
del_x(n,i) = XPvec(n,i) - X(J1(n,i),I1(n,i)); % X - X0
delta_x(n,i) = X(J1(n,i),I2(n,i)) - X(J1(n,i),I1(n,i)); % X1 - X0
del_y(n,i) = YPvec(n,i) - Y(J1(n,i),I1(n,i)); % Y - Y0
delta_y(n,i) = Y(J4(n,i),I1(n,i)) - Y(J1(n,i),I1(n,i)); % Y1 - Y0
ddx(n,i) = del_x(n,i)/delta_x(n,i);
ddy(n,i) = del_y(n,i)/delta_y(n,i);
del_H = 0;

% Usando equacaoo para interpolacao em 2-D
Uint2d(n,i) = (ddx(n,i)*ddy(n,i)*U(J3(n,i),I3(n,i)))+(ddy(n,i)*(1-ddx(n,i))*U(J4(n,i),I4(n,i)))+(ddx(n,i)*(1-ddy(n,i))*U(J2(n,i),I2(n,i)))+((1-ddx(n,i)-ddy(n,i)+ddx(n,i)*ddy(n,i))*U(J1(n,i),I1(n,i)));
Vint2d(n,i) = (ddx(n,i)*ddy(n,i)*V(J3(n,i),I3(n,i)))+(ddy(n,i)*(1-ddx(n,i))*V(J4(n,i),I4(n,i)))+(ddx(n,i)*(1-ddy(n,i))*V(J2(n,i),I2(n,i)))+((1-ddx(n,i)-ddy(n,i)+ddx(n,i)*ddy(n,i))*V(J1(n,i),I1(n,i)));
Dxxint2d(n,i) = (ddx(n,i)*ddy(n,i)*Dxx1(J3(n,i),I3(n,i)))+(ddy(n,i)*(1-ddx(n,i))*Dxx1(J4(n,i),I4(n,i)))+(ddx(n,i)*(1-ddy(n,i))*Dxx1(J2(n,i),I2(n,i)))+((1-ddx(n,i)-ddy(n,i)+ddx(n,i)*ddy(n,i))*Dxx1(J1(n,i),I1(n,i)));
Dyyint2d(n,i) = (ddx(n,i)*ddy(n,i)*Dyy1(J3(n,i),I3(n,i)))+(ddy(n,i)*(1-ddx(n,i))*Dyy1(J4(n,i),I4(n,i)))+(ddx(n,i)*(1-ddy(n,i))*Dyy1(J2(n,i),I2(n,i)))+((1-ddx(n,i)-ddy(n,i)+ddx(n,i)*ddy(n,i))*Dyy1(J1(n,i),I1(n,i)));

del_Dxx(n,i) = (Dxx1(J1(n,i),I1(n,i)) - Dxxint2d(n,i));
del_Dyy(n,i) = (Dyy1(J1(n,i),I1(n,i)) - Dyyint2d(n,i));


if abs(del_y(n,i)) > 1*10e-05
   YQ(n,i) = YPvec(n,i) + Vint2d(n,i)*del_t + ((Dyyint2d(n,i)/H)*(del_H/del_y(n,i)) + (del_Dyy(n,i)/del_y(n,i)))*del_t + sqrt(2*Dyyint2d(n,i)*del_t)*psi;
else
   YQ(n,i) = YPvec(n,i) + Vint2d(n,i)*del_t + ((Dyyint2d(n,i)/H)*(del_H/del_y(n,i)) + 0*(del_Dyy(n,i)/del_y(n,i)))*del_t + sqrt(2*Dyyint2d(n,i)*del_t)*psi;
end

if abs(del_x(i)) > 1*10e-05
    XQ(n,i) = XPvec(n,i) + Uint2d(n,i)*del_t + ((Dxxint2d(n,i)/H)*(del_H/del_x(n,i)) + (del_Dxx(n,i)/del_x(n,i)))*del_t + sqrt(2*Dxxint2d(n,i)*del_t)*phi;
else
    XQ(n,i) = XPvec(n,i) + Uint2d(n,i)*del_t + ((Dxxint2d(n,i)/H)*(del_H/del_x(n,i)) + 0*(del_Dxx(n,i)/del_x(n,i)))*del_t + sqrt(2*Dxxint2d(n,i)*del_t)*phi;
end

XPvec1(n,i) = XQ(n,i);
YPvec1(n,i) = YQ(n,i);

XPvec(n+1,i) = XQ(n,i);
YPvec(n+1,i) = YQ(n,i);


end
clf
quiver(X,Y,U,V)
hold on
plot(XPvec1(n,:),YPvec1(n,:),'ok')
xlim([-1 1])
ylim([-1 1])
axis equal
pause(0.15)
end

