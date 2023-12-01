%%%%% Problema 1
close all
clear all
L = 20010;

M = 3;
mu = 50;
a = [1];
bS = [1 0.9 0.5 0.45 0.35 0.25];
bU = [0.8 0.2 -0.1];
SigmaR2 = 0.0005; 

R = normrnd(0,sqrt(SigmaR2),L,1);
sAuxiliar = filter(bS,a,R);
S = sAuxiliar(9:20010);
SigmaS2 = var(S);
SigmaV2 = SigmaS2/(10^2);
vAuxiliar = normrnd(0,sqrt(SigmaV2),L,1);
V = vAuxiliar(9:20010);
uAuxiliar = filter(bU,a,vAuxiliar);
U = uAuxiliar(9:20010);
X = S + V;


W = zeros(M,L-M+1-8);
W(:,1) = [5 5 5];
EstimacionV = zeros(L-M+1-8,1);

for i = 1:L-M+1-8
    Error = X(i+M-1)-U(i:i+M-1)'*W(:,i);
    W(:,i+1) = W(:,i) + mu*U(i:i+M-1)*Error;
    EstimacionV(i) = U(i:i+M-1)'*W(:,i+1);
end

figure()
hold on
for i =1:M
    plot(W(i,:))
end

SVerdadera = S(3:20002);
SRuidoCancelado = X(3:20002)-EstimacionV;
ErrorEstimacion = V(3:20002) - EstimacionV;

figure()
hold on
plot(SVerdadera)
plot(SRuidoCancelado)
plot(X(3:20002))
legend('S Verdadera','S Ruido Cancelado','Salida')

figure()
hold on;
plot(EstimacionV)
plot(V(3:20002))
legend('Estimacion V','Ruido verdadero')

figure()
plot(ErrorEstimacion)

%% Punto d


