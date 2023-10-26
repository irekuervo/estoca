function [audio] = Resegmentacion(matriz_ventanas)



[muestras_ventana,cantidad_ventanas] = size(matriz_ventanas);

tamanio_union = muestras_ventana / 2; %por 50% de solapamiento
audio = zeros(1 ,tamanio_union);
indice_solapamiento = 0;
for i = 1:cantidad_ventanas
    
    % vamos construyendo el audio rellenando con ceros donde intersecta con la ventana
    audio = [audio zeros(1, tamanio_union)];
    ventana = matriz_ventanas(:,i);
    
    % solapamos
    for j = i:muestras_ventana
       indice_audio = indice_solapamiento + j;
       audio(indice_audio) = audio(indice_audio) + ventana(j);
    end
    
    indice_solapamiento = indice_solapamiento + tamanio_union;
end
audio = flip(audio);
audio = audio/(30*rms(audio));
end

