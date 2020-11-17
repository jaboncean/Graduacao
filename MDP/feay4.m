function mfe = feay4(t,A,V,Fe);
W = 4.17; % velocidade do vento (m/s)

K = (2.5*1e-3)*(W^0.78); % coeficiente de transferencia de massa

T = 288.15; % temperatura em kelvin

% espessura da mancha

% Constantes derivadas dos dados de destilação
T0 = 301; % (K) óleo Statfjord
Tg = 500; %
Acte = 6.3;
B = 10.3;

mfe = (K*A/V)*exp(Acte - ((B/T)*(T0 + Tg*Fe)));


end