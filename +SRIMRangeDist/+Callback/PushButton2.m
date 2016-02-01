function PushButton2(~,~,~)
%% Callback for the PLOT button
%
% Tested on:
%  - MATLAB R2015b
%
% Copyright: Herianto Lim
% http://heriantolim.com/
% First created: 31/01/2016
% Last modified: 01/02/2015

AVOGADRO_CONSTANT=6.02214129e23; % atoms/mol

% Get the input handles
InputTextHandle=zeros(1,5);
for n=1:5
	InputTextHandle(n)=findobj('Tag',sprintf('InputText%d',n));
end

% Check if the required inputs have been provided
basePath=get(InputTextHandle(1),'String');
if isempty(basePath)
	waitfor(errordlg('Please specify the data folder.'));
	return
end
if exist(basePath,'file')~=7
	waitfor(errordlg('The specified data folder does not exist.'));
	return
end
massDensity=str2double(get(InputTextHandle(2),'String'));
if isnan(massDensity)
	waitfor(errordlg('Please specify the mass density of the target medium.'));
	return
end
molarMass=str2double(get(InputTextHandle(3),'String'));
if isnan(molarMass)
	waitfor(errordlg('Please specify the molar mass of the target medium.'));
	return
end

% Read inputs to the energies and fluences
InputTableHandle=findobj('Tag','InputTable');
data=InputTableHandle.Data;
tf=~any(isnan(data),2);
M=sum(tf);
[m,n]=size(data);
InputTableHandle.Data=[data(tf,:);nan(m-M,n)];
if M<=0
	waitfor(errordlg(['Please specify at least one pair of subfolder no. ', ...
		'and fluence.']));
	return
end
subFolderNo=data(tf,1);
fluence=data(tf,2);

% Read SRIM files
tf=false(M,1);
S=cell(M,1);
subFolderName=S;
for m=1:M
	subFolderName{m}=num2str(subFolderNo(m));
	if exist(fullfile(basePath,subFolderName{m}),'file')==7
		filePath=fullfile(basePath,subFolderName{m},'RANGE.txt');
		if exist(filePath,'file')==2
			fID=fopen(filePath,'r');
			if fID==-1
				waitfor(errordlg(['Unable to read ''',fullfile('.', ...
					subFolderName{m},'RANGE.txt'),'''.']));
			else
				S{m}=SRIMRangeDist.readfile(fID);
				if isempty(S{m})
					waitfor(errordlg(['No data could be read from ''', ...
						fullfile('.',subFolderName{m},'RANGE.txt'), ...
						'''. Make sure this file is copied directly from the ', ...
						'SRIM output.']));
				else
					tf(m)=true;
				end
				fclose(fID);
			end
		else
			waitfor(errordlg(['''RANGE.txt'' does not exist in subfolder ', ...
				subFolderName{m},'.'])); 
		end
	else
		waitfor(errordlg(['Subfolder ',subFolderName{m}, ...
			' does not exist in the selected data folder.']));
	end
end
M=sum(tf);
if M<=0
	waitfor(errordlg(':( Nothing to plot. Please fix the errors.'));
	return
end
subFolderName=subFolderName(tf);
fluence=fluence(tf);
S=S(tf);

% Data conversion
c=1/AVOGADRO_CONSTANT/massDensity*molarMass*100;% to percent concentration
x=S{1}(:,1)/10;% from Angstrom to nm

% Check consistency of data
[N,~]=size(S{1});
y=zeros(N,M);
y(:,1)=c*fluence(1)*S{1}(:,2);
for m=2:M
	[n,~]=size(S{m});
	if n~=N
		waitfor(errordlg(['The number of plot points is inconsistent across ', ...
			'different SRIM files. Make sure each SRIM simulation uses the ', ...
			'same medium thickness.']));
		return
	end
	y(:,m)=c*fluence(m)*S{m}(:,2);
end

% Clear previous plots
AxesHandle=findobj('Tag','Axes');
delete(get(AxesHandle,'Children'));
delete(findobj('Tag','Legend'));

% Set the x-axis
XLim=[str2double(get(InputTextHandle(4),'String')), ...
	str2double(get(InputTextHandle(5),'String'))];
if isnan(XLim(1)) || XLim(1)>=x(N)
	XLim(1)=x(1);
	set(InputTextHandle(4),'String',x(1));
end
if isnan(XLim(2)) || XLim(2)<=x(1)
	XLim(2)=x(N);
	set(InputTextHandle(5),'String',x(N));
end
set(AxesHandle,'XLim',XLim);

% Plot
SRIMRangeDist.plot(x,y,subFolderName);

end