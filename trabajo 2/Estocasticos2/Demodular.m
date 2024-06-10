function BitsReconocidos = Demodular(SeqBits)

%Insertar un uno si el valor es positivo
for i = 1:length(SeqBits)
    
    BitReconocido = 1; %Insertar un uno si el valor es positivo
    
    if ( SeqBits(i) < 0 ) %0 de lo contrario
        BitReconocido = 0;
    end

    SeqBits(i) = BitReconocido;

end

BitsReconocidos = SeqBits; %Retornar la demodulación.

end
