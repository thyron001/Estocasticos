function [I_Ruido, I_comb, Ruido, varz] = RuidoGauss(I,I_blur,SNRdB)
%==============================================
%Calcular la varianza del ruido a partir de SNR
%==============================================
[n,m] = size(I);
els = m*n;
pot = 0;

%Potencia de la imagen
for i = 1:n
    for j = 1:m
        pot = pot + I(i,j).^2;
    end
end

Ps = (1/els)*pot;

%Varianza del ruido
varz = Ps/(10^(SNRdB/10));

%===============================================
%Generar la imagen ruidosa
%===============================================
Ruido = varz*randn(size(I));
%Ruido = normrnd(0,varz,n,m);
I_Ruido = I + Ruido;
I_comb = Ruido + I_blur;

end