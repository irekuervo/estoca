%%%%%% TP1

function Resultado = SolucionRGB(ImagenRGB,i)
    [BloqueRGB,TamBloqueAumRGB4,FlagRGBCol,FlagRGBFil] = ...
        DescomRGB64Byts(ImagenRGB);
    [ProyecsionRGB, MatrProyecRGB] = Transformada(BloqueRGB,i/100);
    EspRGB = EsperanzaBloque(BloqueRGB);
    ReciboRGB = AntiTransformada(ProyecsionRGB,...
        MatrProyecRGB,EspRGB);
    SizeRGB = size(ImagenRGB);
    Resultado = RecompRGB64Byts(ReciboRGB,SizeRGB,...
        FlagRGBCol,FlagRGBFil);
