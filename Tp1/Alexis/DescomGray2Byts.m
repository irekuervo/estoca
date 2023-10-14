%%%%% TP1 DescomposicionGray

function [BloqueGray, TamBloque] = DescomGray2Byts(Imagen)

%%% Obtengo las dimensiones de las matrices para crear las matrices con los 
%%% bloques transformados.

[fil,col] = size(Imagen);

%%% Creo los vectores vacios para llenarlos con la información de los
%%% bloques. Es importante notar que asumimos que las matrices tienen un
%%% número par de filas.

BloqueGray = zeros(2,fil*col/2);
TamBloque = [2,fil*col];

%%% Lleno los vectores con los bloques de datos. Recorro las matrices
%%% moviendo de a dos filas a la vez

for i = 1:fil/2
    aux1 = (i-1)*col+1;
    aux2 = i*col;
    BloqueGray(:,aux1:aux2) = Imagen(i*2-1:i*2,:);

end
