% Ejercicio 4

%% audio_01
close all;

% Parametros
tiempo_ventana = 50e-3;
P = 50;
alfa = 0.09;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_01.wav", tiempo_ventana, P, alfa);

% Graficamos normalizado
figure
plot(audio./max(audio))
hold on
plot(audio_regenerado./max(audio_regenerado))

% Vemos los residuos para calibrar el alfa
figure
plot(reCorrs);

player = audioplayer(audio_regenerado, samplerate);
playblocking(player);

%% audio_02
close all;

% Parametros
tiempo_ventana = 50e-3;
P = 50;
alfa = 0.07;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_02.wav", tiempo_ventana, P, alfa);

% Graficamos normalizado
figure
plot(audio./max(audio))
hold on
plot(audio_regenerado./max(audio_regenerado))

% Vemos los residuos para calibrar el alfa
figure
plot(reCorrs);

player = audioplayer(audio_regenerado, samplerate);
playblocking(player);

%% audio_03
close all;

% Parametros
tiempo_ventana = 50e-3;
P = 50;
alfa = 0.1;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_03.wav", tiempo_ventana, P, alfa);

% Graficamos normalizado
figure
plot(audio./max(audio))
hold on
plot(audio_regenerado./max(audio_regenerado))

% Vemos los residuos para calibrar el alfa
figure
plot(reCorrs);

player = audioplayer(audio_regenerado, samplerate);
playblocking(player);

%% audio_04
close all;

% Parametros
tiempo_ventana = 50e-3;
P = 50;
alfa = 0.1;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_04.wav", tiempo_ventana, P, alfa);

% Graficamos normalizado
figure
plot(audio./max(audio))
hold on
plot(audio_regenerado./max(audio_regenerado))

% Vemos los residuos para calibrar el alfa
figure
plot(reCorrs);

player = audioplayer(audio_regenerado, samplerate);
playblocking(player);
