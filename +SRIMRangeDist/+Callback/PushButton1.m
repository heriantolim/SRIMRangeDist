function PushButton1(~,~,~)
%% Callback for the SELECT file button
%
% Tested on:
%  - MATLAB R2015b
%
% Copyright: Herianto Lim
% http://heriantolim.com/
% First created: 31/01/2016
% Last modified: 01/02/2015

folderPath=uigetdir();
InputText1=findobj('Tag','InputText1');
InputText1.String=folderPath;

end