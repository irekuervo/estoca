function trenImpulsos = trenImpulsos(samplerate, frecuencia, tamanio)
     % Calcula el periodo de la señal en muestras
    periodo = samplerate / frecuencia;
    
    % Genera el tren de impulsos
    trenImpulsos = zeros(1, tamanio);
    trenImpulsos(mod(1:tamanio, periodo) == 0) = 1;
end