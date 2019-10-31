%Edgar Moises Hernandez Gonzalez
%Analisis de EEG para caracterizar la densidad del espectro de potencia y
%de diversos rangos de frecuencias
%Creado: 24/01/18
%Modificado: 02/03/18
%Calcula la Transformada Rapida de Fourier (FFT)

function mx=FFft(Fs,nfft,x)
    X=fft(x,nfft); %Rellenar con ceros, la longitud del resultado=nfft
    X=X(1:nfft/2); %Tomar la mitad de la FFT (Nyquist)
    mx=abs(X); %Magnitud de FFT
    f=(0:nfft/2-1)*Fs/nfft; %Vector Frecuencia
end