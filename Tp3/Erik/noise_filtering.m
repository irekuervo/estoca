function [W, V_est, J_est, Err_est] = noise_filtering(S, V, U, mu, w0)

S = flip(S);
V = flip(V);
U = flip(U);
X = S + V;

[N,L] = size(X);
[M,L] = size(w0);
W = zeros(M,N);
W(:,1) = w0;
V_est = zeros(N,1);
J_est = zeros(N,1);
Err_est = zeros(N,1);

for k = 1 : N - 1
    indice_M = k + M - 1;
    
    if indice_M <= N
        V_est(k) =  U(k:indice_M)'*W(:,k); % lo pasamos por el filtro actual
        error = X(k) - V_est(k);
        W(:,k+1) = W(:,k) + mu * U(k:indice_M) * error; % corregimos el filtro
    else 
        W(:,k+1) = W(:,k); % los ultimos directamente los copio para no hacer zero padding
    end
   
    % Calculo de aprendizaje y error
    S_est = X(k) - V_est(k);
    Err_est(k) = ((S_est - S(k))^2);
    J_est(k) = ((V_est(k) - V(k))^2);
end

end

