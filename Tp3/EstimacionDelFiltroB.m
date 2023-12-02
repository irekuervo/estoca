function [XVerdadera,SVerdadera,GVerdadera, ... 
            EstimacionG,W] = EstimacionDelFiltroB(mu)
L = 20000;
Exedente = 10;
fs = 44100;

M = 2;
a = [1];
bS = [1 0.9 0.5 0.45 0.35 0.25];
SigmaR2 = 0.0005; 
Amplitud = normrnd(0.1,sqrt(0.003),1);
Fase = unifrnd(0,2*pi);

%%% Me genero los vectores de los procesos estocasticos
G = Amplitud*sin(2*pi*500/fs*(1:L)+Fase)';
R = normrnd(0,sqrt(SigmaR2),L+Exedente,1);
SAuxiliar = filter(bS,a,R);
S = SAuxiliar(Exedente+1:L+Exedente);
X = S + G;

%%% Genero las señales de entrada
Entrada = zeros(L,2);
Entrada(:,1) = sin(2*pi*500/fs*(1:L));
Entrada(:,2) = cos(2*pi*500/fs*(1:L));


%%% Creo la matriz W y establezco las condiciones iniciales
W = zeros(M,L+1);
for i = 1:M
    W(i,1) = 0;
end

%%% Calculo el filtro adaptado 
EstimacionG = zeros(L,1);
for i = 1:L
    Error = X(i)-Entrada(i,:)*W(:,i);
    W(:,i+1) = W(:,i) + mu*Entrada(i,:)'*Error;
    EstimacionG(i) =  Entrada(i,:)*W(:,i+1);
end

%%% Devuelvo los valores de las señales que se usaron
SVerdadera = S;
XVerdadera = X;
GVerdadera = G;

