% Ejercicio 4

% Parametros
tiempo_ventana = 30e-3;
P = 50;

%% audio_01
close all;

% Parametros
tiempo_ventana = 50e-3;
P = 50;
alfa = 0.07;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_01.wav", tiempo_ventana, P, alfa);

figure
plot(reCorrs);

audio_regenerado = audio_regenerado./max(audio_regenerado)./1.4;
audio = audio./max(audio)./1.4;

figure
plot(audio)
hold on
plot(audio_regenerado)

player = audioplayer(audio_regenerado,samplerate);
playblocking(player);

%% audio_02
close all;

% Parametros
tiempo_ventana = 50e-3;
P = 50;
alfa = 0.07;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_02.wav", tiempo_ventana, P, alfa);

figure
plot(reCorrs);

audio_regenerado = audio_regenerado./max(audio_regenerado)./1.4;
audio = audio./max(audio)./1.4;

figure
plot(audio)
hold on
plot(audio_regenerado)

player = audioplayer(audio_regenerado,samplerate);
playblocking(player);

%% audio_03
close all;

% Parametros
tiempo_ventana = 50e-3;
P = 50;
alfa = 0.05;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_02.wav", tiempo_ventana, P, alfa);

figure
plot(reCorrs);

audio_regenerado = audio_regenerado./max(audio_regenerado)./1.4;
audio = audio./max(audio)./1.4;

figure
plot(audio)
hold on
plot(audio_regenerado)

player = audioplayer(audio_regenerado,samplerate);
playblocking(player);

%% audio_04
close all;

% Parametros
tiempo_ventana = 50e-3;
P = 50;
alfa = 0.05;

[audio, audio_regenerado, samplerate, reCorrs] = LPC("audio_02.wav", tiempo_ventana, P, alfa);

figure
plot(reCorrs);

audio_regenerado = audio_regenerado./max(audio_regenerado)./1.4;
audio = audio./max(audio)./1.4;

figure
plot(audio)
hold on
plot(audio_regenerado)

player = audioplayer(audio_regenerado,samplerate);
playblocking(player);