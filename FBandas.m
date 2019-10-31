%Edgar Moises Hernandez Gonzalez
%Analisis de EEG para caracterizar la densidad del espectro de potencia y
%de diversos rangos de frecuencias
%Creado: 22/02/18
%Modificado: 02/03/18
%Obtiene las bandas delta(0Hz-4Hz), theta(4Hz-8Hz) y alfa(8Hz-12Hz) por
%medio de la DWT de 4 niveles usando la Wavelet que el usuario desee

function [delta,theta,alfa]=FBandas(x,wavelet)
	%Descomposicion Wavelet multinivel 1-D (DWT) en 4 niveles
    [c,l] = wavedec(x,4,wavelet);
    %Coeficiente de detalle 3 (8Hz-16Hz), de aqui sacar alfa
    cD3=detcoef(c,l,3);
    % Transformada Wavelet Discreta (DWT) 1-D de un solo nivel a cD3 para obtener alfa
    [cA,cD]=dwt(cD3,wavelet); %Descomposicion 1-D (cA=alfa)
    delta=appcoef(c,l,wavelet,4); %Coeficiente de aproximacion 4(0Hz-4Hz)
    theta=detcoef(c,l,4); %Coeficiente de detalle 4(4Hz-8Hz)
    alfa=cA; %8Hz-12Hz
    %Graficar la señal filtrada a analizar
    subplot(2,2,1);
    FGraficar(x,'Señal Filtrada a 64Hz','','');
    %Graficar las bandas de frecuencia
    subplot(2,2,2);
    FGraficar(delta,'Delta 0Hz-4Hz','','');
    subplot(2,2,3);
    FGraficar(theta,'Theta 4Hz-8Hz','','');
    subplot(2,2,4);
    FGraficar(alfa,'Alfa 8Hz-12Hz','','');
end