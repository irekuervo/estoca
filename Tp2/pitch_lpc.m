function [pitch, reCorr] = pitch_lpc(ventana, LPC, alfa, samplerate)
    
    % Obtenemos la autocorrelacion del residuo
    filter_coefs = [1 -1*LPC'];
    e = filter(filter_coefs,1, ventana);
    
    % Normalizamos
    reCorr = Correlacion(e);
    reCorr = reCorr./max(reCorr);
    
    [pks,locs] = findpeaks(reCorr,'MinPeakDistance', 100);
    
     pitch = 0;
    peaksSobreUmbral = locs(pks > alfa);
    % Si encuentra algo por encima del umbral, lo seteamos, sino asumimos
    % ruido blanco
    if ~isempty(peaksSobreUmbral)
        pitchIndex = peaksSobreUmbral(1);
        pitch = samplerate/pitchIndex; 
    end

end

