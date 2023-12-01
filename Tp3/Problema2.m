%%%%%% Auxiliar problema 2

close all
clear all
L = 20010;
fs = 44100;

M = 3;
mu = 50;
a = [1];
bS = [1 0.9 0.5 0.45 0.35 0.25];
bU = [0.8 0.2 -0.1];
SigmaR2 = 0.0005; 
Amplitud = normrnd(0.1,sqrt(0.003),1);
Fase = unifrnd(0,2*pi);

GAuxiliar = Amplitud*sin(2*pi*500/fs*(1:L)+Fase)';
G = GAuxiliar(9:20010);
R = normrnd(0,sqrt(SigmaR2),L,1);
SAuxiliar = filter(bS,a,R);
S = SAuxiliar(9:20010);
X = S + G;

figure()
plot(X)


