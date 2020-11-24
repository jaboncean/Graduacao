% Metodo implicito 
% 18/10/2019 
% Difusão transiente 

clc
clear all
close all

nx=5;   %numero de pontos da malha       
ny=nx;
comprimento_x = 1; 
comprimento_y = 1; 
delta_x = comprimento_x / (nx - 1);
delta_y = comprimento_y / (ny - 1);
To = 100; %temperatura inicial
T = zeros(nx,ny);
Tn = zeros(nx,ny);
k=1;
erro = 1000;
to=0


% 
 delta_t=0.5*(1/(k/delta_x^2 + k/delta_y^2));

 A=delta_t*k/delta_x^2;
 B=delta_t*k/delta_y^2;
 
 
 
% para nx=5 DELTA T abaixo de 1/54.64 
%  delta_t=1/55;
% t=to+(n-1)*delta_t

% para nx=10 DELTA T abaixo de 1/307.3798
% para nx=15 DELTA T avaixo de 1/775


    
%Condições de contorno de entrada
for j=2:ny-1;
  Tn(nx,j)= To;
  T(nx,j) = To;
end

n=1
while erro >= 10^-8;
% for n=1:100
    
for i=ny-1:-1:2;
  for j=2:1:nx-1;
    
%   Tn(j,i)=T(j,i)+(delta_t*k/delta_x^2)*(T(j,i-1)-2*T(j,i)+T(j,i+1))+(delta_t*k/delta_y^2)*(T(j-1,i)-2*T(j,i)+T(j+1,i));
% Tn(i,j)=T(i,j)+(delta_t*k/delta_x^2)*(T(i-1,j)-2*T(i,j)+T(i+1,j))+(delta_t*k/delta_y^2)*(T(i,j-1)-2*T(i,j)+T(i,j+1));  
  




Tn(i,j) = -A*T(i-1,j)-A*T(i+1,j)+(2*A+2*B-1)*T(i,j)-B*T(i,j+1)-B*T(i,j-1);
  
  end
end

erro = max(max(abs(-Tn - T)));

T = -Tn;

 t=to+(n-1)*delta_t

% %invertendo a matriz



Timplicit=zeros(nx,ny);
for j=2:nx-1;
    Timplicit(1,j) = -T(nx,j);
end

for j=2:nx-1;
   for i=2:nx-1; 
    
    Timplicit(i,j) = -T(nx+1-i,j);
   end
end



end
% end
toc

vx=linspace(0,1,nx);
vy=linspace(0,1,ny);

figure(nx)
contourf(vx,vy,Timplicit);
colorbar
