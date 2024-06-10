function ModRS = Modular(BitSeq, A)
%Mapear valores 0 y 1 hacia -A y A, resp.

%Recorrer la secuencia de bits
for i = 1:length(BitSeq)

    %Si el bit es 1, se mapea a A
    ModBit = A;

    if BitSeq(i) == 0
        ModBit = -A; %-A de lo contrario
    end

    BitSeq(i) = ModBit; %Reemplazar el mapeo

end

ModRS = BitSeq;

end


