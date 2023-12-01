%%clase 11
%%% Actividad 1

T = 200;

sigma2 = 10^(-5);
w1 = 0.25*pi;
w2 = w1 + pi/L;

v = normrnd(0,sqrt(sigma2), T, 2);

n = (1:T)';
y = exp(1i*n*w1) + exp(1i*n*w2) + v(:,1)+ 1i*v(:,2);

L= 42;

CorrelacionEstimada = zeros(L);
for i = 1:T-L
    Auxiliar = y(i:i+L-1)*y(i:i+L-1)';
    CorrelacionEstimada = Auxiliar + CorrelacionEstimada;
end

CorrelacionEstimada = CorrelacionEstimada/(T-L-1);


[V,D] = eigs(CorrelacionEstimada,42);

G = V(:,3:L);
B = G*G';

