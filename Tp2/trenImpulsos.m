function trenImpulsos = TrenImpulsos(samplerate, frecuencia, tamanio)
     % Calcula el periodo de la señal en muestras
    muestras_periodo = samplerate / frecuencia;
    
    % Genera el tren de impulsos
    trenImpulsos = zeros(1, tamanio);
    trenImpulsos(mod(1:tamanio, muestras_periodo) == 0) = 1;
end