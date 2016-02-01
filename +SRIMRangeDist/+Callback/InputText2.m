function InputText2(source,~,~)
%% Callback for the Input Text Field for the Mass Density
%
% Tested on:
%  - MATLAB R2015b
%
% Copyright: Herianto Lim
% http://heriantolim.com/
% First created: 31/01/2016
% Last modified: 01/02/2015

x=str2double(source.String);
if isnan(x) || ~isreal(x) || x<=0
	source.String='NaN';
end

end