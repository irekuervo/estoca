close all;
clear all;

%% Ejercicio 2


filename = "audio_a.wav";

% Vemos el audio
[y,samplerate] = audioread(filename);
figure()
plot(y);
player = audioplayer(y,samplerate);
playblocking(player);

info = audioinfo(filename);
samplerate = info.SampleRate;
samples = info.TotalSamples;


% Ventaneamos desde el centro

% tiempo de ventana
tw = 30e-3;
% cantidad de muestras en esa ventana
nw = samplerate*tw; 
% arrancamos centrado en la mitad
x0 = (samples / 2) - (nw / 2); 
x1 = x0 + nw;

% leemos solo ese segmento
[y,Fs] = audioread(filename, [x0,x1 - 1]);
w = hamming(x1-x0);
y = w.*y;
figure()
plot(y);

% COMO HAGO OVERLAP 50% ??
Y = repmat(y, tw*1000 , 1);
figure()
plot(Y);
player = audioplayer(Y,samplerate);
playblocking(player);

%% pitch
close all
p = 5;
alfa = 0.005;
[coefs, G, pitchIndex, pitchMagnitud] = pitch_lpc(y, p , alfa);
pitch = samplerate/pitchIndex;

%%Tren
tren = trenImpulsos(samplerate,pitch,nw);
figure()
plot(tren);