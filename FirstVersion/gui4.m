function varargout = gui4(varargin)
% GUI4 MATLAB code for gui4.fig
%      GUI4, by itself, creates a new GUI4 or raises the existing
%      singleton*.
%
%      H = GUI4 returns the handle to a new GUI4 or the handle to
%      the existing singleton*.
%
%      GUI4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI4.M with the given input arguments.
%
%      GUI4('Property','Value',...) creates a new GUI4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui4

% Last Modified by GUIDE v2.5 07-Jun-2018 17:59:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui4_OpeningFcn, ...
                   'gui_OutputFcn',  @gui4_OutputFcn, ...
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


% --- Executes just before gui4 is made visible.
function gui4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui4 (see VARARGIN)

% Choose default command line output for gui4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui4_OutputFcn(hObject, eventdata, handles) 
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

maingui();

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

PCBMD = pcbModelDialog;
doClassify = false;
if PCBMD.ModelID == 2
    [filename, pathname] = uigetfile({'*.mat','Model (.mat)'});
    if filename ~= 0
        disp('Loading model.')
        load([pathname filename])
        disp('Done.')
        doClassify = true;
    end
    elseif PCBMD.ModelID == 1
        if exist('rfModel','var')
            doClassify = true;
        else
            uiwait(errordlg('There is no model in memory. Either load a model or train a new one.', 'Oops'));
        end
end
clear PCBMD
if doClassify
    uiwait(msgbox('Next, navigate to folder containing images to classify.','Classify','modal'));
    dirPath = uigetdir;
    if dirPath ~= 0
        classifyImagesInFolder(dirPath,rfModel);
    end
end