%%%%%%%%%% Problema 1
%%%%% Punto B
clear all
close all

L = 20000;
Exedente = 5;

a = [1];
bS = [1 0.9 0.5 0.45 0.35 0.25];
bU = [0.8 0.2 -0.1];
SigmaR2 = 0.0005; 

R = normrnd(0,sqrt(SigmaR2),L+Exedente,1);
sAuxiliar = filter(bS,a,R);
S = sAuxiliar(Exedente+1:L+Exedente);

SigmaS2 = var(S);
SigmaV2 = SigmaS2/(10^2);
vAuxiliar = normrnd(0,sqrt(SigmaV2),L+Exedente,1);
V = vAuxiliar(Exedente+1:L+Exedente);
uAuxiliar = filter(bU,a,vAuxiliar);
U = uAuxiliar(Exedente+1:L+Exedente);

X = S + V;

%%
%%%%% Punto C
clear all
close all

M = 5;
mu = 50;
N = 500;

EstimacionErrorJ = zeros(20000,1);
EstimacionErrorE = zeros(20000,1);

for i = 1:N
    [XVerdadera,SVerdadera,VVerdadera, ... 
        EstimacionV,W] = EstimacionDelFiltroA(M,mu);

    EstimacionS = XVerdadera-EstimacionV;
    
    EstimacionErrorE = EstimacionErrorE + (EstimacionS - SVerdadera).^2/N;
    EstimacionErrorJ = EstimacionErrorJ + (EstimacionV - VVerdadera).^2/N;
end

figure()
plot(EstimacionErrorE)
figure()
plot(EstimacionErrorJ)

figure()
hold on
for i = 1:M
    plot(W(i,:))
end

%%
%%%%% Punto D
clear all
close all

Max = 5;
M = 1:Max;
mu = 50;
N = 500;

EstimacionEInfinito = zeros(Max,1);

for j = M
    EstimacionErrorJ = zeros(20000,1);
    EstimacionErrorE = zeros(20000,1);
    for i = 1:N
        [XVerdadera,SVerdadera,VVerdadera, ... 
            EstimacionV,W] = EstimacionDelFiltroA(M(j),mu);

        EstimacionS = XVerdadera-EstimacionV;

        EstimacionErrorE = EstimacionErrorE + (EstimacionS - SVerdadera).^2/N;
        EstimacionErrorJ = EstimacionErrorJ + (EstimacionV - VVerdadera).^2/N;
    end
    EstimacionEInfinito(j) = mean(EstimacionErrorE(10000:20000)); 
end

figure()
plot(EstimacionEInfinito,'o')

%%
%%%%% Punto E
clear all
close all

M = 2;
mu = (3:10)*10;
N = 500;

EstimacionEInfinito = zeros(length(mu),1);

figure()
hold on
for j = 1:length(mu)
    EstimacionErrorJ = zeros(20000,1);
    EstimacionErrorE = zeros(20000,1);
    for i = 1:N
        [XVerdadera,SVerdadera,VVerdadera, ... 
            EstimacionV,W] = EstimacionDelFiltroA(M,mu(j));

        EstimacionS = XVerdadera-EstimacionV;

        EstimacionErrorE = EstimacionErrorE + (EstimacionS - SVerdadera).^2/N;
        EstimacionErrorJ = EstimacionErrorJ + (EstimacionV - VVerdadera).^2/N;
    end
    EstimacionEInfinito(j) = mean(EstimacionErrorE(10000:20000)); 
    plot(EstimacionErrorE)
end

figure()
plot(EstimacionEInfinito,'o')

%%
%%%%%%%%%% Problema 2
%%%%% Punto B
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

%%
%%%%% Punto C
close all
clear all

mu = 0.001;
N = 500;

EstimacionErrorJ = zeros(20000,1);
EstimacionErrorE = zeros(20000,1);

for i = 1:N
    [XVerdadera,SVerdadera,GVerdadera, ... 
        EstimacionG,W] = EstimacionDelFiltroB(mu);

    EstimacionS = XVerdadera-EstimacionG;
    
    EstimacionErrorE = EstimacionErrorE + (EstimacionS - SVerdadera).^2/N;
    EstimacionErrorJ = EstimacionErrorJ + (EstimacionG - GVerdadera).^2/N;
end

figure()
plot(EstimacionErrorE)
figure()
plot(EstimacionErrorJ)

figure()
hold on
for i = 1:2
    plot(W(i,:))
end

%%
%%%%% Punto D
close all
clear all

close all
clear all

mu = (1:5)*0.001;
N = 500;

EstimacionEInfinito = zeros(length(mu),1);

EstimacionErrorJ = zeros(20000,1);
EstimacionErrorE = zeros(20000,1);

figure()
hold on
for j = 1:5
    for i = 1:N
        [XVerdadera,SVerdadera,GVerdadera, ... 
            EstimacionG,W] = EstimacionDelFiltroB(mu(j));

        EstimacionS = XVerdadera-EstimacionG;

        EstimacionErrorE = EstimacionErrorE + (EstimacionS - SVerdadera).^2/N;
        EstimacionErrorJ = EstimacionErrorJ + (EstimacionG - GVerdadera).^2/N;
    end
    EstimacionEInfinito(j) = mean(EstimacionErrorE(10000:20000)); 
    plot(EstimacionErrorE)    
end

figure()
plot(EstimacionEInfinito,'o')

%%
%%%%%%%%%% Problema 3
%%%%% Punto A Forma 1
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

W2 = zeros(M2,L+1);
for i = 1:M2
    W2(i,1) = 0;
end

EstimacionV = zeros(L,1);
for i = 1:L
    Error = X1(i+M1-1)-U(i:i+M1-1)'*W1(:,i);
    W1(:,i+1) = W1(:,i) + mu1*U(i:i+M1-1)*Error;
    EstimacionV(i) = W1(:,i+1)'*U(i:i+M1-1);
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