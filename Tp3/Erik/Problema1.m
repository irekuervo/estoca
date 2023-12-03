

%% Punto b)
clear all;
close all;
N = 20000;
SNR = 20;
[X,S,V,U] = armar_seniales(N, SNR);

figure()
hold on
plot(V);
plot(U);
legend('V','U')

figure()
plot(S);

figure()
plot(X);

%% Punto c)
clear all;
close all;

N = 20000;
SNR = 20;

mu = 50;
w0 = [5 5 5 5 5]'; % valores iniciales del filtro
[M,L] = size(w0);

realizaciones = 500;
J_est = zeros(N,1);
Err_est = zeros(N,1);

for i = 1:realizaciones
    
    [X,S,V,U] = armar_seniales(N, SNR);
    [W, V_est] = filtro1(S, V, U, mu, w0);
 
    S_est = (X - V_est);
    Err_est = Err_est + (S_est - S).^2/realizaciones;
    J_est = J_est + (V_est - V).^2/realizaciones;
    
    % Para debuggear
    if i == 1
        figure()
        plot(V_est)
        hold on
        plot(V);
        legend('V_est','V')
        
        figure()
        plot(S_est)
        hold on
        plot(S);
        legend('S_est','S')
        
        figure()
        plot(Err_est)
        figure()
        plot(J_est)
    end
end

figure()
plot(Err_est)
figure()
plot(J_est)

figure()
hold on
for i = 1:M
    plot(W(i,:))
end