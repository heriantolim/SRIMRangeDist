function A=readfile(fID)
%% Read File
%  This function reads the ion distribution data from a SRIM file opened a
%  file identifier: fID.
%
% Tested on:
%  - MATLAB R2015b
%
% Copyright: Herianto Lim
% http://heriantolim.com/
% First created: 31/01/2016
% Last modified: 01/02/2015

% Count the header lines
ref=uint8('DEPTH');
N=numel(ref);
m=0;
n=1;
while ~feof(fID) && n<=N
	A=uint8(fscanf(fID,'%c',1));
	if A==ref(n)
		n=n+1;
	else
		n=1;
		if A==10
			m=m+1;
		end
	end
end
m=m+3;

% Read the depth and ion distribution
frewind(fID);
A=textscan(fID,repmat('%f',1,3),'HeaderLines',m);
A=[A{1},A{2}];

end