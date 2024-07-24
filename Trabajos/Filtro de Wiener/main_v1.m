% Leer la imagen original
imagen_original = imread('cameraman.tif');
imagen_original = im2double(imagen_original); % Convertir a double

% Aplicar el blurring (desenfoque)
PSF = fspecial('motion', 21, 11); % Crear el filtro de movimiento
imagen_blur = imfilter(imagen_original, PSF, 'conv', 'circular'); % Aplicar el filtro de movimiento

% Añadir ruido Gaussiano
variancion_ruido = 0.01;
imagen_ruido = imnoise(imagen_original, 'gaussian', 0, variancion_ruido);

% Imagen con blurring y ruido
imagen_blur_ruido = imnoise(imagen_blur, 'gaussian', 0, variancion_ruido);

% Transformada de Fourier de la imagen desenfocada y ruidosa
G = fft2(imagen_blur_ruido);
H = fft2(PSF, size(G, 1), size(G, 2));

% Espectro de potencia del ruido
S_n = variancion_ruido * abs(fft2(randn(size(imagen_original)))).^2;

% Espectro de potencia de la señal original (estimado)
S_f = abs(fft2(imagen_original)).^2;

% Filtro de Wiener en el dominio de la frecuencia
H_conj = conj(H);
H_abs2 = abs(H).^2;
filtro_wiener = H_conj ./ (H_abs2 + S_n ./ S_f);

% Aplicar el filtro de Wiener
F_hat = G .* filtro_wiener;
imagen_wiener = real(ifft2(F_hat));

figure;
subplot(2,3,1), imshow(imagen_original), title('Original');
subplot(2,3,2), imshow(imagen_blur), title('Blur');
subplot(2,3,3), imshow(imagen_ruido), title('Ruido');
subplot(2,3,4), imshow(imagen_blur_ruido), title('Blur y Ruido');
subplot(2,3,5), imshow(imagen_wiener), title('Filtro de wiener');

% Calcular el MSE
mse_blur = immse(imagen_original, imagen_blur);
mse_ruido = immse(imagen_original, imagen_ruido);
mse_blur_ruido = immse(imagen_original, imagen_blur_ruido);
mse_wiener = immse(imagen_original, imagen_wiener);


% Mostrar los resultados con printf
printf('MSE (Blur): %.4f\n', mse_blur);
printf('MSE (Ruido): %.4f\n', mse_ruido);
printf('MSE (Blur + Ruido): %.4f\n', mse_blur_ruido);
printf('MSE (Wiener): %.4f\n', mse_wiener);

