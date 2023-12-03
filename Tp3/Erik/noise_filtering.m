function [W, V_est, J_est, Err_est] = noise_filtering(S, V, U, mu, w0)

X = S + V;

[N,L] = size(X);
[M,L] = size(w0);
W = zeros(M,N);
W(:,1) = w0;
V_est = zeros(N,1);
J_est = zeros(N,1);
Err_est = zeros(N,1);

for i = 1 : N - 1
    indice_M = i + M - 1;
    
    if indice_M <= N
        V_est(i) =  U(i:indice_M)'*W(:,i); % lo pasamos por el filtro actual
        error = X(i) - V_est(i);
        W(:,i+1) = W(:,i) + mu * U(i:indice_M) * error; % corregimos el filtro
    else 
        W(:,i+1) = W(:,i); % los ultimos directamente los copio para no hacer zero padding
    end
   
    % Calculo de aprendizaje y error
    S_est = X(i) - V_est(i);
    Err_est(i) = ((S_est - S(i))^2);
    J_est(i) = ((V_est(i) - V(i))^2);
end

end

