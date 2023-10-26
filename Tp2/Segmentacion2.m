function [matriz_ventanas] = Segmentacion2(audio, muestras_ventana)

[cantidad_muestras,m] = size(audio);

r = mod(cantidad_muestras,muestras_ventana);
N = (cantidad_muestras+(muestras_ventana-r)) / muestras_ventana;

matriz_ventanas = [];
paso = muestras_ventana / 2; % ventaneo al 50%
i = 1;
while i < cantidad_muestras
    i_final = i+muestras_ventana - 1;
    segmento = audio(i:i_final);
    ventana = hamming(muestras_ventana);
    ventaneo = segmento.*ventana;
    matriz_ventanas = [matriz_ventanas ventaneo];
    i = i + paso;
    
    if i+muestras_ventana - 1 > cantidad_muestras
        break;
    end
end

end

