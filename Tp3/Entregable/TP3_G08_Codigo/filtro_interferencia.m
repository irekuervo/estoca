function [W, G_est] = filtro_interferencia(X, Y, mu, w0)

[N,L] = size(X);
M = 2;
W = zeros(M,N);
W(:,1) = w0;
G_est = zeros(N, 1);

for i = 1 : N - M - 1
    salida = Y(i, :) * W(:, i);
    error = X(i) - salida;
    W(:,i+1) = W(:,i) + mu * Y(i, :)' * error;
    G_est(i) = Y(i, :) * W(:,i+1);
end

end

