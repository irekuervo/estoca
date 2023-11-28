%% Actividad 1
%%%% Parte A
close all

L = 2000;
LargoFiltro = 6;
mu = 0.1;
a = [1];
b = [1 0.4 0.3 0.1 -0.2 0.05];

G = binornd(1,0.5,L,1);
X = 2*G-1;
V = normrnd(0,sqrt(0.02),L,1);
Y = filter(b,a,X);
Salida = Y + V;

W = zeros(LargoFiltro,L-LargoFiltro+1);
Aprendizaje = zeros(L-LargoFiltro+1,1);

for i =1:(L-LargoFiltro+1)
    Error = Salida(i+LargoFiltro-1)-X(i:i+LargoFiltro-1)'*W(:,i);
    W(:,i+1) = W(:,i) + mu*X(i:i+LargoFiltro-1)*Error;
    Aprendizaje(i) = Error^2/LargoFiltro;
end

figure()
hold on
for i =1:LargoFiltro
    plot(W(i,:))
    plot((1:(L-LargoFiltro+1))*0+b(i))
end

figure()
plot(Aprendizaje)
ylim([0 2])

%%
%%%% Parte B
close all

L = 2000;
LargoFiltro = 6;
mu = 0.005;
a = [1];
b = [1 0.4 0.3 0.1 -0.2 0.05];

G = binornd(1,0.5,L,1);
X = 2*G-1;
V = normrnd(0,sqrt(0.02),L,1);
Y = filter(b,a,X);
Salida = Y + V;

W = zeros(LargoFiltro,L-LargoFiltro+1);
Aprendizaje = zeros(L-LargoFiltro+1,1);

for i =1:(L-LargoFiltro+1)
    Error = Salida(i+LargoFiltro-1)-X(i:i+LargoFiltro-1)'*W(:,i);
    W(:,i+1) = W(:,i) + mu*X(i:i+LargoFiltro-1)*Error;
    Aprendizaje(i) = Error^2/LargoFiltro;
end

figure()
hold on
for i =1:LargoFiltro
    plot(W(i,:))
    plot((1:(L-LargoFiltro+1))*0+b(i))
end

figure()
plot(Aprendizaje)
ylim([0 2])

%% Actividad 
