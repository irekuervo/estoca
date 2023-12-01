clear all;
close all;

N = 20000;

a = [1];
b = [1 0.9 0.5 0.45 0.35 2.25]; %coefs filtro 1
b2 = [0.8 0.2 -0.1]; %coefs filtro 2

rb = normrnd(0, sqrt(5e-4) ,N,1);

% varianzaV = varianzaS / 10 ^ (20/10);
v = normrnd(0, sqrt(5e-6) ,N,1);

s = filter(b, a, rb); % señal de interes
x = v + s; % Señal entrada Mic-1
u = filter(b2, a, v);% Señal entrada Mic-2

corr(u,v);

M = 3; % Largo del filtro
mu = 50;
W = zeros(M,N-M+1);
w0 = [5 5 5];
W(:,1) = w0';

J = zeros(N-M+1,1); % aprendizaje

for i =1:(N-M+1)
    Error = Salida(i+LargoFiltro-1)-X(i:i+LargoFiltro-1)'*W(:,i);
    W(:,i+1) = W(:,i) + mu*X(i:i+LargoFiltro-1)*Error;
    J(i) = Error^2/LargoFiltro;
end

figure()
hold on
for i =1:LargoFiltro
    plot(W(i,:))
    plot((1:(L-LargoFiltro+1))*0+b(i))
end
