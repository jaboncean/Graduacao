
% >>>Comandos para limpar e fechar tudo que foi feito anteriormente:
clear all
close all
clc

% Valores conhecidos [recomendado não mexer]
T=2*pi; % pi é conhecido no matlab e pode ser usado dessa forma. 
k=1; 
g=1;
A=1;
w=1;

% Aqui vocês escolhem o t e h de vocês[mudar valor de t e h]:
% podem ser: t=T/2 | t=T 
t=T/2;

% podem ser: h=pi/2 | h=pi/4
h=pi/4;

% ===criando vetor de 0 a 2pi com 21 ponto===
x = linspace(0,2*pi,41);

% ===criando vetor de 0 a -h com 21 pontos===
y = linspace(0,-h,41); 

%  Criando matriz com os velores (repetindo linhas e colunas)
[X,Y]= meshgrid(x,y);

% =|Funcao corrente|=
Q = g*A/w*sinh(k*Y+k*h)/cosh(k*h)*cos(k*X-w*t);

% -=LINHAS DE CORRENTE=-
surf(X,Y,Q)  %cria um gráfico preenchido pelas matrizes e pela função Q
colorbar       %insere uma barra em escala de cores para as magnitudes

% -->CAMPO DE VELOCIDADE<--

% Velocidade em U (derivada da funcao corrente em y)
U=g*k*A/w*cosh(k*Y+k*h)/cosh(k*h)*cos(k*X-w*t);
% Velocidade em V (derivada da funcao corrente em x)
V=g*k*A/w*sinh(k*Y+k*h)/cosh(k*h)*sin(k*X-w*t);

% Plot do campo de velocidade U,V em X,Y na cor verde (g) com linhas de 1.5 de
% largura
hold on
quiver(X,Y,U,V,'g','linewidth',1.5)
