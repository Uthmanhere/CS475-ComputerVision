function varargout = panoramaClassicGUI(varargin)
% PANORAMACLASSICGUI MATLAB code for panoramaClassicGUI.fig
%      PANORAMACLASSICGUI, by itself, creates a new PANORAMACLASSICGUI or raises the existing
%      singleton*.
%
%      H = PANORAMACLASSICGUI returns the handle to a new PANORAMACLASSICGUI or the handle to
%      the existing singleton*.
%
%      PANORAMACLASSICGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PANORAMACLASSICGUI.M with the given input arguments.
%
%      PANORAMACLASSICGUI('Property','Value',...) creates a new PANORAMACLASSICGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before panoramaClassicGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to panoramaClassicGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help panoramaClassicGUI

% Last Modified by GUIDE v2.5 14-Oct-2019 02:01:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @panoramaClassicGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @panoramaClassicGUI_OutputFcn, ...
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


% --- Executes just before panoramaClassicGUI is made visible.
function panoramaClassicGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to panoramaClassicGUI (see VARARGIN)

% Choose default command line output for panoramaClassicGUI
    
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes panoramaClassicGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = panoramaClassicGUI_OutputFcn(hObject, eventdata, handles) 
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
global im_a;
[File_Name, Path_Name] = uigetfile('*.png');
im_a = imread([Path_Name, File_Name]);
subplot(3,2,1);
imshow(uint8(im_a));


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_b;
[File_Name, Path_Name] = uigetfile('*.png');
im_b = imread([Path_Name, File_Name]);
subplot(3,2,2);
imshow(im_b);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global H_ab
global H_ba

global im_a
global im_b

[H_ab, H_ba] = calibratePanorama(im_a, im_b);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global H_ab
global H_ba
global im_a
global im_b

global im_ab
global im_ba
[ im_ba, im_ab ] = classicPanorama(im_a, im_b, H_ab, H_ba);
subplot(3,2,[5 6]);
imshow(uint8(im_ba));
%subplot(3,2,6);
%imshow(uint8(im_ab));


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_ba;
global im_a;
im_a = im_ba;
subplot(3,2,1)
imshow(uint8(im_a))

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_ab;
global im_a;
im_a = im_ab;
subplot(3,2,1)
imshow(uint8(im_a))
