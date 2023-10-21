
%% dim matrizCoef = PxN , dim vectorGanancias = dim vectorPitch Nx1 (columna)
function [audio] = reconstruccion(matrizCoef, vectorGanancias, vectorPitch, samplerate, tamanioVentana)

[p,n] = size(matrizCoef);
[n1,m1] = size(vectorGanancias);
[n2,m2] = size(vectorPitch);

if n ~= n1 || n ~= n2 || m1 ~= 1 || m2 ~= 1
    msgbox("Error de tamaños de vectores");
    return;
end

ventanas = zeros(tamanioVentana,n); 

%% por cada columna de la matriz matrizCoef:
for i = 1:n

    LPC = matrizCoef(:,i);
    pitch = vectorPitch(1, i);
    G = vectorGanancias(1, i);
    
    coefs_denominador = [1];
    coefs_denominador = [coefs_denominador -1*LPC'];
    
    entrada = [];
    
    esConsonante = pitch == 0;
    if(esConsonante)
        entrada = normrnd(0,1, tamanioVentana, 1);
    else
        entrada = trenImpulsos(samplerate, pitch, tamanioVentana);
    end
    
    ventana_reconstruida = filter(coefs_denominador, G, entrada);
    ventanas(:,i) = ventana_reconstruida;
end



end

