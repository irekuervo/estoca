

%% Punto b)
clear all;
close all;
N = 20000;
fs = 44100;

[X,S,G,Y] = armar_seniales2(N,fs);

figure()
hold on
plot(Y(:,1));
plot(Y(:,2));
legend('sin()','cos()')
title('Y - Referencia')

figure()
plot(G);
title('G - Interferencia')

figure()
plot(S);
title('S - Señal')

figure()
plot(X);
title('X - Señal Total')

%% Punto c)
clear all;
close all;

N = 20000;
fs = 44100;

mu = 1e-3;
w0 = [0 0]'; % valores iniciales del filtro
[M,L] = size(w0);

realizaciones = 100;
J_est = zeros(N,1);
Err_est = zeros(N,1);

for i = 1:realizaciones
    
    [X,S,G,Y]  = armar_seniales2(N, fs);
    [W, G_est] = filtro_interferencia(X, Y, mu, w0);
 
    S_est = (X - G_est);
    Err_est = Err_est + (S_est - S).^2/realizaciones;
    J_est = J_est + (G_est - G).^2/realizaciones;
    
    % Para debuggear
    if i == 1
        figure()
        plot(G_est)
        hold on
        plot(G);
        legend('G_est','G')
        
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
title('Coeficientes de W')
lgd = cell(M,1);
hold on
for i = 1:M
    plot(W(i,:))
    lgd{i} = strcat('w_',num2str(i-1));
end
legend(lgd);

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

figure()
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

legend(lgd);

figure()
plot(MU, E);
title('Error vs MU')

%% e)
clear all;
close all;

realizaciones = 1;
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

figure()
plot(Err_est)
title('Err_est')
figure()
plot(J_est)
title('J_est')

figure()
title('Coeficientes de W')
lgd = cell(M,1);
hold on
for i = 1:M
    plot(W(i,:))
    lgd{i} = strcat('w_',num2str(i-1));
end
legend(lgd);

%%
% Escuchamos el audio con ruido
sound(X, fs);
%%
% Escuchamos el audio filtrado
sound(S_est, fs);
%%
% Escuchamos el audio original
sound(S, fs);
