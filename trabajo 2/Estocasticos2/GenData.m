function RanBits = GenData(s0, r, n)

RanSeqs = [];
% Registro de desplazamientos

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

% Obtención de la seuencia aleatoria en la salida del último Flip-Flop
RanBits = RanSeqs(:,7);

end 