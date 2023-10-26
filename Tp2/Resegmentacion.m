function [audio] = Resegmentacion(matriz_ventanas)



[muestras_ventana,cantidad_ventanas] = size(matriz_ventanas);

tamanio_union = muestras_ventana / 2; %por 50% de solapamiento
audio = zeros(1 ,muestras_ventana);
indice = tamanio_union;
for i = 1:cantidad_ventanas
    
    % vamos construyendo el audio rellenando con ceros donde intersecta con la ventana
    audio = [audio zeros(1, tamanio_union)];
    ventana = matriz_ventanas(:,i)';
    
    % recorremos la ventana y solapamos con el audio
    for j = 1:muestras_ventana
       audio(indice+j) = audio(indice+j) + ventana(j);
       
    end
    indice = indice + tamanio_union;
end
%audio = flip(audio);
audio = audio/(30*rms(audio));
end

