clc; close all; clear all;

I = imread("cameraman.tif"); %Cameraman
I = double(I)/256;%Normalización de valores
SNRdB = 5;%SNR para el ruido Gaussiano

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
[I_Ruido, Blurr_Ruido, Ruido] = RuidoGauss(I, ImagenBlur, SNRdB);

% Obtención de SNN(f)
TF_Ruido = fft2(Ruido);
PSD_WW = abs(TF_Ruido).^2/(2*size(Ruido,1)*size(Ruido,2));

%==================================================================
%                            WIENER
%==================================================================
%1.
y = Wiener(I,I_Ruido,PSD_WW);
%2.
y2 = Wiener(ImagenBlur,Blurr_Ruido,PSD_WW);
%3.
y3 = Wiener(I,ImagenBlur,PSD_WW);

%=================================================================
%                       APLICACION DIRECTA
%=================================================================
NSRl = 1/( 10^(SNRdB/10) );

%1.
k = wiener2(I_Ruido,[5 5]);
%2.
k1 = deconvwnr(Blurr_Ruido,H,NSRl);
%3.
k2 = deconvwnr(ImagenBlur,H);

%=================================================================
%                       GRAFICAS
%=================================================================

%Figura 1: Todas las modidicaciones
figure('Name','Todas las modificaciones','NumberTitle','off')
subplot(2,2,1)
imshow(I)
title("Imagen original")
subplot(2,2,2)
imshow(ImagenBlur)
title("Imagen con blur")
subplot(2,2,3)
imshow(I_Ruido)
title("Imagen con ruido")
subplot(2,2,4)
imshow(Blurr_Ruido)
title("Imagen con ruido y blur")

%Figura 2: Ruido a implementar
figure('Name','Ruido a implementar','NumberTitle','off')
imshow(Ruido)
title("Ruido")


%Figura 3: Caso 1 Manual y MatLab
figure('Name','Caso 1:Ruido','NumberTitle','off')

subplot(1,3,1)
imshow(I_Ruido)
title("Imagen con ruido")
subplot(1,3,2)
imshow(y)
title("Wiener manual")
subplot(1,3,3)
imshow(k)
title("Wiener MatLab")


%Figura 4: Caso 2 Manual y MatLab
figure('Name','Caso 2:Blur','NumberTitle','off')


subplot(1,3,1)
imshow(ImagenBlur)
title("Imagen con blur")
subplot(1,3,2)
imshow(y3)
title("Wiener manual")
subplot(1,3,3)
imshow(k2)
title("Wiener MatLab")



%Figura 5: Caso 3 Manual y MatLab
figure('Name','Caso 3: Blur + Ruido','NumberTitle','off')

subplot(1,3,1)
imshow(Blurr_Ruido)
title("Imagen con blur y ruido")
subplot(1,3,2)
imshow(y2)
title("Wiener manual")
subplot(1,3,3)
imshow(k1)
title("Wiener MatLab")

%Figura 6: Imagen original
figure('Name','Imagen original','NumberTitle','off')
imshow(I)
title("Imagen original")