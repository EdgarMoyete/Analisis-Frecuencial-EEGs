%Edgar Moises Hernandez Gonzalez
%Analisis de EEG para caracterizar la densidad del espectro de potencia y
%de diversos rangos de frecuencias
%Creado: 24/01/18
%Modificado: 02/03/18
%Calcula los coeficientes Wavelet por medio de una descomposicion Wavelet
%multinivel en 1 dimension. Retorna el vector de coeficientes y el vector
%de registro

function [c,l]=FWavelet(x,nivel,wavelet)
    [c,l] = wavedec(x,nivel,wavelet); %Descomposicion Wavelet multinivel 1-D (DWT) usando el nivel y tipo de Wavelet especificados por el usuario
    cA = appcoef(c,l,wavelet,nivel); %Coeficientes de aproximacion dependiendo del nivel de descomposicion
    subplot(nivel+1,1,1);
    plot(cA);
    cadena=int2str(nivel);
    title(['Coeficientes de Aproximacion ',cadena]);
    grid on;
    % obtener y graficar los n coeficientes de detalle de la DWT.
    switch (nivel)
        case 2
            [cD1,cD2] = detcoef(c,l,[1 2]); %Coeficientes de detalle
            subplot(3,1,2);
            plot(cD2);
            title('Coeficietes de Detalle 2');
            grid on;
            subplot(3,1,3);
            plot(cD1);
            title('Coeficietes de Detalle 1');
            grid on;
        case 3
            [cD1,cD2,cD3] = detcoef(c,l,[1 2 3]); %Coeficientes de detalle
            subplot(4,1,2);
            plot(cD3);
            title('Coeficietes de Detalle 3');
            grid on;
            subplot(4,1,3);
            plot(cD2);
            title('Coeficietes de Detalle 2');
            grid on;
            subplot(4,1,4);
            plot(cD1);
            title('Coeficietes de Detalle 1');
            grid on;
        case 4 
            [cD1,cD2,cD3,cD4] = detcoef(c,l,[1 2 3 4]); %Coeficientes de detalle
            subplot(5,1,2);
            plot(cD4);
            title('Coeficietes de Detalle 4');
            grid on;
            subplot(5,1,3);
            plot(cD3);
            title('Coeficietes de Detalle 3');
            grid on;
            subplot(5,1,4);
            plot(cD2);
            title('Coeficietes de Detalle 2');
            grid on;
            subplot(5,1,5);
            plot(cD1);
            title('Coeficietes de Detalle 1');
            grid on;
        case 5
            [cD1,cD2,cD3,cD4,cD5] = detcoef(c,l,[1 2 3 4 5]); %Coeficientes de detalle
            subplot(6,1,2);
            plot(cD5);
            title('Coeficietes de Detalle 5');
            grid on;
            subplot(6,1,3);
            plot(cD4);
            title('Coeficietes de Detalle 4');
            grid on;
            subplot(6,1,4);
            plot(cD3);
            title('Coeficietes de Detalle 3');
            grid on;
            subplot(6,1,5);
            plot(cD2);
            title('Coeficietes de Detalle 2');
            grid on;
            subplot(6,1,6);
            plot(cD1);
            title('Coeficietes de Detalle 1');
            grid on;
        case 6
            [cD1,cD2,cD3,cD4,cD5,cD6] = detcoef(c,l,[1 2 3 4 5 6]); %Coeficientes de detalle
            subplot(7,1,1);
            plot(cD6);
            title('Coeficietes de Detalle 6');
            grid on;
            subplot(7,1,1);
            plot(cD5);
            title('Coeficietes de Detalle 5');
            grid on;
            subplot(7,1,1);
            plot(cD4);
            title('Coeficietes de Detalle 4');
            grid on;
            subplot(7,1,1);
            plot(cD3);
            title('Coeficietes de Detalle 3');
            grid on;
            subplot(7,1,1);
            plot(cD2);
            title('Coeficietes de Detalle 2');
            grid on;
            subplot(7,1,1);
            plot(cD1);
            title('Coeficietes de Detalle 1');
            grid on;
    end
end