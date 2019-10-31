%Edgar Moises Hernandez Gonzalez
%Analisis de EEG para caracterizar la densidad del espectro de potencia y
%de diversos rangos de frecuencias
%Creado: 07/02/18
%Modificado: 02/03/18
%Filtro IIR pasa bajas Chevyshev de 2 orden

function [filtro] = FFiltroPBajas(senal, Wp, Ws, Rp, Rs)
    [nx,Wnx]=cheb2ord(Wp,Ws,Rp,Rs);
    [b,a]=cheby2(nx,Rs,Wnx,'low');
    filtro = filtfilt(b, a, senal);
end