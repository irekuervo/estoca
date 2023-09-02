%%%%% TP1 RecompGray64Byts

function [Result] = RecompGray64Byts(BloqueGray, TamImag, ...
    FlagSizeInadeCol, FlagSizeInadeFil)

Result = zeros(TamImag);

fil = TamImag(1);
col = TamImag(2);  

if FlagSizeInadeCol == 0
    if FlagSizeInadeFil == 0
        NuevaImagen = zeros(fil, col);
        TamBloqueAum = [fil/8 col/8];
    else
        NuevImagen = zeros(fil, floor(col/8+1)*8);
        TamBloqueAum = [fil/8 floor(col/8+1)];
    end
else
    if FlagSizeInadeFil == 0 
        NuevImagen = zeros(floor(fil/8+1)*8, col);
        TamBloqueAum = [floor(fil/8+1) col/8];
    else
        NuevImagen = zeros(floor(fil/8+1)*8, floor(col/8+1)*8);
        TamBloqueAum = [floor(fil/8+1) floor(col/8+1)];
    end
end

FilAmpl = TamBloqueAum(1);
ColAmpl = TamBloqueAum(2);

for j = 1:FilAmpl
    for i = 1:ColAmpl
        for p = 1:8
            aux1 = (p-1)*8+1;
            aux2 = i+(j-1)*ColAmpl;
            NuevImagen((j-1)*8+1:j*8,(i-1)*8+p) = ...
                BloqueGray(aux1:p*8,aux2);
        end
    end
end

Result = NuevImagen(1:fil,1:col);

