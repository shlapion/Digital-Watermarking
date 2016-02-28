clc; 
clear all; 
close all;

image = imread('t1.png');

cropImg = imcrop(image,[643,643,1043, 1043]);

figure;
imshow(cropImg);
title('Cropped image to 30% of the original one');

figure;
imshow(cropImg,'Border','Tight');
set(gcf, 'PaperPositionMode', 'auto');
h = gcf;
saveas(h, 'crop.png');
