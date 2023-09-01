close all;
clear all;


bloqueFil = 8;
bloqueCol = 8;
CR = 5;

cantAutovectores = cast(100*CR / (bloqueFil*bloqueCol) ,'int32');

img = cargarImg('img_01.jpg');
[filas,columnas] = size(img);

figure
imshow(cast(img,'uint8'))

X = convertirEnBloques(img, bloqueFil, bloqueCol);

Cx = covarianza(X);
ux = media(X);

[U,D,V] = svd(Cx);

U = V(:,1:cantAutovectores);

Y = U'*(X-ux);

Yx = U*Y + ux;


%% Pruebas

% Prueba de conversion de bloques: se debe poder reconstruir
imgReconstruida = convertirEnImagen(Yx, bloqueFil , bloqueCol, filas, columnas);

figure
imshow(cast(imgReconstruida,'uint8'))

%% Funciones

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
    img_gris = cast(img_gris,'double');
end