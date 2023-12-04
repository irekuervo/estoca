

%% Punto b)
clear all;
close all;
N = 20000;
fs = 44100;

[X,S,G,Y] = armar_seniales2(N,fs);

graf = figure;
hold on
plot(G);
grid on
title('G - Señal de interferencia')
xlabel('n') 
ylabel('Nivel') 
axis([18000 18500 -0.2 0.2])
saveas(graf,'b_1.png')

graf = figure;
plot(S);
grid on
title('S - Señal de interés')
xlabel('n') 
ylabel('Nivel') 
axis([18000 18500 -0.2 0.2])
saveas(graf,'b_2.png')

graf = figure;
plot(X);
grid on
title('X - Señal con interferencia')
xlabel('n') 
ylabel('Nivel') 
axis([18000 18500 -0.2 0.2])
saveas(graf,'b_3.png')

%% Punto c)
clear all;
close all;

N = 20000;
fs = 44100;

mu = 1e-3;
w0 = [0 0]'; % valores iniciales del filtro
[M,L] = size(w0);

realizaciones = 500;
J_est = zeros(N,1);
Err_est = zeros(N,1);

for i = 1:realizaciones
    
    [X,S,G,Y]  = armar_seniales2(N, fs);
    [W, G_est] = filtro_interferencia(X, Y, mu, w0);
 
    S_est = (X - G_est);
    Err_est = Err_est + (S_est - S).^2/realizaciones;
    J_est = J_est + (G_est - G).^2/realizaciones;
    
end

graf = figure;
plot(G_est)
hold on
plot(G);
grid on
title('Estimación de G')
legend('G_est','G')
xlabel('n') 
ylabel('Nivel') 
axis([18000 18500 -0.2 0.2])
saveas(graf,'c_1.png')

graf = figure;
plot(S_est)
hold on
title('Estimacion de S')
plot(S);
grid on
legend('S_est','S')
xlabel('n') 
ylabel('Nivel') 
axis([18000 18500 -0.2 0.2])
saveas(graf,'c_2.png')

graf = figure;
title('Coeficientes de W')
lgd = cell(M,1);
hold on
for i = 1:M
    plot(W(i,:))
    lgd{i} = strcat('w_',num2str(i-1));
end
grid on
legend(lgd);
xlabel('n') 
ylabel('W(n)') 
saveas(graf,'c_3.png')

graf = figure;
plot(Err_est)
grid on
title('Curva de Error (500 realizaciones)')
xlabel('n') 
ylabel('Err(n)') 
saveas(graf,'c_4.png')

graf = figure;
plot(J_est)
grid on
title('Curva de aprendizaje J (500 realizaciones)')
xlabel('n') 
ylabel('J(n)') 
saveas(graf,'c_5.png')

%% d)
clear all;
close all;

N = 20000;
fs = 44100;

MU = [1e-3 2e-3 3e-3 4e-3 5e-3];
[filas, M] = size(MU);

w0 = [0 0]';
convergencia_err = 7000;
realizaciones = 500;
E = zeros(M, 1);

graf = figure;
title('Curvas de aprendizaje para valores de MU')
xlabel('n') 
ylabel('J(n)') 
grid on
hold on
lgd = cell(5,1);
for index = 1:M
    mu = MU(index);
    J_est = zeros(N,1);
    Err_est = zeros(N,1);
    
    for i = 1:realizaciones
        [X,S,G,Y]  = armar_seniales2(N, fs);
        [W, G_est] = filtro_interferencia(X, Y, mu, w0);

        S_est = (X - G_est);
        Err_est = Err_est + (S_est - S).^2/realizaciones;
        J_est = J_est + (G_est - G).^2/realizaciones;
    end
    
    E(index) = mean(Err_est(convergencia_err:end));
    plot(Err_est);
    lgd{index} = strcat('mu=',num2str(mu));
end
axis([0 0.5e4 0 7e-3])
legend(lgd);
saveas(graf,'d_1.png')

graf = figure;
plot(MU, E);
title('Error vs MU')
grid on
xlabel('MU') 
ylabel('Error(MU)') 
saveas(graf,'d_2.png')

%% e)
clear all;
close all;

realizaciones = 30;
mu = 1e-3;
w0 = [0 0]';
M = 2;

[audio, fs] = audioread('Pista_02.wav');
[N, filas] = size(audio);

%%% Prueba de armar_audio
%   [X,S,G,Y] = armar_audio2(audio, fs);
%   %Escuchamos que el audio tenga ruido
%   sound(X, fs);

J_est = zeros(N,1);
Err_est = zeros(N,1);
for i = 1:realizaciones
        [X,S,G,Y]  = armar_audio2(audio, fs);
        [W, G_est] = filtro_interferencia(X, Y, mu, w0);

        S_est = (X - G_est);
        Err_est = Err_est + (S_est - S).^2/realizaciones;
        J_est = J_est + (G_est - G).^2/realizaciones;
end

graf = figure;
plot(S_est)
hold on
title('Estimacion de S')
plot(S);
grid on
legend('S_est','S')
xlabel('n') 
ylabel('Nivel') 
axis([832000 833000 -0.1 0.1])
saveas(graf,'e_1.png')

graf = figure;
title('Coeficientes de W')
lgd = cell(M,1);
hold on
for i = 1:M
    plot(W(i,:))
    lgd{i} = strcat('w_',num2str(i-1));
end
grid on
legend(lgd);
xlabel('n') 
ylabel('W(n)') 
saveas(graf,'e_2.png')

graf = figure;
plot(Err_est)
grid on
title('Curva de Error (30 realizaciones)')
xlabel('n') 
ylabel('Err(n)') 
axis([0 1e4 0 9e-3])
saveas(graf,'e_3.png')

graf = figure;
plot(J_est)
grid on
title('Curva de aprendizaje J (30 realizaciones)')
xlabel('n') 
ylabel('J(n)') 
axis([0 1e4 0 9e-3])
saveas(graf,'e_4.png')

%%
% Escuchamos el audio con ruido
sound(X, fs);
%%
% Escuchamos el audio filtrado
sound(S_est, fs);
%%
% Escuchamos el audio original
sound(S, fs);
