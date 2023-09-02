%%%%% TP1

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

figure()
plot(BloqueRGB1(1,:),BloqueRGB1(2,:),'o')
title('Grafico de dispercion de la Imagen 1 en RGB')

figure()
plot(BloqueGray2(1,:),BloqueGray2(2,:),'o')
title('Grafico de dispercion de la Imagen 2 en grises')

figure()
plot(BloqueRGB2(1,:),BloqueRGB2(2,:),'o')
title('Grafico de dispercion de la Imagen 2 en RGB')

%%% Calculo los coeficiontes de correlacion de los vectores de dos
%%% coordenadas.

CorrGray1 = corrcoef(BloqueGray1(1,:),BloqueGray1(2,:));
CorrGray2 = corrcoef(BloqueGray2(1,:),BloqueGray2(2,:));
CorrRGB1 = corrcoef(BloqueRGB1(1,:),BloqueRGB1(2,:));
CorrRGB2 = corrcoef(BloqueRGB2(1,:),BloqueRGB2(2,:));

%%
%%%%%% Ejercicio 2 y 3

[BloqueGray3,TamBloqueAumGray3,FlagGray3Col,FlagGray3Fil] = ...
    DescomGray64Byts(ImagenGray3);
[BloqueRGB3,TamBloqueAumRGB3,FlagRGB3Col,FlagRGB3Fil] = ...
    DescomRGB64Byts(ImagenRGB3);

EspGray3 = EsperanzaBloque(BloqueGray3);
CovGray3 = CovBloque(BloqueGray3);
EspRGB3 = EsperanzaBloque(BloqueRGB3);
CovRGB3 = CovBloque(BloqueRGB3);


[ProyecsionGray3, MatrProyecGray3] = Transformada(BloqueGray3,0.1);
[ProyecsionRGB3, MatrProyecRGB3] = Transformada(BloqueRGB3,0.1);

ReciboGray3 = AntiTransformada(ProyecsionGray3,...
    MatrProyecGray3,EspGray3);
ReciboRGB3 = AntiTransformada(ProyecsionRGB3,...
    MatrProyecRGB3,EspRGB3);

SizeGray3 = size(ImagenGray3);
SizeRGB3 = size(ImagenRGB3);

FinalGray3 = RecompGray64Byts(ReciboGray3,SizeGray3,...
    FlagGray3Col,FlagGray3Fil);

FinalRGB3 = RecompRGB64Byts(ReciboRGB3,SizeRGB3,...
    FlagRGB3Col,FlagRGB3Fil);

%%

figure
imshow(uint8(ImagenGray3))
figure
imshow(uint8(FinalGray3))
figure
imshow(uint8(ImagenRGB3))
figure
imshow(uint8(FinalRGB3))

%%

