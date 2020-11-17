function my = yay4(t,Y);
C3 = 0.7; %
W = 4.17; % Velocidade do vento (m/s)

my = (2*1e-6)*((W+1)^2)*(1-(Y/C3));

end