function [W, V_est] = filtro_interferencia(S, V, U, mu, w0)

X = S + V;

[N,L] = size(S);
M = 2;
W = zeros(M,N);
W(:,1) = w0;
V_est = zeros(N, 1);

for i = 1 : N - M - 1
    k = i + M - 1;
    Y = U(i:k)' * W(:,i);
    error = X(k) - Y;
    W(:,i+1) = W(:,i) + mu * U(i : k) * error;
    V_est(k) = U(i:k)'*W(:,i+1);
end

end

