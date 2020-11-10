function mmi = miay4(t,Fe,A,Vl,Y,dmi);

W = 4.17;
C3 = 0.7;
C4 = 10;
mi0 = 3.64 * 0.832; % Viscosidade inicial convertidade de cSt para cP
T = 288.15; % temperatura em kelvin
K = (2.5*1e-3)*(W^0.78); % coeficiente de transferência de masssa para evaporação (m/s)
 
% % Constantes derivadas dos dados de destilação
 T0 = 301; % (K) óleo Statfjord
 Tg = 500; %
 Acte = 6.3; % Cte empírica
 B = 10.3; % Cte empírica

dy = (2*1e-6)*((W+1)^2)*(1-(Y/C3));

dFe2 = (K*A/Vl)*exp(Acte - ((B/T)*(T0 + Tg*Fe)));

mmi = (C4*dmi*dFe2)+((2.5*dmi/((1-C3*Y)^2))*dy);