close all;
clear all;

%% Ejercicio 4-a

img = cargarImg('img_04.jpg');
imwrite(img,'img4.png');
% Cada uno tiene que ser multiplo del las dimensiones de la imagen
bloqueFil = 14; 
bloqueCol = 14; 

mse = [];
crDesde = 5;
crHasta = 95;
paso = 5;

for cr = crDesde:paso:crHasta
    [ux,Yx, U, f, c] = comprimir(img, bloqueFil, bloqueCol, cr/100);
    imgDescomprimida = descomprimir(ux, Yx, U, bloqueFil, bloqueCol, f, c);
    mse = [mse, errorCuadraticoMedio(img, imgDescomprimida)];
end

cr = linspace(crDesde, crHasta, crHasta/paso);

figure
a=plot(cr, mse);
title('Variacion del MSE segun el CR para la imagen4')
xlabel('CR') 
ylabel('MSE') 
saveas(a,"mse.png");
%% Ejercicio 4-b

figure
imshow(img)

bloqueFil = 14; 
bloqueCol = 14; 

for cr = 5:5:25
    [ux,Yx, U, f, c] = comprimir(img, bloqueFil, bloqueCol, cr/100);
    imgDescomprimida = descomprimir(ux, Yx, U, bloqueFil, bloqueCol, f, c);
    figure
    imshow(imgDescomprimida)
    filename = sprintf('cr_%u.png',cr);
    imwrite(imgDescomprimida,filename);
end

bloqueFil = 32; 
bloqueCol = 23; 

for cr = 5:5:25
    [ux,Yx, U, f, c] = comprimir(img, bloqueFil, bloqueCol, cr/100);
    imgDescomprimida = descomprimir(ux, Yx, U, bloqueFil, bloqueCol, f, c);
    figure
    imshow(imgDescomprimida)
    filename = sprintf('cr2_%u.png',cr);
    imwrite(imgDescomprimida,filename);
end

%% Tasa de compresion vs Tamanio Bloque

size=f*c;
b= bloqueFil*bloqueCol;
k = 0:b/100:b;
cr = 0:0.01:1;
[K,CR] = meshgrid(k,cr);
F = (K-((size.*CR-K-4)./(size./K+K)))/b * 100;
figure
a = surf(K,CR,F)
title('Tasa de compresion vs Tamanio Bloque')
xlabel('Tamanio Bloque'), ylabel('CR'), zlabel('Reduccion % de Dimensiones')
saveas(a,"dimensiones.png")

%% Funciones

function mse = errorCuadraticoMedio(imgX,imgY)
    imgX = cast(imgX,'uint32');
    imgY = cast(imgY,'uint32');
    
    mse = 0;
    [filas,columnas] = size(imgX);
    for i = 1:1:filas
        for j = 1:1:columnas
            mse = mse + (imgX(i,j)-imgY(i,j))^2;
        end
    end
    mse = mse / (filas*columnas);
end

function [ux,Yx,U,f,c] = comprimir(img, bloqueFil, bloqueCol, cr)
    [filas,columnas] = size(img);
    f = filas;
    c = columnas;
    X = convertirEnBloques(img, bloqueFil, bloqueCol);
    Cx = covarianza(X);
    ux = media(X);
    [U,D,V] = svd(Cx);
    
    % Reduzco las dimensiones
    lambda = cantidadAutovectores(bloqueFil,bloqueCol,filas,columnas,cr);
    U = V(:,1:lambda);
    % Proyecto en la base reducida restando la media
    Yx = U'*(X-ux);
end

function lambda = cantidadAutovectores(bloqueFil, bloqueCol, filas, columnas, cr)
    k = bloqueFil*bloqueCol;
    d = filas*columnas;
    l = k - (d*cr-k-4)/(d/k + k);
    lambda = int32(round(k - l));
end

function imgReconstruida = descomprimir(ux, Yx, U, bloqueFil, bloqueCol, filasImg, columnasImg)
    % Vuelva al espacio original haciendo la inversa y sumando la media
    X = U*Yx + ux;
    % Paso de vectores a la imagen
    imgReconstruida = convertirEnImagen(X, bloqueFil , bloqueCol, filasImg, columnasImg);
    % Casteo para poder tener una escala de grises de 1byte
    imgReconstruida = cast(imgReconstruida,'uint8');
end

function img = convertirEnImagen(X, bloqueFil, bloqueCol, imgFil, imgCol)
    
    img = zeros(imgFil,imgCol);
    indice = 1;
    
    for i = 1:bloqueFil:(imgFil-bloqueFil+1)
        for j = 1:bloqueCol:(imgCol-bloqueCol+1)
            indiceFila = (i+bloqueFil-1);
            indiceCol = (j+bloqueCol-1);
            xi = X(:,indice);
            bloque = reshape(xi,[bloqueFil,bloqueCol]);
            img(i:indiceFila,j:indiceCol) = bloque;
            indice = indice+1;
        end
    end
end

function X = convertirEnBloques(img, bloqueFil, bloqueCol)
    [filas,columnas] = size(img);
    if mod(filas,bloqueFil) ~= 0 || mod(columnas,bloqueCol)
        msgbox("Tamaño de bloque invalido","Error","error");
        return;
    end
    
    filasX = bloqueFil*bloqueCol;
    L = (filas*columnas)/filasX;
    X = zeros(filasX,L);
    indice = 1;
    for i = 1:bloqueFil:(filas-bloqueFil+1)
        for j = 1:bloqueCol:(columnas-bloqueCol+1)
            indiceFila = (i+bloqueFil-1);
            indiceCol = (j+bloqueCol-1);
            bloque = img(i:indiceFila,j:indiceCol);
            xi = reshape(bloque,[filasX,1]);
            X(:,indice) = xi;
            indice = indice+1;
        end
    end
    
    if indice-1 ~= L
        msgbox("Algo salio mal");
        return;
    end
end

function E = media(X)
    [filas,L] = size(X);
    E = zeros(filas,1);
    for i = 1:L
        E = E + X(:,i);
    end
    E = E/L;
end

function Cx = covarianza(X)
    [filas,L] = size(X);
    ux = media(X);
    Cx = zeros(filas,filas);
    for i = 1:L
        aux = (X(:,i)-ux);
        Cx = Cx + aux*aux';
    end
    Cx = Cx/(L-1);
end

function img_gris = cargarImg(nombreArchivo)
    img_color = imread(nombreArchivo);
    %image(img_color)
    img_gris = rgb2gray(img_color);
    %imshow(img_gris)
    img_gris = cast(img_gris,'uint8');
end