%==================================================
%==================================================
%Generador de secuencias pseudo aletorias mediante
%LFSR de longitud 7 con retroalimentación en 3 y 7.

%Realizado por:

%Tyrone Novillo
%Dayana Jara
%Jonnatan Robles
%Sebastián Guazhima
%Pablo Bermeo

%==================================================
%==================================================

clc; clear all; close all;
%% Definición de valores iniciales 

s0 = [1 0 0 0 0 0 0]; %Secuencia inicial
r = [7 3];            %Posiciones de retroalimentación
RanSeqs = [];         %Matriz de secuencias aleatorias
n = 20;             %Cantidad de bits a obtener

%% Registro de desplazamientos

%Bucle para almacenar n secuencias
for j = 1:1:n
    
    RanSeqs(j, :) = s0; %Almacenar la secuencia
    retro = xor( s0(r(1)) , s0(r(2) ) ); %Calcular la retroalimentación para S_0
    
    %Desplazar los bits desde el segundo flip-flop hasta el séptimo
    for i = length(s0):-1:2
        s0(i) = s0(i-1);
    end

    %Remplazar S_0 con la retroalimentacion
    s0(1) = retro;

end

%% Obtención de la seuencia aleatoria en la salida del último Flip-Flop
BitSeq = RanSeqs(:,7)
stem(BitSeq)
ylim([-0.1 1.2])
xlim([0 100]) %Se visualiza hasta n = 100
title("Secuencia aleatoria en la salida del séptimo Flip-Flop (Representación Discreta)")
