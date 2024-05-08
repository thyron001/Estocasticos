clc; clear all; close all;
%% Definicion de parametros iniciales
lambda = 5;
RVs = 1000;
nr_values = 10e3;
ValsMatrix = zeros(nr_values, RVs);

%% Generacion de la matriz de valores aleatorios

for i = 1:1:RVs
    r_arrayP = poissrnd(lambda, nr_values, 1);
    ValsMatrix(:, i) = r_arrayP;
end 

%% Histograma de la variable X1

X1 = ValsMatrix(:, 3);

figure()
h = histogram(X1,15); hold on; %Histograma de ocurrencias

%Obtencion de la envolvente al histograma

h_amps = h.Values; %Valores de cada barra

%Plotting a manera de puntos separados
plot(0:1:max(size(h_amps))-1, h_amps, 'LineWidth',2); 

%====================================
%            Formato
%====================================
title('Niveles de ocurrencia de X_1')
ylabel('Conteo')
xlabel('a < X_1 < b')
hold off;

%% Sumas de las realizaciones por cada VA

%Generacion de las sumas de cada columna
SumCol = zeros(1,RVs);

for i = 1:1:RVs
    Si = sum( ValsMatrix(:, i) );
    SumCol(1,i) = Si;
end

%Generacion del histograma
figure()
histogram(SumCol);

%====================================
%            Formato
%====================================
title('Suma \Sigma de todas las realizaciones de cada variable aleatoria por separado')
ylabel('Conteo')
xlabel('a < \Sigma < b')
hold off;

%% Sumas de las realizaciones n-esimas de cada VA

%Generación de las sumas de cada fila
SumFil = zeros(1, nr_values);

for i = 1:1:nr_values
    Si = sum(ValsMatrix(i,:));
    SumFil(1,i) = Si;
end

figure()
histogram(SumFil)
%====================================
%            Formato
%====================================
title('Suma \Sigma de todas las variables aletorias en cada realizacion')
ylabel('Conteo')
xlabel('a < \Sigma < b')
hold off;
