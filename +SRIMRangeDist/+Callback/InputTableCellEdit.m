function InputTableCellEdit(source,eventdata,~)
%% Callback for Cell Edit Events in the Input Table
%
% Tested on:
%  - MATLAB R2015b
%
% Copyright: Herianto Lim
% http://heriantolim.com/
% First created: 31/01/2016
% Last modified: 01/02/2015

x=eventdata.NewData;
if ~isreal(x) || x<=0 || x>floor(x)
	source.Data(eventdata.Indices(1),eventdata.Indices(2))=NaN;
end

end