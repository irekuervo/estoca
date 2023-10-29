function [audio, audio_regenerado, samplerate, reCorrs, pitches] = LPC(filename, tiempo_ventana, P, alfa)

% Abrimos el audio
[audio, samplerate] = audioread(filename);

muestras_ventana = samplerate*tiempo_ventana; 

% Armamos una matriz con todas las ventanas como columnas
matriz_ventanas = Segmentacion(audio,muestras_ventana);

[muestras_ventana, cantidad_ventanas] = size(matriz_ventanas);

matriz_reconstruida = zeros(muestras_ventana, cantidad_ventanas);

% Para calibrar visualmente el valor de alfa
reCorrs = zeros(muestras_ventana,cantidad_ventanas);
% Para ver cuantos y que valores toman los pitches detectados
pitches =[];

% Por cada ventana hacemos LPC, reconstruimos y guardamos en una matriz
for i = 1:cantidad_ventanas
    
    ventana = matriz_ventanas(:,i);
    
    [A, G] = param_lpc(ventana, P);
    
    [pitch, reCorr] = pitch_lpc(ventana, A, alfa, samplerate);
    
    reCorrs(:,i) = reCorr;
    
    entrada = [];
    esConsonante = pitch == 0;
    if(esConsonante)
        entrada = normrnd(0,1, muestras_ventana, 1);
    else
        pitches  = [pitches pitch];
        entrada = TrenImpulsos(samplerate, pitch, muestras_ventana);
    end
        
    ventana_reconstruida = filter(G, [1 -A'], entrada);
    
    matriz_reconstruida(:,i) = ventana_reconstruida';
end

% Resegmentamos las ventanas y armamos el audio
audio_regenerado = Resegmentacion(matriz_reconstruida)';
% Recortamos
diff = size(audio_regenerado) - size(audio) + 1;
audio_regenerado = audio_regenerado(diff:end);
end

