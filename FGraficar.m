%Edgar Moises Hernandez Gonzalez
%Analisis de EEG para caracterizar la densidad del espectro de potencia y
%de diversos rangos de frecuencias
%Creado: 24/01/18
%Modificado: 02/03/18
%Graficar

function FGraficar(x,titulo,lblX,lblY)
    plot(x);
    title(titulo);
    xlabel(lblX);
    ylabel(lblY);
    grid on;
end