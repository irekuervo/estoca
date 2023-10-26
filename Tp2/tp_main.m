%% Ejercicio 2
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
    tamanio_ventana = samplerate*tiempo_ventana; 
    
    % Calculamos los indices desde el centro del audio
    x0 = (totalSamples / 2) - (tamanio_ventana / 2); 
    x1 = x0 + tamanio_ventana;
    
    % Ventaneamos
    segmento = audio(x0 : x1 - 1);
    ventana = hamming(x1-x0).*segmento;
    figure()
    plot(ventana);
    
    % Para la ventana, hacemos un LPC para cada P
    for p_i = 1:3
        P = P_vect(p_i);
        
        % Estimamos los coeficientes a_i y la ganancia G
        [LPC,G] = param_lpc(ventana, P);

        % Peridograma
        graf = PeriodogramaDEP(LPC,G);

        figure()
        plot(graf)
        hold on
        
        % BRUNO: me ayudas a superponerlos el psd y el peridograma?
        
        % PSD
        X = CorrelacionInsesgada(ventana);
        psd = abs(fft(X,1000));
        plot(mag2db(psd));
        hold off
    end
end


%% Ejercicio 3
close all;
clear all;



%% Ejercicio 4
close all;
clear all;

