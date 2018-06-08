function varargout = gui3(varargin)
% GUI3 MATLAB code for gui3.fig
%      GUI3, by itself, creates a new GUI3 or raises the existing
%      singleton*.
%
%      H = GUI3 returns the handle to a new GUI3 or the handle to
%      the existing singleton*.
%
%      GUI3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI3.M with the given input arguments.
%
%      GUI3('Property','Value',...) creates a new GUI3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui3

% Last Modified by GUIDE v2.5 07-Jun-2018 17:22:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui3_OpeningFcn, ...
                   'gui_OutputFcn',  @gui3_OutputFcn, ...
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


% --- Executes just before gui3 is made visible.
function gui3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui3 (see VARARGIN)

% Choose default command line output for gui3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq();
maingui();

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ButtonName = questdlg({'For training, a folder containing annotated images',...
                       'must have been created, as instructed in ReadMe.txt.',...
                       'Navigate to such folder?'}, ...
                       'Sanity check...', ...
                       'Ok', 'Cancel', 'Ok');
dirPath = uigetdir;
if dirPath ~= 0
    [imageList,labelList,classIndices] = parseLabelFolder(dirPath);
    rfModel = mlrfsTrain(imageList,labelList,classIndices);
    ButtonName = questdlg({'Would you like to save the trained model for',...
                           'later usage? (It will be saved as rfModel.mat',...
                           'in the same folder as the labeled images.)'},...
                           'Save model...', ...
                           'Yes', 'No', 'Yes');
    if strcmp(ButtonName,'Yes')
        modelPath = [dirPath filesep 'rfModel.mat'];
        fprintf('Saving model at\n%s\n', modelPath);
        save(modelPath,'rfModel');
        disp('Done.')
    end
end
