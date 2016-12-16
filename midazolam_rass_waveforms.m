%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\310124512\OneDrive - Philips\References\Courses\MIT_Fall_Course\Project_files\midazolam_rass_waveforms.csv
%    (TYPE  A DIFFERENT PATH BELOW IF DESIRED)
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/12/06 17:10:56

%% Initialize variables.
% ------------ TYPE RIGHT PATH -------------------------------------------
filename = 'C:\Users\310124512\OneDrive - Philips\References\Courses\MIT_Fall_Course\Project_files\midazolam_rass_waveforms.csv';
% ------------------------------------------------------------------------
delimiter = ',';
startRow = 2;

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: datetimes (%{yyyy-MM-dd HH:mm:ss}D)
%	column6: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%{yyyy-MM-dd HH:mm:ss}D%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
row = dataArray{:, 1};
subject_id = dataArray{:, 2};
hadm_id = dataArray{:, 3};
icustay_id = dataArray{:, 4};
charttime = dataArray{:, 5};
valuenum = dataArray{:, 6};

% For code requiring serial dates (datenum) instead of datetime, uncomment
% the following line(s) below to return the imported dates as datenum(s).

% charttime=datenum(charttime);


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;