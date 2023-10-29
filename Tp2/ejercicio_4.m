% Ejercicio 4

% Ejecutar cada audio como bloque

ESCUCHAR_AUDIOS = 0; % 0 == no, 1 == si

tiempo_ventana = 50e-3;
P = 30;

%% audio_01
close all;

alfa = 0.1;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_01.wav", tiempo_ventana, P, alfa);

muestras = size(audio);
muestrasVentana = size(reCorrs);

% Graficamos normalizado en energia
graf = figure;
t = linspace(1, muestras(1) / samplerate, muestras(1));
plot(t, audio./rms(audio));
hold on
grid on;
plot(t, audio_regenerado./rms(audio_regenerado));
title('Comparación de audios')
xlim([t(1) t(end)])
xlabel('Tiempo (s)'), ylabel('Amplitud normalizada')
legend('Audio Original','Audio Reconstruido')
saveas(graf,"ej4_1_1.png")

% Vemos los residuos para calibrar el alfa
graf = figure;
plot(reCorrs);
grid on;
title('Autocorrelaciónes del residuo de la ventana')
xlabel('k'), ylabel('Amplitud normalizada')
saveas(graf,"ej4_1_2.png")

% Reproducimos el audio regenerado
player = audioplayer(audio_regenerado, samplerate);
if ESCUCHAR_AUDIOS ~= 0
    playblocking(player);
end

%% audio_02
close all;

alfa = 0.06;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_02.wav", tiempo_ventana, P, alfa);

muestras = size(audio);

% Graficamos normalizado en energia
graf = figure;
t = linspace(1, muestras(1) / samplerate, muestras(1));
plot(t, audio./rms(audio));
hold on
grid on;
plot(t, audio_regenerado./rms(audio_regenerado));
title('Comparación de audios')
xlim([t(1) t(end)])
xlabel('Tiempo (s)'), ylabel('Amplitud normalizada')
legend('Audio Original','Audio Reconstruido')
saveas(graf,"ej4_2_1.png")

% Vemos los residuos para calibrar el alfa
graf = figure;
plot(reCorrs);
grid on;
title('Autocorrelaciónes del residuo de la ventana')
xlabel('k'), ylabel('Amplitud normalizada')
saveas(graf,"ej4_2_2.png")

% Reproducimos el audio regenerado
player = audioplayer(audio_regenerado, samplerate);
if ESCUCHAR_AUDIOS ~= 0
    playblocking(player);
end

%% audio_03
close all;

alfa = 0.1;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_03.wav", tiempo_ventana, P, alfa);

muestras = size(audio);

% Graficamos normalizado en energia
graf = figure;
t = linspace(1, muestras(1) / samplerate, muestras(1));
plot(t, audio./rms(audio));
hold on
grid on;
plot(t, audio_regenerado./rms(audio_regenerado));
title('Comparación de audios')
xlim([t(1) t(end)])
xlabel('Tiempo (s)'), ylabel('Amplitud normalizada')
legend('Audio Original','Audio Reconstruido')
saveas(graf,"ej4_3_1.png")

% Vemos los residuos para calibrar el alfa
graf = figure;
plot(reCorrs);
grid on;
title('Autocorrelaciónes del residuo de la ventana')
xlabel('k'), ylabel('Amplitud normalizada')
saveas(graf,"ej4_3_2.png")

% Reproducimos el audio regenerado
player = audioplayer(audio_regenerado, samplerate);
if ESCUCHAR_AUDIOS ~= 0
    playblocking(player);
end


%% audio_04
close all;

alfa = 0.05;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_04.wav", tiempo_ventana, P, alfa);

muestras = size(audio);

% Graficamos normalizado en energia
graf = figure;
t = linspace(1, muestras(1) / samplerate, muestras(1));
plot(t, audio./rms(audio));
hold on
grid on;
plot(t, audio_regenerado./rms(audio_regenerado));
title('Comparación de audios')
xlim([t(1) t(end)])
xlabel('Tiempo (s)'), ylabel('Amplitud normalizada')
legend('Audio Original','Audio Reconstruido')
saveas(graf,"ej4_4_1.png")

% Vemos los residuos para calibrar el alfa
graf = figure;
plot(reCorrs);
grid on;
title('Autocorrelaciónes del residuo de la ventana')
xlabel('k'), ylabel('Amplitud normalizada')
saveas(graf,"ej4_4_2.png")

% Reproducimos el audio regenerado
player = audioplayer(audio_regenerado, samplerate);
if ESCUCHAR_AUDIOS ~= 0
    playblocking(player);
end
