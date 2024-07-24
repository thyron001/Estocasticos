clc; clear all; close all;
I = imread("cameraman.tif"); %Cameraman

SNRs = 0:10;
varzs = [];
msesMA = zeros(3,length(SNRs));
msesML = zeros(3,length(SNRs));

for i = 1:3
	
    modo = i;

	for j = 1:length(SNRs)
	SNRdB = SNRs(j);
	[mse,mse_ml,varz] = MSE(I,SNRdB,modo);  
	msesMA(modo,j) = mse;
    msesML(modo,j) = mse_ml;
    varzs(j) = varz;
  
  	end
end
figure()
scatter(varzs, msesMA(1,:))
hold on;
scatter(varzs, msesMA(2,:))
scatter(varzs, msesMA(3,:))
scatter(varzs, msesML(1,:))
scatter(varzs, msesML(2,:))
scatter(varzs, msesML(3,:))

legend('Ruido Manual','Blur+Ruido Manual','Blur Manual', 'Ruido MatLab','Blur+Ruido MatLab','Blur MatLab')
title('MSE vs potencia de ruido')
xlabel('Potencia del Ruido')
ylabel('MSE')
grid on;


figure()
scatter(SNRs, msesMA(1,:))
hold on;
scatter(SNRs, msesMA(2,:))
scatter(SNRs, msesMA(3,:))
scatter(SNRs, msesML(1,:))
scatter(SNRs, msesML(2,:))
scatter(SNRs, msesML(3,:))

legend('Ruido Manual','Blur+Ruido Manual','Blur Manual', 'Ruido MatLab','Blur+Ruido Matlab','Blur Matlab')
title('MSE vs SNR')
xlabel('SNR(dB)')
ylabel('MSE')
grid on;


