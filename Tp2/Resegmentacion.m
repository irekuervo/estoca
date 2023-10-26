function [audio] = Resegmentacion(matriz_ventanas)

audio = [];

[muestras_ventana,cantidad_ventanas] = size(matriz_ventanas);

tamanio_union = muestras_ventana/2;
tamanio = tamanio_union * 3; % por 50% de solapamiento

    
for i = 1:2:cantidad_ventanas-1
    ventana_1 = [matriz_ventanas(:,i); zeros(tamanio_union, 1)];
    ventana_2 = [zeros(tamanio_union, 1); matriz_ventanas(:,i+1)];
    
    union_ventanas  = zeros(tamanio, 1);
    
    % solapamos
    for j = i:tamanio
        union_ventanas(j) = ventana_1(j) + ventana_2(j);
    end
    
    audio = [audio union_ventanas'];
end

end

