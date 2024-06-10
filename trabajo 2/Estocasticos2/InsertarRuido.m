function [BitsRuido, sigma] = InsertarRuido(SNR, SeqBits)

% Cálculo de la potencia de la señal
P = sum(abs(SeqBits).^(2)) * (1/(length(SeqBits)));

% Calcular la varianza (sigma)
var = ( P )/( 10^(SNR/10) );

% Generar N variables aleatorias Gaussianas y provocar una realizacion
N = length(SeqBits);
RuidoG = [];

for i = 1:N
    RuidoG(i) = normrnd(0,var);
end

BitsRuido = SeqBits + RuidoG';
sigma = var;
end