%%%%% TP1 DescomRGB2Byts

function [BloqueRGB, TamBloque] = DescomRGB2Byts(Imagen)

[fil,col,prof] = size(Imagen);

BloqueRGB = zeros(2,fil*col*prof/2);
TamBloque = [2,fil*col*prof/2];

for k = 1:prof
    for i = 1:fil/2
        aux1 = (k-1)*col*fil/2+(i-1)*col+1;
        aux2 = (k-1)*col*fil/2+i*col;
        BloqueRGB(:,aux1:aux2) = Imagen(i*2-1:i*2,:,k);
    end
end

