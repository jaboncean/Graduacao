% solução numérica dif-finitas
clc
clear all
close all
load ("soluanalitica.mat") 

tic
nx = 5;
ny = nx;
comprimento_x = 1;
comprimento_y = 1;
delta_x = comprimento_x / (nx - 1);
delta_y = comprimento_y / (ny - 1);
To = 100;

%++++++++++++++
vx=linspace(0,1,nx);
vy=linspace(0,1,ny);

n_coefs = (nx - 2) * (ny - 2);
A = zeros(n_coefs);
b = zeros(n_coefs, 1);


%Prencher diagonal principal
for i = 1:n_coefs;
  A(i, i) = -4;;
end

for i = 2:n_coefs;
  if (mod((i - 1), (nx - 2)) == 0);
    A(i, (i - 1)) = 0;
  else
    A(i, (i - 1)) = 1;
  end
  end

for i = 1:(n_coefs - 1);
  if (mod((i + 1), (nx - 2)) == 1);
    A(i, (i + 1)) = 0;
  else
    A(i, (i + 1)) = 1;
  end
  end

for i = 1:(n_coefs - (ny - 2));
  A(i, (i + ny - 2)) = 1;
  A((i + ny - 2), i) = 1;
end 

for i = 1:(ny - 2);
  b(i) = -To;
end

X = (A^-1)*b;
matX100 = zeros(ny,nx);

for j = 2:ny-1;
  for i = 2:nx-1;
    ij = (i-1) + (ny-2)*(j-2);
    matX100(j,i) = X(ij);
  end
end

toc 
t= toc
% +++++++++++++
Ni=2:1:nx-1;
Nj=2:1:ny-1;

for j=Nj;
    matX100(1,j) = To;
end

contourf(vx,vy,matX100)
colorbar
 





