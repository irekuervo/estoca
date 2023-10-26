% Ejercicio 2
close all;
clear all;

audios = ["audio_a.wav" "audio_e.wav" "audio_s.wav"];
P_vect = [5 10 30];
tiempo_ventana = 30e-3;

% Recorremos todos los audios
for audio_i = 1:3
    
    % Abrimos el audio
    filename = audios(audio_i);
    [audio,samplerate] = audioread(filename);
    totalSamples = size(audio);
    totalSamples = totalSamples(1);
    
    % Graficamos el audio
    figure();
    plot(audio);
    title(filename, 'Interpreter', 'none')
    grid on;
    
    % Calculamos el tamaño de la ventana segun el samplerate
    muestras_ventana = samplerate*tiempo_ventana; 
    
    % Calculamos los indices desde el centro del audio
    x0 = (totalSamples / 2) - (muestras_ventana / 2); 
    x1 = x0 + muestras_ventana;
    
    % Ventaneamos
    segmento = audio(x0 : x1 - 1);
    ventana = hamming(x1-x0).*segmento;
    
    % Graficamos
    figure()
    grid on;
    xt = x0: 1 : (x1-1); % eje de muestras
    xt_milis = (xt./samplerate).*1000; % eje de tiempo en milisegundos
    plot(xt_milis, ventana);
    titulo = strcat("Audio ventaneado de ", filename);
    title(titulo, 'Interpreter', 'none') % para que imprima bien el nombre del archivo
    xlim([xt_milis(1) xt_milis(end)])
    xlabel('t (ms)') 
    ylabel('Amplitud') 
    
    % Para la ventana, hacemos un LPC para cada P
    for p_i = 1:3
        P = P_vect(p_i);
        
        % Estimamos los coeficientes a_i y la ganancia G
        [LPC,G] = param_lpc(ventana, P);

        % Peridograma
        graf = PeriodogramaDEP(LPC,G);
        
        % PSD
        X = CorrelacionInsesgada(ventana);
        psd = abs(fft(X,1000));
        
% -------------------------------------------------------------------------
% TODO: superponer ambos graficos, y estimacion de autocorrelación xcorr(x)
% -------------------------------------------------------------------------
        
        figure()
        plot(graf)
        hold on
        plot(mag2db(psd));
        titulo = strcat("Periodograma y PSD de ", filename, ", P=", num2str(P));
        title(titulo, 'Interpreter', 'none')
        grid on;
        xlim([xt_milis(1) xt_milis(end)])
        xlabel('Muestras') 
        ylabel('Amplitud (dbm)') 
        hold off
        
    end
end

