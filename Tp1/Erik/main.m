close all;
clear all;

bloqueFil = 8; % 1, 2, 4, 5, 8, 10, 16, 20, 25, 40, 50, 80, 100, 200, 400
bloqueCol = 8; % 1, 2, 4, 8, 71, 142, 284, 568

img = cast(cargarImg('img_01.jpg'),'uint8');

figure
imshow(img)

[ux,Yx,U,f,c] = comprimir(img,bloqueFil, bloqueCol, 2);

imgDescomprimida = descomprimir(ux,Yx,U,bloqueFil,bloqueCol,f,c);

figure
imshow(imgDescomprimida)

%% Funciones

function [ux,Yx,U,f,c] = comprimir(img, bloqueFil, bloqueCol, cr)
    [filas,columnas] = size(img);
    f = filas;
    c = columnas;
    X = convertirEnBloques(img, bloqueFil, bloqueCol);
    Cx = covarianza(X);
    ux = media(X);
    [U,D,V] = svd(Cx);
   
    % Reduzco las dimensiones
    U = V(:,1:cr);
    % Proyecto en la base reducida sin la media
    Yx = U'*(X-ux);
end

function imgReconstruida = descomprimir(ux, Yx, U, bloqueFil, bloqueCol,filasImg,columnasImg)
    X = U*Yx + ux;
    imgReconstruida = convertirEnImagen(X, bloqueFil , bloqueCol, filasImg, columnasImg);
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
        msgbox("Tama�o de bloque invalido","Error","error");
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
    img_gris = cast(img_gris,'double');
end