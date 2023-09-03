%%%%% TP1 DescomGray64Byts

function [BloqueGray, TamBloqueAum, ...
    FlagSizeInadeCol, ...
    FlagSizeInadeFil] = DescomGray64Byts(Imagen)

%%% Creamos las matrices que van a conteren los datos de los bloques en los
%%% que se va adividir la imagen. Como se vaa dividir la imagen en bloques
%%% de 8x8 vamos a completar con ceros los bloques que sobresalgan de las
%%% imagenes.

%%% Me creo unos flags que me indican si las columnas y/o las filas son
%%% multiplos de 8 o no. En funcion a estos flags establesco el size de la
%%% matriz Orden que contiene los bloques.

%%% Mini-Glosario para esta seccion%%%
% -"flag_size_inade_col" es 1 si hay que completar las colmunas de los 
% bloques con ceros y cero de lo contraria
% -"flag_size_inade_fil" es 1 si hay que completar las filas de los
% bloques con ceros y cero de lo contrario
% -"Tam_img_ampl" contien los valores de size (uso el ingles porque no puedo
% usar la n~) de la matriz imagen que tiene los bordes rellenos con ceos
% para poder completar los bloques.

[fil,col] = size(Imagen);

FlagSizeInadeCol = false;       % FlagSizeInadecuadoColumna
FlagSizeInadeFil = false;     % FlagSizeInadecuadoFila

if col/8-floor(col/8) ~= 0
    FlagSizeInadeCol = 1;
end
if fil/8-floor(fil/8) ~= 0
    FlagSizeInadeFil = 1;
end

%%% En funcion de los flags que tengo levantados, me creo las matrices que
%%% van a contener los datos en forma de vectores de 64x1 y ademas me creo
%%% una matriz de ceros con el size de la matriz expandida con 0 para
%%% facilitar el pasaje de datos.

if FlagSizeInadeCol == 0
    if FlagSizeInadeFil == 0
        BloqueGray = zeros(64,fil/8*col/8);
        NuevaImagen = zeros(fil,col);
        TamBloqueAum = [fil/8 col/8];
    else
        BloqueGray = zeros(64,floor(fil/8+1)*col/8);
        NuevImagen = zeros(floor(fil/8+1)*8,col);
        TamBloqueAum = [floor(fil/8+1) col/8];
    end
else
    if FlagSizeInadeFil == 0 
        BloqueGray = zeros(64,fil/8*floor(col/8+1));
        NuevImagen = zeros(fil,floor(col/8+1)*8);
        TamBloqueAum = [fil/8 floor(col/8+1)];
    else
        BloqueGray = zeros(64,floor(fil/8+1)*floor(col/8+1));
        NuevImagen = zeros(floor(fil/8+1)*8,floor(col/8+1)*8);
        TamBloqueAum = [floor(fil/8+1) floor(col/8+1)];
    end
end

FilAmpl = TamBloqueAum(1);
ColAmpl = TamBloqueAum(2);

%%% Hago el pasaje de datos a la matriz expandida con ceros

NuevImagen(1:fil,1:col) = Imagen;

%%% Formo los vectores de size 64x1 que forman los bloques 

for j = 1:FilAmpl
    for i = 1:ColAmpl
        for p = 1:8 
            aux1 = (p-1)*8+1;
            aux2 = i+(j-1)*ColAmpl;
            BloqueGray(aux1:p*8,aux2) = ....
                NuevImagen((j-1)*8+1:j*8,(i-1)*8+p);
        end %fin del primer if
    end %fin del for
end %fin del for



