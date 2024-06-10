clc; clear all; close all;

s0 = [1 0 0 0 0 0 0]; %Secuencia inicial
r = [7 3];            %Posiciones de retroalimentación
n = 100;              %Cantidad de bits a obtener
A = 2;                %Amplitud para modulación
SNR = 7;              %Relación señal a ruido en dB


%Generación de bits aleatorios
RanSeq = GenData(s0, r, n);

%Modulación de los bits
ModRS = Modular(RanSeq, A);

%Inclusión del ruido blanco en el canal
[SenalRuidosa, sigma] = InsertarRuido(SNR,ModRS);

%Demodulación en el receptor
BitsRecibidos = Demodular(SenalRuidosa);

%Cuantificar errores
diffs = RanSeq == BitsRecibidos;
z = 0;
for i = 1:length(diffs)
    if diffs(i) == 0
        z = z + 1;
    end
end

%Grafica general de lo enviado, modulado, insercion de ruido y demodulado
figure()
subplot(2,2,1)
stem(RanSeq)
ylim([-A-0.2 A+0.2])
title("Bits a enviar")
subplot(2,2,2)
stem(ModRS)
ylim([-A-0.2 A+0.2])
title("Enviado por el transmisor")
subplot(2,2,3)
stem(SenalRuidosa)
title("Informacion con ruido en el canal")
subplot(2,2,4)
stem(BitsRecibidos)
ylim([-A-0.2 A+0.2])
title("Recibido")


% Grafica solo de lo enviado por el transmisor, insercion de ruido y
% recibido
figure()
subplot(3,1,1)
stem(ModRS)
ylim([-A-0.2 A+0.2])
title("Enviado por el transmisor")
subplot(3,1,2)
stem(SenalRuidosa)
title("Informacion con ruido en el canal")
subplot(3,1,3)
stem(BitsRecibidos)
ylim([-A-0.2 A+0.2])
title("Recibido")


%Grafica de lo que se envio y se recibio
figure()
subplot(2,1,1)
stem(RanSeq)
ylim([-A-0.2 A+0.2])
title("Bits a enviar")
subplot(2,1,2)
stem(BitsRecibidos)
ylim([-A-0.2 A+0.2])
title("Recibido")

%Mostrar errores en consola
errores = z

%Calculo de la probabilidad de error
Perror = 2 * ( 1 - normcdf((A - 0)/(sqrt(sigma))) )


