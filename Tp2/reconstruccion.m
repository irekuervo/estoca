
%% dim matrizCoef = PxN , dim vectorGanancias = dim vectorPitch Nx1 (columna)
function [audio] = reconstruccion(matrizCoef, vectorGanancias, vectorPitch, samplerate, tamanioVentana)

[n,p] = size(matrizCoef);
[n1,m1] = size(vectorGanancias);
[n2,m2] = size(vectorPitch);

if n ~= n1 || n ~= n2 || m1 ~= 1 || m2 ~= 1
    msgbox("Error de tamaños de vectores");
    return;
end

%% por cada fila de la matriz matrizCoef:


for i = 1:n

    LPC = matrizCoef(i);
    pitch = vectorPitch(i);
    G = vectorGanancias(G);
    
    coefs_denominador = [1];
    coefs_denominador = [coefs_denominador -1*LPC'];
    
    entrada = [];
    
    esConsonante = pitch == 0;
    if(esConsonante)
        entrada = normrnd(0,1,tamanioVentana);
    else
        entrada = trenImpulsos(samplerate, pitch);
    end
    
    s_reconstruido = filter(coefs_denominador, G, entrada);
    


%%  -si el f_pitch es > 0 es vocal, sino es consonante
%%  -si es vocal armo el filtro con un tren de impulsos f_pitch y samplerate
%%  -si es con armo el filtro con una entrada blanca
%% -resegmento los pedacitos
    
end


end

