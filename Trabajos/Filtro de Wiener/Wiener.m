function[y] = Wiener(Z,X,SNN)

%Obtencion de Szz(f)
TF_imag = fft2(Z);
PSD_I = abs(TF_imag).^2/(size(Z,1)*size(Z,2));

%Obtencion de X(f)
TF_I_Ruido = fft2(X);
H_wiener = PSD_I ./ (PSD_I + SNN);

%Para la imagen con Ruido
Yf_ruido = TF_I_Ruido.*H_wiener;
y = real(ifft2(Yf_ruido));

end
