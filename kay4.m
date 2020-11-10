% Função para espalhamento de Mackay et al. (1980)
%   
% Retorna a taxa de espalhamento a partir de uma área dada
% 
% Exemplo   
%   
% mk = kay4(A)  
% 
% kay4(4000) 4000m^2 
%

function mk = kay4(t,V,A);
K1 = 150; %s^-1

%At = 372

 mk = K1 * (1/A) * (V^(4/3));
% mk = K1 * ((V^(4/3))/A)
%mk = 1/A;
end