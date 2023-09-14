%%%%%% TP1 SolucionGray

function Resultado = SolucionGray(ImagenGray,i)

[BloqueGray,TamBloqueAumGray,FlagGrayCol,FlagGrayFil] = ...
    DescomGray64Byts(ImagenGray);
[ProyecsionGray, MatrProyecGray] = Transformada(BloqueGray,i/100);
EspGray = EsperanzaBloque(BloqueGray);
ReciboGray = AntiTransformada(ProyecsionGray,...
    MatrProyecGray,EspGray);
SizeGray = size(ImagenGray);
Resultado = RecompGray64Byts(ReciboGray,SizeGray,...
    FlagGrayCol,FlagGrayFil);
