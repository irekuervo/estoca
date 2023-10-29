function [audio] = Resegmentacion(matriz_ventanas)

[muestras_ventana,cantidad_ventanas] = size(matriz_ventanas);

tamanio_union = muestras_ventana / 2; %por 50% de solapamiento
audio = matriz_ventanas(:,1)'; % Ponemos la primer ventana
indice = tamanio_union;
for i = 2:cantidad_ventanas
    
     ventana = matriz_ventanas(:,i)';
     
    % vamos construyendo el audio rellenando con ceros donde intersecta con la ventana
    audio = [audio zeros(1, tamanio_union)];
   
    % recorremos la ventana y solapamos con el audio
    for j = 1:muestras_ventana
       audio(indice+j) = audio(indice+j) + ventana(j);
       
    end
    indice = indice + tamanio_union;
end

end

