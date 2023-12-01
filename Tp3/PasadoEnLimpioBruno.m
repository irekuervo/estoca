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
        EstimacionV,W] = EstimacionDelFiltro(M,mu);

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
            EstimacionV,W] = EstimacionDelFiltro(M(j),mu);

        EstimacionS = XVerdadera-EstimacionV;

        EstimacionErrorE = EstimacionErrorE + (EstimacionS - SVerdadera).^2/N;
        EstimacionErrorJ = EstimacionErrorJ + (EstimacionV - VVerdadera).^2/N;
    end
    EstimacionEInfinito(j) = mean(EstimacionErrorE(10000:20000)); 
end

figure()
plot(EstimacionEInfinito)

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
            EstimacionV,W] = EstimacionDelFiltro(M,mu(j));

        EstimacionS = XVerdadera-EstimacionV;

        EstimacionErrorE = EstimacionErrorE + (EstimacionS - SVerdadera).^2/N;
        EstimacionErrorJ = EstimacionErrorJ + (EstimacionV - VVerdadera).^2/N;
    end
    EstimacionEInfinito(j) = mean(EstimacionErrorE(10000:20000)); 
    plot(EstimacionErrorE)
end

figure()
plot(EstimacionEInfinito)


