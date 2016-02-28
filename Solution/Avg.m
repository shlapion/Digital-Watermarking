clc; 
clear all; 
close all;


% User selecting image directory
cd(uigetdir);

% Counting number of .JPG's in folder
Files = dir('*.png');
b=numel(Files);

% Initialize to first image.
I0 = imread('t1.png')
sumImage = double(I0);

% Read in remaining images.
for i=2:b
  rgbImage = imread(['t',num2str(i),'.png']);
  sumImage = sumImage + double(rgbImage);
end;
% Average Image and output file
meanImage = uint8(sumImage / b);
imshow(meanImage);
imshow(meanImage,'Border','Tight');
set(gcf, 'PaperPositionMode', 'auto');
h = gcf;
saveas(h, 'avg.png');