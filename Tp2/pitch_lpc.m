function [pitch, rCorr] = pitch_lpc(ventana, LPC, alfa, samplerate)
    
    % Obtenemos la autocorrelacion del residuo
    filter_coefs = [1 -1*LPC'];
    e = filter(filter_coefs,1, ventana);
    rCorr = Correlacion(e);
    
    % (10:end) porque omitimos el valor maximo en 0
    pitch_indexes = find(rCorr(10:end) > alfa, 1,'last');
    
    pitch = 0;
    % Si encuentra algo por encima del umbral, lo seteamos, sino asumimos
    % ruido blanco
    if ~isempty(pitch_indexes)
        pitchIndex = pitch_indexes(1);
        pitch = samplerate/pitchIndex; 
    end

end

