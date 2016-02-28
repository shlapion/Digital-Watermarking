clc; 
clear all; 
close all;

image = imread ('t1.png');

imageNoise = imnoise(image,'gaussian', 0.1);

figure;
imshow(imageNoise);
title('Image after aplying gaussian noise');

figure;
imshow(imageNoise,'Border','Tight');
set(gcf, 'PaperPositionMode', 'auto');
h = gcf;
saveas(h, 'noise.png');