function mvl = vlay4(t,Fe,mi,A,Vl);
W = 4.17; % Velocidade do vento (m/s)
V0 = 100000/832; % Volume inicial
del = (Vl/A)*100; % espessura da mancha (cm) %
st = 20; % tensão interfacial óleo-água (dyne/cm)

Da = (0.11*((W+1)^2))/3600; %
Db = (1 + (50*(mi^(1/2))*del*st))^-1;
D = Da*Db;

T = 288.15; % temperatura em kelvin
K = (2.5*1e-3)*(W^0.78); % coeficiente de transferência de masssa para evaporação (m/s)

% Constantes derivadas dos dados de destilação
T0 = 301; % (K) óleo Statfjord
Tg = 500; %
Acte = 6.3; % Cte empírica
B = 10.3; % Cte empírica

dFe = (K*A/Vl)*exp(Acte - ((B/T)*(T0 + Tg*Fe)));
mvl = (-V0*dFe)-(D*Vl);

end

