function [AudioVentneado] = Segmentacion(VectorAudio,SizeVentana)

CantidadVentanas = (length(VectorAudio)/SizeVentana)*2-1;

if rem(CantidadVentanas,1)~= 0
    CantidadVentanas = floor(CantidadVentanas)+1;
    AudioVentneado =  zeros(SizeVentana,CantidadVentanas);
    j = (floor(length(VectorAudio)/SizeVentana)+1)*SizeVentana;
    VectorAudioCompletado = zeros(j,1);
    VectorAudioCompletado(1:length(VectorAudio)) = VectorAudio;
else
    AudioVentneado =  zeros(SizeVentana,CantidadVentanas);
    VectorAudioCompletado = VectorAudio;
end


for i = 1:CantidadVentanas
    AudioVentneado(:,i) = ...
        VectorAudioCompletado(SizeVentana/2*(i-1)+1:SizeVentana/2*(i+1));
end

    VentanaHamming = hamming(SizeVentana);

for i = 1:CantidadVentanas
    AudioVentneado(:,i) = VentanaHamming.*AudioVentneado(:,i);
end

end