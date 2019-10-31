%Edgar Moises Hernandez Gonzalez
%Analisis de EEG para caracterizar la densidad del espectro de potencia y
%de diversos rangos de frecuencias
%Creado: 13/02/18
%Modificado: 02/03/18
%Analisis de EEG con FFT, DWT y graficas de las bandas de frecuencia

function varargout = frmPrincipal(varargin)
% FRMPRINCIPAL MATLAB code for frmPrincipal.fig
% Last Modified by GUIDE v2.5 26-Feb-2018 17:23:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @frmPrincipal_OpeningFcn, ...
                   'gui_OutputFcn',  @frmPrincipal_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before frmPrincipal is made visible.
function frmPrincipal_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for frmPrincipal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%variables globales
global Fs;
Fs=0;
global canalSeleccionado;
canalSeleccionado=1;
global filtro;
filtro=0;

% --- Outputs from this function are returned to the command line.
function varargout = frmPrincipal_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;

%graficar el canal seleccionado
function cmbCanales_Callback(hObject, eventdata, handles)
global canales;
global canalSeleccionado;
global filtro;
if(canales~=0)
    datos=get(handles.cmbCanales,'String');
    indice=get(handles.cmbCanales,'Value');
    if (indice==1)
        errordlg('Seleccione una opción','Error');
    elseif(indice==2) %graficar todos los canales
        canalSeleccionado=2;
        FGraficar(canales,'EEG','Tiempo','Amplitud');
        legend('AF3','F7','F3','FC5','T7','P7','O1','O2','P8','T8','FC6','F4','F8','AF4');
    else %graficar el canal seleccionado
        canalSeleccionado=canales(:,indice-2);
        FGraficar(canalSeleccionado,datos(indice),'Tiempo','Amplitud');
        legend(datos(indice));
    end
    filtro=0;
else
    errordlg('No ha abierto ningun archivo','Error');
end

function cmbCanales_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Abre un archivo .csv y grafica el EEG, siempre y cuando se haya
%especificado la frecuencia de muestreo
function btnAbrir_Callback(hObject, eventdata, handles)
global canales;
global Fs;
if (Fs~=0)
    canales=FLeerCSV();
    if(canales~=0)
        FGraficar(canales,'EEG','Tiempo','Amplitud');
        legend('AF3','F7','F3','FC5','T7','P7','O1','O2','P8','T8','FC6','F4','F8','AF4');
    else
        errordlg('Debe seleccionar un archivo','Error');
    end
else
    errordlg('Debe ingresar la Frecuencia de Muestreo','Error');
end

%calcular Transformada Rapida de Fourier
function btnFFT_Callback(hObject, eventdata, handles)
global filtro
global Fs;
global fft;
if(filtro~=0)
    nfft=str2double(get(handles.txtNfft,'String'));
    if (nfft>0)
        fft=FFft(Fs,nfft,filtro);
        figure;
        subplot(2,1,1);
        FGraficar(filtro,'Señal Filtrada a 64Hz','Tiempo','Amplitud');
        subplot(2,1,2);
        FGraficar(fft,'FFT Espectro de potencia','Frecuencia','Potencia');
    else
        errordlg('Ingrese el tamaño de la DFT','Error');
    end
else
    errordlg('La señal debe estar filtrada','Error');
end

%Calcular Transformada Discreta Wavelet
function btnDWT_Callback(hObject, eventdata, handles)
global filtro;
global dwtC;
global dwtL;
if(filtro~=0)
    nivel=get(handles.cmbNivel,'Value');
    indice=get(handles.cmbWavelet,'Value');
    if(nivel>1 && indice>1)
        nombreWavelet=FNombreWavelet(indice);
        figure;
        [dwtC,dwtL]=FWavelet(filtro,nivel,nombreWavelet);
    else
        errordlg('Seleccione el nivel y el nombre de la Wavelet','Error');
    end
else
    errordlg('La señal debe estar filtrada','Error');
end

