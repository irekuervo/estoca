close all
clear all

L = 20000;
Exedente = 5;
M1 = 3;
mu1 = 50;
M2 = 2;
mu2 = 0.001;
fs = 44100;

a = [1];
bS = [1 0.9 0.5 0.45 0.35 0.25];
bU = [0.8 0.2 -0.1];
SigmaR2 = 0.0005; 
Amplitud = normrnd(0.1,sqrt(0.003),1);
Fase = unifrnd(0,2*pi);

Entrada = zeros(L,2);
Entrada(:,1) = sin(2*pi*500/fs*(1:L));
Entrada(:,2) = cos(2*pi*500/fs*(1:L));

R = normrnd(0,sqrt(SigmaR2),L+Exedente,1);
sAuxiliar = filter(bS,a,R);
S = sAuxiliar(Exedente+1-M1:L+Exedente);
SigmaS2 = var(S);
SigmaV2 = SigmaS2/(10^2);
vAuxiliar = normrnd(0,sqrt(SigmaV2),L+Exedente,1);
V = vAuxiliar(Exedente+1-M1:L+Exedente);
uAuxiliar = filter(bU,a,vAuxiliar);
U = uAuxiliar(Exedente+1-M1:L+Exedente);
G = Amplitud*sin(2*pi*500/fs*(Exedente+1-M1:L+Exedente)+Fase)';

X1 = S + V + G;
X2 = X1(M1:L+M1-1);

W1 = zeros(M1,L+1);
for i = 1:M1
    W1(i,1) = 5;
end

EstimacionV = zeros(L,1);
for i = 1:L
    Error = X1(i+M1-1)-U(i:i+M1-1)'*W1(:,i);
    W1(:,i+1) = W1(:,i) + mu1*U(i:i+M1-1)*Error;
    EstimacionV(i) = W1(:,i+1)'*U(i:i+M1-1);
end

W2 = zeros(M2,L+1);
for i = 1:M2
    W2(i,1) = 0;
end

%%% Calculo el filtro adaptado 
EstimacionG = zeros(L,1);
for i = 1:L
    Error = X2(i)-Entrada(i,:)*W2(:,i);
    W2(:,i+1) = W2(:,i) + mu2*Entrada(i,:)'*Error;
    EstimacionG(i) =  Entrada(i,:)*W2(:,i+1);
end

SVerdadera = S(M1:L+M1-1);
EstimacionS = X2-EstimacionG -EstimacionV;
EstimacionErrorE = (SVerdadera-EstimacionS).^2;

figure()
hold on
plot(SVerdadera)
plot(EstimacionS)

figure()
plot(EstimacionErrorE)