function[mse,mse_ml,varz] = MSE(I,SNRdB,modo)

I = double(I)/256;%Normalización de valores

%==================================================================
%                       APLICACION DE BLUR
%==================================================================

%Aplicarle el blur a la imagen con ruido
l = 10; %Longitud del blur
theta = 45;%Angulo del blur
H = fspecial('motion',l,theta);
ImagenBlur = imfilter(I, H,'conv','circular');


%==================================================================
%                       APLICACION DE RUIDO
%==================================================================
[I_Ruido, Blurr_Ruido, Ruido, varz] = RuidoGauss(I, ImagenBlur, SNRdB);

% Obtención de SNN(f)
TF_Ruido = fft2(Ruido);
PSD_WW = abs(TF_Ruido).^2/(2*size(Ruido,1)*size(Ruido,2));

%==================================================================
%                            WIENER Y MSE
%==================================================================
if (modo == 1)
    y = Wiener(I,I_Ruido,PSD_WW);
    k = wiener2(I_Ruido,[5 5]);
    mse = mean((I(:) - y(:)).^2);
    mse_ml = mean((I(:) - k(:)).^2);
    
elseif (modo == 2)
    NSRl = 1/( 10^(SNRdB/10) );
    y = Wiener(ImagenBlur,Blurr_Ruido,PSD_WW);
    k = deconvwnr(Blurr_Ruido,H,NSRl);
    mse = mean((I(:) - y(:)).^2);
    mse_ml = mean((I(:) - k(:)).^2);
		
elseif (modo == 3)
	y = Wiener(I,ImagenBlur,PSD_WW);
	k = deconvwnr(ImagenBlur,H);
  mse = mean((I(:) - y(:)).^2);
  mse_ml = mean((I(:) - k(:)).^2);
end

end


