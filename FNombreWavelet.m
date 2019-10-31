%Edgar Moises Hernandez Gonzalez
%Analisis de EEG para caracterizar la densidad del espectro de potencia y
%de diversos rangos de frecuencias
%Creado: 22/02/18
%Modificado: 02/03/18
%Obtiene el nombre de la Wavelet dependiendo del seleccionado en el combo

function nombreWavelet = FNombreWavelet(indice)
	switch (indice)
        case 2
            nombreWavelet='haar';
        case 3
            nombreWavelet='db1';
        case 4
            nombreWavelet='db2';
        case 5
            nombreWavelet='db3';
        case 6
            nombreWavelet='db4';
        case 7
            nombreWavelet='db5';
        case 8
            nombreWavelet='db6';
        case 9
            nombreWavelet='sym2';
        case 10
            nombreWavelet='sym3';
        case 11
            nombreWavelet='sym4';
        case 12
            nombreWavelet='sym5';
	end
end