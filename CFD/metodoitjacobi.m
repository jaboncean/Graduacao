% Metodo iterativo (indireto) (metodo gauss-jacobi)
% matlab 
% 16/10/2019 


clc
clear all
close all

tic
nx=5;
% nx=5
ny=nx;
comprimento_x = 1;
comprimento_y = 1;
delta_x = comprimento_x / (nx - 1);
delta_y = comprimento_y / (ny - 1);
To = 100;

ap = ((2/delta_x^2)+(2/delta_y^2));
ax = (1/delta_x^2);
ay = (1/delta_y^2);

T = zeros(ny,nx);
Tk = zeros(ny,nx);

k=0;
erro = 1000;

for j=2:ny-1;
  Tk(nx,j)= To;
  T(nx,j) = To;
end

while erro >= 10^-8;
for i=nx-1:-1:2;
  for j=2:ny-1;
  Tk(j,i)= ax/ap*(T(j,i+1)+T(j,i-1))+ ay/ap*(T(j+1,i)+T(j-1,i));
    
  end
end

erro = max(max(abs(Tk - T)));

T = Tk;
k = k+1


end
toc




%invertendo a matriz
Tnova100=zeros(nx,ny);
for j=2:nx-1;
    Tnova100(1,j) = Tk(nx,j);
end

for j=2:nx-1;
   for i=2:nx-1; 
    
    Tnova100(i,j) = Tk(nx+1-i,j);
   end
end


n=(nx-2)*(ny-2);

vx=linspace(0,1,nx);
vy=linspace(0,1,ny);



% figure(1)
% plot(n,k,'o','linewidth',3);
% axis equal
% hold on



figure(nx)
contourf(vx,vy,Tnova100);
colorbar
title('dt*1/10');
%  end






