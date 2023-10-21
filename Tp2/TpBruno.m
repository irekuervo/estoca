close all;
clear all;

%% Ejercicio 2

filename = 'audio_a.wav';

% Vemos el audio
[y,samplerate] = audioread(filename);
figure()
plot(y);
player = audioplayer(y,samplerate);
playblocking(player);


info = audioinfo(filename);
samplerate = info.SampleRate;
samples = info.TotalSamples;

%%
% Ventaneamos desde el centro
close all

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

%%
close all
% COMO HAGO OVERLAP 50% ??
Y = repmat(y, tw*1000 , 1);
figure()    
plot(Y);
player = audioplayer(Y,samplerate);
playblocking(player);

%%
close all

[Final,Ganancia] = param_lpc(y,5);

Grgico = PeriodogramaDEP(Final,Ganancia);

figure()
plot(1:1000,Grgico)


X = CorrelacionInsesgada(y);
figure()
plot((1:512)/512*2,mag2db(abs(fft(X,512))))

%%
close all

[y,samplerate] = audioread(filename);
MatrizAudio = Segmentacion(y,nw);


