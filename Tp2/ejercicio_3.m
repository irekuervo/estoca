% Ejercicio 3

%% vocal-audio_a.wav
close all;
clear all;

% Parametros
tiempo_ventana = 30e-3;
P = 30;
pitch = 200; %Hz

% Abrimos el audio
[audio,samplerate] = audioread("audio_a.wav");
player = audioplayer(audio,samplerate);
playblocking(player);

 % Graficamos el audio
figure();
plot(audio);
title("audio_a.wav", 'Interpreter', 'none')
grid on;

muestras_ventana = samplerate*tiempo_ventana; 

% Armamos una matriz con todas las ventanas como columnas
matriz_ventanas = Segmentacion2(audio,muestras_ventana);

[muestras_ventana,cantidad_ventanas] = size(matriz_ventanas);

matriz_reconstruida = zeros(muestras_ventana, cantidad_ventanas);

% Por cada ventana hacemos LPC, reconstruimos y guardamos en una matriz
for i = 1:cantidad_ventanas
    ventana = matriz_ventanas(:,i);
    [LPC, G] = param_lpc(ventana, P);
    
% -------------------------------------------------------------------------
% TODO: Arreglar el problema de ganancias complejas, qué hacemos??
% -------------------------------------------------------------------------
    if isreal(G) == 0
        G = 1;
    end
    
    % para armar el filtro
    coefs_denominador = [1 -1*LPC'];
    % como es vocal, usamos un tren de deltas
    entrada = trenImpulsos(samplerate, pitch, muestras_ventana); 
    % generamos la ventana
    ventana_reconstruida = filter(coefs_denominador, G, entrada);
    matriz_reconstruida(:,i) = ventana_reconstruida';
end

% Resegmentamos las ventanas y armamos el audio
audio_regenerado = Resegmentacion(matriz_reconstruida);

% Graficamos
figure()
plot(audio_regenerado);
title("audio_a.wav regenerado", 'Interpreter', 'none')
grid on;
% Escuchamos
player = audioplayer(audio_regenerado,samplerate);
playblocking(player);

%% vocal-audio_s.wav
close all;
clear all;

% Parametros
tiempo_ventana = 30e-3;
P = 30;

% Abrimos el audio
[audio,samplerate] = audioread("audio_s.wav");
player = audioplayer(audio,samplerate);
playblocking(player);

 % Graficamos el audio
figure();
plot(audio);
title("audio_a.wav", 'Interpreter', 'none')
grid on;

muestras_ventana = samplerate*tiempo_ventana; 

% Armamos una matriz con todas las ventanas como columnas
matriz_ventanas = Segmentacion2(audio,muestras_ventana);

[muestras_ventana,cantidad_ventanas] = size(matriz_ventanas);

matriz_reconstruida = zeros(muestras_ventana, cantidad_ventanas);

% Por cada ventana hacemos LPC, reconstruimos y guardamos en una matriz
for i = 1:cantidad_ventanas
    ventana = matriz_ventanas(:,i);
    [LPC, G] = param_lpc(ventana, P);
    
% -------------------------------------------------------------------------
% TODO: Arreglar el problema de ganancias complejas, qué hacemos??
% -------------------------------------------------------------------------
    if isreal(G) == 0
        G = 1;
    end
    
    % para armar el filtro
    coefs_denominador = [1 -1*LPC'];
    % como es vocal, usamos un tren de deltas
    entrada = normrnd(0,1, muestras_ventana, 1); 
    % generamos la ventana
    ventana_reconstruida = filter(coefs_denominador, G, entrada);
    matriz_reconstruida(:,i) = ventana_reconstruida';
end

% Resegmentamos las ventanas y armamos el audio
audio_regenerado = Resegmentacion(matriz_reconstruida);

% Graficamos
figure()
plot(audio_regenerado);
title("audio_a.wav regenerado", 'Interpreter', 'none')
grid on;
% Escuchamos
player = audioplayer(audio_regenerado,samplerate);
playblocking(player);