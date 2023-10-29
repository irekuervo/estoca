% Ejercicio 4
close all;
clear all;

% Parametros
tiempo_ventana = 30e-3;
P = 50;
alfa = 4.5e-5;

% Abrimos el audio
[audio,samplerate] = audioread("audio_01.wav");
player = audioplayer(audio,samplerate);

muestras_ventana = samplerate*tiempo_ventana; 

% Armamos una matriz con todas las ventanas como columnas
matriz_ventanas = Segmentacion(audio,muestras_ventana);

[muestras_ventana,cantidad_ventanas] = size(matriz_ventanas);

matriz_reconstruida = zeros(muestras_ventana, cantidad_ventanas);

ecors = zeros(muestras_ventana,cantidad_ventanas);
pitches = [];


% Por cada ventana hacemos LPC, reconstruimos y guardamos en una matriz
for i = 1:cantidad_ventanas
    
    ventana = matriz_ventanas(:,i);
    
    [LPC, G] = param_lpc(ventana, P);
    
    %% buscamos el pitch

    filter_coefs = [1 -1*LPC'];
    e = filter(filter_coefs,1, ventana);
    eCorr = Correlacion(e);
    ecors(:,i)= eCorr;
   
    pitch_indexes = find(eCorr(10:end) > alfa, 1,'last');
    pitchIndex=0;
    if ~isempty(pitch_indexes)
        pitchIndex = pitch_indexes(1);
    end
    
    entrada = [];
    esConsonante = pitchIndex == 0;
    if(esConsonante)
        entrada = normrnd(0,1, muestras_ventana, 1);
    else
        pitch = samplerate/pitchIndex;
        pitches = [pitches pitch];
        entrada = TrenImpulsos(samplerate, pitch, muestras_ventana);
    end
        
    % para armar el filtro
    coefs_denominador = [1 -LPC']; 
    
    % generamos la ventana
    ventana_reconstruida = filter(G, coefs_denominador, entrada);
    
    matriz_reconstruida(:,i) = ventana_reconstruida';
end

% Resegmentamos las ventanas y armamos el audio
audio_regenerado = Resegmentacion(matriz_reconstruida);

% Escuchamos
player = audioplayer(audio_regenerado,samplerate);
playblocking(player);
audiowrite('audio_ej4.wav',audio_regenerado,samplerate)
