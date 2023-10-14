%%%%%% TP1 SolucionGray

function Resultado = SolucionGray(ImagenGray,i)

%%% En esta función lo que se hace es descomponer una imagen en bloques de
%%% 8x8, comprimir estos bloques ordenados quedandonos con un i% de la
%%% información, descomprimir la informacion  finalmente recomponer la
%%% imagen original con información faltante. Todo esto trabajando con la
%%% imagen en escala de grises

[BloqueGray,TamBloqueAumGray,FlagGrayCol,FlagGrayFil] = ...
    DescomGray64Byts(ImagenGray);
[ProyecsionGray, MatrProyecGray] = Transformada(BloqueGray,i/100);
EspGray = EsperanzaBloque(BloqueGray);
ReciboGray = AntiTransformada(ProyecsionGray,...
    MatrProyecGray,EspGray);
SizeGray = size(ImagenGray);
Resultado = RecompGray64Byts(ReciboGray,SizeGray,...
    FlagGrayCol,FlagGrayFil);
