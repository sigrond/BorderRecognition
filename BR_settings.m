function varargout = BR_settings(varargin)
% BR_SETTINGS MATLAB code for BR_settings.fig
%      BR_SETTINGS, by itself, creates a new BR_SETTINGS or raises the existing
%      singleton*.
%
%      H = BR_SETTINGS returns the handle to a new BR_SETTINGS or the handle to
%      the existing singleton*.
%
%      BR_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BR_SETTINGS.M with the given input arguments.
%
%      BR_SETTINGS('Property','Value',...) creates a new BR_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BR_settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BR_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BR_settings

% Last Modified by GUIDE v2.5 09-Feb-2017 13:58:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BR_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @BR_settings_OutputFcn, ...
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


% --- Executes just before BR_settings is made visible.
function BR_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BR_settings (see VARARGIN)

% Choose default command line output for BR_settings
handles.output = hObject;

handles.BP=1;
handles.Op=1;
load('BR_settings.mat');
handles.BP=BP;
switch BP
    case 1
        set(handles.radiobutton1,'Value',1);
    case 2
        set(handles.radiobutton2,'Value',1);
end
handles.Op=Op;
switch Op
    case 1
        set(handles.radiobutton3,'Value',1);
    case 2
        set(handles.radiobutton4,'Value',1);
    case 3
        set(handles.radiobutton5,'Value',1);
end
        

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BR_settings wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BR_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BP=handles.BP;
Op=handles.Op;
save('BR_settings.mat','BP','Op');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('BR_settings.mat');
handles.BP=BP;
handles.Op=Op;
handles.BP=BP;
switch BP
    case 1
        set(handles.radiobutton1,'Value',1);
    case 2
        set(handles.radiobutton2,'Value',1);
end
switch Op
    case 1
        set(handles.radiobutton3,'Value',1);
    case 2
        set(handles.radiobutton4,'Value',1);
    case 3
        set(handles.radiobutton5,'Value',1);
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

handles.BP=1;
guidata(hObject, handles);


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

handles.BP=2;
guidata(hObject, handles);


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
handles.Op=1;
guidata(hObject, handles);


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
handles.Op=2;
guidata(hObject, handles);


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
handles.Op=3;
guidata(hObject, handles);
