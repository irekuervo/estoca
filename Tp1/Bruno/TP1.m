%%%%% TP1 Grupo 8

%%% El primer paso para trabajar es descargar las imagenes, que estan en la 
%%% carpeta, al programa e inmedianamente transformar el tipo de dato de 
%%% unite8 a double.
ImagenRGB1 = double(imread('img_01.jpg'));
ImagenGray1 = double(rgb2gray(imread('img_01.jpg')));
ImagenRGB2 = double(imread('img_02.jpg'));
ImagenGray2 = double(rgb2gray(imread('img_02.jpg')));
ImagenRGB3 = double(imread('img_03.jpg'));
ImagenGray3 = double(rgb2gray(imread('img_03.jpg')));
ImagenRGB4 = double(imread('img_04.jpg'));
ImagenGray4 = double(rgb2gray(imread('img_04.jpg')));

%%
%%%%%% Ejercicio 1: Correlación

%%% Aplico las funciones a las imagenes para obtener los bloques ordenados
%%% de las Imagenes

[BloqueGray1,TamGray1] = DescomGray2Byts(ImagenGray1);
[BloqueRGB1,TamRGB1] = DescomRGB2Byts(ImagenRGB1);

[BloqueGray2,TamGray2] = DescomGray2Byts(ImagenGray2);
[BloqueRGB2,TamRGB2] = DescomRGB2Byts(ImagenRGB2);

%%% Genero los graficos de disperion de los vectores que contienen los
%%% bloues de datos.

figure()
plot(BloqueGray1(1,:),BloqueGray1(2,:),'o')
title('Grafico de dispercion de la Imagen 1 en grises')
hold on;
grid on;
axis([0 256 0 256])

figure()
plot(BloqueRGB1(1,:),BloqueRGB1(2,:),'o')
title('Grafico de dispercion de la Imagen 1 en RGB')
hold on;
grid on;
axis([0 256 0 256])

figure()
plot(BloqueGray2(1,:),BloqueGray2(2,:),'o')
title('Grafico de dispercion de la Imagen 2 en grises')
hold on;
grid on;
axis([0 256 0 256])

figure()
plot(BloqueRGB2(1,:),BloqueRGB2(2,:),'o')
title('Grafico de dispercion de la Imagen 2 en RGB')
hold on;
grid on;
axis([0 256 0 256])

%%% Calculo los coeficiontes de correlacion de los vectores de dos
%%% coordenadas.

CorrGray1 = corrcoef(BloqueGray1(1,:),BloqueGray1(2,:));
CorrGray2 = corrcoef(BloqueGray2(1,:),BloqueGray2(2,:));
CorrRGB1 = corrcoef(BloqueRGB1(1,:),BloqueRGB1(2,:));
CorrRGB2 = corrcoef(BloqueRGB2(1,:),BloqueRGB2(2,:));

%%
%%%%%% Ejercicio 2 y 3

%%% Lo primero que hago para procesar las imagenes es generar las matrices
%%% que contienen los bloques ordenados tanto para la imagen en grises como
%%% para la RGB

[BloqueGray3,TamBloqueAumGray3,FlagGray3Col,FlagGray3Fil] = ...
    DescomGray64Byts(ImagenGray3);
[BloqueRGB3,TamBloqueAumRGB3,FlagRGB3Col,FlagRGB3Fil] = ...
    DescomRGB64Byts(ImagenRGB3);

%%% Luego calculo la esperanza y la covarianza del bloque

EspGray3 = EsperanzaBloque(BloqueGray3);
CovGray3 = CovBloque(BloqueGray3);
EspRGB3 = EsperanzaBloque(BloqueRGB3);
CovRGB3 = CovBloque(BloqueRGB3);

%%% Ahora transformo los bloques ordenados utilizando solo el 20% de los
%%% autovalores y obtengo los bloques transformados y la matriz de
%%% transformacion

[ProyecsionGray3, MatrProyecGray3] = Transformada(BloqueGray3,0.2);
[ProyecsionRGB3, MatrProyecRGB3] = Transformada(BloqueRGB3,0.2);

%%% Antitransformo para obtener los bloques ordenados deformados por la
%%% falta de informacion al transformar sin algunos atuovectores.

ReciboGray3 = AntiTransformada(ProyecsionGray3,...
    MatrProyecGray3,EspGray3);
ReciboRGB3 = AntiTransformada(ProyecsionRGB3,...
    MatrProyecRGB3,EspRGB3);

SizeGray3 = size(ImagenGray3);
SizeRGB3 = size(ImagenRGB3);

%%% Recompongo la imagen a partir de los bloques ordenados reconstruidos
%%% obteniendo una imagen con las dimenciones originales.

FinalGray3 = RecompGray64Byts(ReciboGray3,SizeGray3,...
    FlagGray3Col,FlagGray3Fil);

FinalRGB3 = RecompRGB64Byts(ReciboRGB3,SizeRGB3,...
    FlagRGB3Col,FlagRGB3Fil);


ElementosRGB = length(EspRGB3)+8*8+64*TamBloqueAumRGB3(1)*...
    TamBloqueAumRGB3(2)*3;
ElementosGris = length(EspGray3)+8*8+64*TamBloqueAumGray3(1)*...
    TamBloqueAumGray3(2);

%%
%%% Grafico las imagenes originales junto con las imagenes que fueron
%%% comprimidas con un CP = 20%

figure
imshow(uint8(ImagenGray3))
title('Imagen 3 en escala de grises original')
figure
imshow(uint8(FinalGray3))
title('Imagen 3 en escala de grises procesada con PC = 20%')
figure
imshow(uint8(ImagenRGB3))
title('Imagen 3 en RGB original')
figure
imshow(uint8(FinalRGB3))
title('Imagen 3 en RGB procesada con PC = 20%')

%%
%%%%%% Ejercicio 4

EMSGray4 = zeros(19,1);
EMSRGB4 = zeros(19,1);

for i = 1:19

    FinalGray4 = SolucionGray(ImagenGray4,i*5);
    FinalRGB4 = SolucionRGB(ImagenRGB4,i*5);
    
    EMSGray4(i) = CalculoMSE(ImagenGray4, FinalGray4);
    EMSRGB4(i) = CalculoMSE(ImagenRGB4, FinalRGB4);
end

%%
figure
plot((1:19)*5, EMSGray4)
hold on
grid on
figure
plot((1:19)*5, EMSRGB4)
hold on
grid on

%%

for i = 1:5

    FinalGray4 = SolucionGray(ImagenGray4,i*5);
    FinalRGB4 = SolucionRGB(ImagenRGB4,i*5);
    
    figure
    imshow(uint8(FinalGray4))
    title(['Imagen 4 en RGB procesada con PC = ',num2str(i*5),'%'])
    figure
    imshow(uint8(FinalRGB4))
    title(['Imagen 4 en escala de grises procesada con PC = ' ... 
        ,num2str(i*5),'%'])
end
