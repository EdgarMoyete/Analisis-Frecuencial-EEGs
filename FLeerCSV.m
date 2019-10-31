%Edgar Moises Hernandez Gonzalez
%Analisis de EEG para caracterizar la densidad del espectro de potencia y
%de diversos rangos de frecuencias
%Creado: 20/02/18
%Modificado: 02/03/18
%Lee un archivo csv, el archivo csv contiene un EEG tomado con la diadema
%Emotiv Epoc de 14 canales y cada canal contiene 1290 muestras

function canales = FLeerCSV()
    [archivo,ruta] = uigetfile('*.csv','Seleccione un archivo'); %regresa 2 cadenas la de la ruta del archivo y el nombre del archivo
    cadena=strcat(ruta,archivo); %concatenar las 2 cadenas
    if(~isempty(cadena)) %si la cadena no esta vacia
        canales=zeros(1290,14);
        for i=2:15
            canales(:,i-1)=csvread(cadena,1,i,[1 i 1290 i]); %i corresponde a las columnas del archivo osea que va leyendo canal por canal
        end
    else
        canales=0;
    end
end