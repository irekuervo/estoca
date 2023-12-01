%%%%%% Auxiliar problema 2

close all
clear all
L = 20000;
Exedente = 10;
fs = 44100;

M = 2;
mu = 0.001;
a = [1];
bS = [1 0.9 0.5 0.45 0.35 0.25];
SigmaR2 = 0.0005; 
Amplitud = normrnd(0.1,sqrt(0.003),1);
Fase = unifrnd(0,2*pi);

G = Amplitud*sin(2*pi*500/fs*(1:L)+Fase)';
R = normrnd(0,sqrt(SigmaR2),L+Exedente,1);
SAuxiliar = filter(bS,a,R);
S = SAuxiliar(Exedente+1:L+Exedente);
X = S + G;

figure()
plot(X)
Entrada = zeros(L,2);
Entrada(:,1) = sin(2*pi*500/fs*(1:L));
Entrada(:,2) = cos(2*pi*500/fs*(1:L));
EstimacionG  = zeros(L,1);

W = zeros(M,L+1);
for i = 1:M
    W(i,1) = 0;
end

for i = 1:L
    Error = X(i)-Entrada(i,:)*W(:,i);
    W(:,i+1) = W(:,i) + mu*Entrada(i,:)'*Error;
    EstimacionG(i) =  Entrada(i,:)*W(:,i+1);
end

figure()
hold on
plot(W(1,:))
plot(W(2,:))

figure()
hold on
plot(EstimacionG)
plot(G)

figure()
hold on
plot(EstimacionG)

%%

close all
clear all
N = 500;
L = 20000;
Exedente = 10;
fs = 44100;

M = 2;
mu = 0.001;
a = [1];
bS = [1 0.9 0.5 0.45 0.35 0.25];
SigmaR2 = 0.0005; 
EstimacionErrorJ = zeros(20000,1);
EstimacionErrorE = zeros(20000,1);

for i = 1:500

    
end