clear all
close all
clc

% Tempo
 for i = 1:86400;
    t(i) = i - 1;
 end
 dt = t(2) - t(1); % Espaço de tempo

% Equação para área inicial (A) 
V0 = 100000/832; % 100 toneladas / 832 kg/m^3 [Volume inicial]
K1 = 150; % s^-1

nl=length(t);
At = zeros(1,nl);
for i = 1:2;
At(i) = ((2*K1*(V0^(4/3)))^(1/2))*(t(i)^(1/2));
end
a=zeros(1,nl);
% sendo a área em t(1)=0;
a(1) = At(2);

% Mudança do volume (Vl)
Vl = zeros(1,nl);   
Vl(1) = V0;
vl = zeros(1,nl);
vl(1) = Vl(1);

% Equação para a fração evaporada (Fe)
W = 4.17; %(m/s)
T = 288.15 ;% temperatura em kelvin
K2 = (2.5*1e-3)*(W^0.78); % coeficiente de transferência de masssa para evaporação (m/s)
H = V0/a(1);  % espessura da mancha
% Constantes derivadas dos dados de destilação
T0 = 301;% (K) óleo Statfjord
Tg = 500; %
A = 6.3 ;% Cte empírica
B = 10.3; % Cte empírica
%
nl=length(t);
Fe = zeros(1,nl);
Fe(1) = (T/B*Tg)*log((B*Tg/T)*(K2*t(1)/H)*exp(A - (B*T0/T))+1); 
fe = zeros(1,nl);
fe(1) = Fe(1);

% Equação para o conteúdo fracional de água (Y)
C3 = 0.7; % Para óleos crus
W = 4.17; % Velocidade do vento (m/s)
%
Y = zeros(1,nl);
Y(1) = C3*[1 - exp((-2*1e-6/C3)*((1+W)^2)*t(1))];
y=zeros(1,nl);
y(1) = Y(1); % em t(1)=0;

% Mudança de Viscosidade (Mi)
 mi0 = 3.64 * 0.832;
 Mi = zeros(1,nl);
 Mi(1) = mi0;
 mizin = zeros(1,nl);
 mizin(1) = Mi(1);

% Mudança da espessura (H)
 htick = zeros(1,nl);
 htick(1) = H;
 
% Mudança da densidade (rho)
 rhow = 1030; % densidade da água do mar
 rhoco = 832; % densidade original do óleo
 rhoem = zeros(1,nl);
 rhoem(1) = Y(1)*rhow + ((1-Y(1))*(rhoco + C3*Fe(1)));
 
% Rugge-Kutta 4ª ordem
  for n = 1:86400-1;
      
% Método Runge-Kutta 4ª ordem (Espalhamento área)
  k1=kay4(t(n),vl(n),a(n));
  k2=kay4(t(n)+dt/2,vl(n),a(n)+dt*k1/2);
  k3=kay4(t(n)+dt/2,vl(n),a(n)+dt*k2/2);
  k4=kay4(t(n)+dt,vl(n),a(n)+dt*k3);
  a(n+1)=a(n)+dt*(k1+2*k2+2*k3+k4)/6;
%  
  At(n+1) = a(n+1);
  
% Método Runge-Kutta 4ª Ordem (Volume) 
  k13=vlay4(t(n),fe(n),mizin(n),a(n),vl(n));
  k23=vlay4(t(n)+dt/2,fe(n),mizin(n),a(n),vl(n)+dt*k13/2);
  k33=vlay4(t(n)+dt/2,fe(n),mizin(n),a(n),vl(n)+dt*k23/2);
  k43=vlay4(t(n)+dt,fe(n),mizin(n),a(n),vl(n)+dt*k33);
  vl(n+1)=vl(n)+dt*(k13+2*k23+2*k33+k43)/6;
%  
  Vl(n+1) = vl(n+1);  
  
% Método Runge-Kutta 4ª Ordem (Evaporação) 
  k12=feay4(t(n),a(n),vl(n),fe(n)); 
  k22=feay4(t(n)+dt/2,a(n),vl(n),fe(n)+dt*k12/2);
  k32=feay4(t(n)+dt/2,a(n),vl(n),fe(n)+dt*k22/2);
  k42=feay4(t(n)+dt,a(n),vl(n),fe(n)+dt*k32);
  fe(n+1)=fe(n)+dt*(k12+2*k22+2*k32+k42)/6;
% 
  Fe(n+1) = fe(n+1);
  
% Método Runge-Kutta 4ª ordem (fração de água)
  k11=yay4(t(n),y(n));
  k21=yay4(t(n)+dt/2,y(n)+dt*k11/2);
  k31=yay4(t(n)+dt/2,y(n)+dt*k21/2);
  k41=yay4(t(n)+dt,y(n)+dt*k31);
  y(n+1)=y(n)+dt*(k11+2*k21+2*k31+k41)/6;
%  
  Y(n+1) = y(n+1);
% Método Runge-Kutta 4ª ordem (Viscosidade)
  k14=miay4(t(n),fe(n),a(n),vl(n),y(n),mizin(n));
  k24=miay4(t(n)+dt/2,fe(n),a(n),vl(n),y(n),mizin(n)+dt*k14/2);
  k34=miay4(t(n)+dt/2,fe(n),a(n),vl(n),y(n),mizin(n)+dt*k24/2);
  k44=miay4(t(n)+dt,fe(n),a(n),vl(n),y(n),mizin(n)+dt*k34);
  mizin(n+1)=mizin(n)+dt*(k14+2*k24+2*k34+k44)/6;
%   
  Mi(n+1) = mizin(n+1);
%  
  htick(n+1) = Vl(n+1)/At(n+1);
%  
  rhoem(n+1) = Y(n+1)*rhow + ((1-Y(n+1))*(rhoco + C3*Fe(n+1)));
  end
  
Y = Y*100;
Fe = Fe*100;
t = t/3600;

 figure(1)
 subplot(4,2,1);
 plot(t,At,'linewidth',2)
 title('Área');
 ylabel('Área (m^2)','fontweight','bold')
 set(gca,'fontweight','bold')
 subplot(4,2,2);
 plot(t,Vl,'linewidth',2)
 title('Volume');
 ylabel('Volume (m^3)','fontweight','bold')
 set(gca,'fontweight','bold')
 subplot(4,2,3);
 plot(t,Fe,'linewidth',2);
 title('Evaporação');
 ylabel(['Fração evaporada   ';'do volume total (%)'],'fontweight','bold')
 set(gca,'fontweight','bold')
 subplot(4,2,4);
 plot(t,Y,'linewidth',2);
 title('Conteúdo Fracional de Água');
 ylabel(['Conteúdo de água   ';'no volume total (%)'],'fontweight','bold')
 set(gca,'fontweight','bold')
 subplot(4,2,5);
 plot(t,Mi,'linewidth',2);
 title('Viscosidade');
 ylabel('Viscosidade (cP)','fontweight','bold')
 set(gca,'fontweight','bold')
 subplot(4,2,6);
 plot(t,htick,'linewidth',2);
 title('Espessura da mancha');
 ylabel('Espessura (cm)','fontweight','bold')
 set(gca,'fontweight','bold')
 subplot(4,2,7);
 plot(t,rhoem,'linewidth',2);
 title('Densidade da Emulsão');
 ylabel('Densidade (kg/m^3)','fontweight','bold')
 set(gca,'fontweight','bold')
 