%Filtro pasa bajas
function btnFiltroPasaBajas_Callback(hObject, eventdata, handles)
global canales;
global canalSeleccionado;
global filtro;
if(canalSeleccionado~=1)
	Wp=str2double(get(handles.txtWp,'String')); %frecuencia en la banda de paso
	Ws=str2double(get(handles.txtWs,'String')); %frecuencia en la banda de rechazo
	Rp=str2double(get(handles.txtRp,'String')); %atenuación en la banda de paso
	Rs=str2double(get(handles.txtRs,'String')); %atenuación en la banda de rechazo
	if(~isempty(get(handles.txtWp,'String')) && Wp>0 && ~isempty(get(handles.txtWs,'String')) && Ws>0 && ~isempty(get(handles.txtRp,'String')) && Rp>0 && ~isempty(get(handles.txtRs,'String')) && Rs>0)
        datos=get(handles.cmbCanales,'String');
        indice=get(handles.cmbCanales,'Value');
        figure;
        if(indice==2) %filtrar todos los canales del EEG
            filtro=FFiltroPBajas(canales,Wp,Ws,Rp,Rs); %Pasa Bajas de 64Hz
            subplot(2,1,1);
            FGraficar(canales,'EEG','Tiempo','Amplitud');
            legend('AF3','F7','F3','FC5','T7','P7','O1','O2','P8','T8','FC6','F4','F8','AF4');
            subplot(2,1,2);
            FGraficar(filtro,'Señales Filtradas a 64Hz','Tiempo','Amplitud');
            legend('AF3','F7','F3','FC5','T7','P7','O1','O2','P8','T8','FC6','F4','F8','AF4');
        else %graficar el canal seleccionado
            filtro=FFiltroPBajas(canalSeleccionado,Wp,Ws,Rp,Rs); %Pasa Bajas de 64Hz
            FGraficar(canalSeleccionado,datos(indice),'Tiempo','Amplitud');
            hold on;
            FGraficar(filtro,'Señal Filtrada a 64Hz','Tiempo','Amplitud');
            legend(datos(indice),'Señal Filtrada');
        end
    else
        errordlg('Llene todos los parametros del filtro','Error');
    end
else
    errordlg('Seleccione lo que desea filtar','Error');
end

function txtFs_Callback(hObject, eventdata, handles)

function txtFs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%almacenar recuencia de muestreo
function btnFs_Callback(hObject, eventdata, handles)
global Fs;
valor=str2double(get(handles.txtFs,'String'));
if(~isempty(get(handles.txtFs,'String')) && valor>0)
    Fs=valor;
else
    errordlg('Debe ingresar la Frecuencia de Muestreo','Error');
end

function txtNfft_Callback(hObject, eventdata, handles)

function txtNfft_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtNivel_Callback(hObject, eventdata, handles)

function txtNivel_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cmbWavelet_Callback(hObject, eventdata, handles)

function cmbWavelet_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function menuArchivo_Callback(hObject, eventdata, handles)

function menuAyuda_Callback(hObject, eventdata, handles)

function menuInstrucciones_Callback(hObject, eventdata, handles)
msgbox('1.Definir frecuencia de muestreo y abrir archivo .CSV  2.Filtrar algun canal  3.Analizar la señal con la Transformada Rapida de Fourier o con la Transformada Discreta Wavelet  4.Ver las bandas de frecuencia  5.Guardar resultados','Guia rapida de usuario');

function menuAcerca_Callback(hObject, eventdata, handles)
helpdlg('Analisis Frecuencial de EEGs (2018) Programador: I.S.C.Edgar Moisés Hernández González, Asesora:Dra. María del Pilar Gómez Gil, Director Tecnico:Dr. Carlos Artuto Hernández Gracidas','Creditos');

%guarda un archivo .mat con los resultados
function menuGuarda_Callback(hObject, eventdata, handles)
global filtro;
global fft;
global dwtC;
global dwtL;
global delta;
global theta;
global alfa;
[archivo,ruta] = uiputfile('*.mat','Guardar Como');
cadena=strcat(ruta,archivo);
if(~isempty(cadena))
    save(cadena,'filtro','fft','dwtC','dwtL','delta','theta','alfa');
else
    errordlg('Debe especificar un nombre','Error');
end


function menuCer_Callback(hObject, eventdata, handles)
close(frmPrincipal);

function cmbNivel_Callback(hObject, eventdata, handles)

function cmbNivel_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%calcular ondas cerebrales delta, theta y alfa
function btnBandasHz_Callback(hObject, eventdata, handles)
global filtro;
global delta;
global theta;
global alfa;
if(filtro~=0) %si la señal ya esta filtrada
    indice=get(handles.cmbWavelet,'Value');
    if(indice>1) %si ya se selecciono el tipo de wavelet
        nombreWavelet=FNombreWavelet(indice);
        figure;
        [delta,theta,alfa]=FBandas(filtro,nombreWavelet);
    else
        errordlg('Seleccione alguna Wavelet','Error');
    end
else
    errordlg('La señal debe estar filtrada','Error');
end

function txtWp_Callback(hObject, eventdata, handles)

function txtWp_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtWs_Callback(hObject, eventdata, handles)

function txtWs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtRp_Callback(hObject, eventdata, handles)

function txtRp_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtRs_Callback(hObject, eventdata, handles)

function txtRs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Este ya no se ocupa
function btnMA_Callback(hObject, eventdata, handles)

function txtVentana_Callback(hObject, eventdata, handles)

function txtVentana_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
