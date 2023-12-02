function [XVerdadera,SVerdadera,VVerdadera, ... 
            EstimacionV,W] = EstimacionDelFiltroA(M,mu)
L = 20000;
Exedente = 20;

a = [1];
bS = [1 0.9 0.5 0.45 0.35 0.25];
bU = [0.8 0.2 -0.1];
SigmaR2 = 0.0005; 

%%% Me genero los vectores de los procesos estocasticos
R = normrnd(0,sqrt(SigmaR2),L+Exedente,1);
sAuxiliar = filter(bS,a,R);
S = sAuxiliar(Exedente+1-M:L+Exedente);
SigmaS2 = var(S);
SigmaV2 = SigmaS2/(10^2);
vAuxiliar = normrnd(0,sqrt(SigmaV2),L+Exedente,1);
V = vAuxiliar(Exedente+1-M:L+Exedente);
uAuxiliar = filter(bU,a,vAuxiliar);
U = uAuxiliar(Exedente+1-M:L+Exedente);
X = S + V;

%%% Creo la matriz W y establezco las condiciones iniciales
W = zeros(M,L+1);
for i = 1:M
    W(i,1) = 5;
end

%%% Calculo el filtro adaptado 
EstimacionV = zeros(L,1);
for i = 1:L
    Error = X(i+M-1)-U(i:i+M-1)'*W(:,i);
    W(:,i+1) = W(:,i) + mu*U(i:i+M-1)*Error;
    EstimacionV(i) = W(:,i+1)'*U(i:i+M-1);
end

%%% Devuelvo los valores de las señales que se usaron
SVerdadera = S(M:L+M-1);
XVerdadera = X(M:L+M-1);
VVerdadera = V(M:L+M-1);

