clear all
close all
clc
% Equação Número 1
api_agua = 10
api_oleo_leve = 33
api_oleo_medio = 25
api_oleo_pesado = 17
api_oleo_epesado = 10

pwq = 1030 % kg/m^3 [aqui deve ser a 15°C]

g_e = 141.5 / (api_oleo_leve + 131.5) % gravidade especifica leve
g_e_m = 141.5 / (api_oleo_medio + 131.5) % gravidade especifica medio
g_e_p = 141.5 / (api_oleo_pesado + 131.5) % gravidade especifica pesado


del_p =  (1 - g_e)*pwq % diferença de densidade entre a água do mar e o óleo 
del_pm =  (1 - g_e_m)*pwq % dif oleo medio
del_pp =  (1 - g_e_p)*pwq % dif oleo pesado
g = 9.8 % aceleração da gravidade (m/s^2)
V = 0.15 % Volume do derrame (m^3)
pw =  1030 % densidade da água do mar 
vw = 1.86e-06 % viscosidade cinemática da água do mar (m^2/s)


 % area da mancha de oleo (m^2)
 num = del_p*g*V^2;
 den = pw*(vw^1/2);
 for i=1:3600;
     t(i) = i - 1; % tempo (s)
    
A2l(i) = pi * 0.98^2 * (((del_p*g*V^2)/(pw*(vw^(1/2))))^(1/3)) * (t(i)^(1/2));
A2m(i) = pi * 0.98^2 * (((del_pm*g*V^2)/(pw*(vw^(1/2))))^(1/3)) * (t(i)^(1/2));
A2p(i) = pi * 0.98^2 * (((del_pp*g*V^2)/(pw*(vw^(1/2))))^(1/3)) * (t(i)^(1/2));

 end 

figure(1)
plot(t,A2l,'b','LineWidth',4)
hold on
plot(t,A2m,'g','LineWidth',4)
hold on
plot(t,A2p,'r','LineWidth',4)


title('Tempo x Metro quadrado espalhado de óleo (Wang 1975)')
xlabel('Tempo(s)','Fontsize',12,'fontweight','bold')
ylabel('Área da mancha de óleo (m^2)','Fontsize',12,'fontweight','bold')
annotation('textbox',...
    [0.593857142857143 0.195238095238095 0.270428571428571 0.140476190476191],...
    'String',{'Volume = 0.15m^3','= 1 barril de petróleo'},...
    'FitBoxToText','off');
legend1 = legend('show');
set(legend1,...
    'Position',[0.173809525725387 0.75079365419963 0.164285712103759 0.126190472784496]);
hold off


% Equação número 2
% Formula de Lehr et al. (1984) %


V = 1 % Volume do derrame Barril
pw =  1030 % densidade da água do mar 
vw = 1.86e-06 % viscosidade cinemática da água do mar (m^2/s)
W = 0 % vento em nós
pol = pw - del_p;  % densidade do óleo leve
pom = pw - del_pm; % densidade do óleo medio
pop = pw - del_pp; % densidade do óleo pesado

for i = 1:3600;
    t(i) = (i - 1)/60;
Al(i) = 2270*((del_p/pol)^(2/3)) * (V^(2/3)) * ((t(i))^(1/2))  + 40 * ((del_p/pol)^(1/3)) * (V^(1/3)) * (W^(4/3)) * t(i);
Am(i) = 2270*((del_pm/pom)^(2/3)) * (V^(2/3)) * ((t(i))^(1/2))  + 40 * ((del_p/pom)^(1/3)) * (V^(1/3)) * (W^(4/3)) * t(i);
Ap(i) = 2270*((del_pp/pop)^(2/3)) * (V^(2/3)) * ((t(i))^(1/2))  + 40 * ((del_p/pop)^(1/3)) * (V^(1/3)) * (W^(4/3)) * t(i);
% Usando 2270, como sugerido na equação de Lehr, o resultado é de uma ordem
% de grandeza a mais que o proposto por Wang (1975)
end



figure(2)
plot(t,Al,'b','linewidth', 3)
hold on 
plot(t,Am,'g','linewidth', 3)
hold on 
plot(t,Ap,'r','linewidth', 3)
title('Tempo x Metro quadrado espalhado de óleo (Lehr 1984)')
xlabel('Tempo(min)','Fontsize',12,'fontweight','bold')
ylabel('Área da mancha de óleo (m^2)','Fontsize',12,'fontweight','bold')
annotation('textbox',...
    [0.593857142857143 0.195238095238095 0.270428571428571 0.140476190476191],...
    'String',{'Volume = 0.15m^3','= 1 barril de petróleo'},...
    'FitBoxToText','off');
legend1 = legend('show');
set(legend1,...
    'Position',[0.173809525725387 0.75079365419963 0.164285712103759 0.126190472784496]);
hold off

% tempo em segundos 



K1 = 200 % s^-1
V = 0.15 % m^3
% Analítica
for i=1:3600;
t(i) = i - 1;
A(i) = ((2*K1*(V^(4/3)))^(1/2))*(t(i)^(1/2));
end



nl=length(t);
% Numérica
a=zeros(1,nl);
a(1)=A(1); % em t(1)=0;
a(2)=A(2);
dt = t(2) - t(1); %dif de tempo entre t2 e t1 => dt=1
% Metodo Runge-Kutta 4ª Ordem
for n=2:nl-1;
k1=kay4(t(n),V,a(n));
k2=kay4(t(n)+dt/2,V,a(n)+dt*k1/2);
k3=kay4(t(n)+dt/2,V,a(n)+dt*k2/2);
k4=kay4(t(n)+dt,V,a(n)+dt*k3);
a(n+1)=a(n)+dt*(k1+2*k2+2*k3+k4)/6;
end

figure(3)
plot(t,A,'b','linewidth',2)
hold on 
plot(t,a,'r','linewidth',2)
annotation('textbox',...
    [0.593857142857143 0.195238095238095 0.270428571428571 0.140476190476191],...
    'String',{'Volume = 0.15m^3','= 1 barril de petróleo'},...
    'FitBoxToText','off');
title('Tempo x Metro quadrado espalhado de óleo (Makay 1980)')
xlabel('Tempo(s)','Fontsize',12,'fontweight','bold')
ylabel('Área da mancha de óleo (m^2)','Fontsize',12,'fontweight','bold')

figure(4) %erro
plot(t,A-a,"b")
legend("erro=analitico-RK4")
