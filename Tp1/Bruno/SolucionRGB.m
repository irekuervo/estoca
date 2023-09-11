%%%%%% TP1

function Resultado = SolucionRGB(ImagenRGB,i)

%%% En esta funcion lo que se hace es descomponer una imagen en bloques de
%%% 8x8, comprimir estos bloques ordenados quedandonos con un i% de la
%%% informacion, descomprimir la informacion  finalmente recomponer la
%%% imagen original con informacion faltante. Todo esto trabajando con la
%%% imagen en RGB

    [BloqueRGB,TamBloqueAumRGB4,FlagRGBCol,FlagRGBFil] = ...
        DescomRGB64Byts(ImagenRGB);
    [ProyecsionRGB, MatrProyecRGB] = Transformada(BloqueRGB,i/100);
    EspRGB = EsperanzaBloque(BloqueRGB);
    ReciboRGB = AntiTransformada(ProyecsionRGB,...
        MatrProyecRGB,EspRGB);
    SizeRGB = size(ImagenRGB);
    Resultado = RecompRGB64Byts(ReciboRGB,SizeRGB,...
        FlagRGBCol,FlagRGBFil);
