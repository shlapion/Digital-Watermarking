clc; 
clear all; 
close all;

image = imread ('t1.png');
filter = ones(11,11)/121;

filteredImg = imfilter(image, filter);


figure;
imshow(filteredImg);
title('Image after aplying 11x11 avereging filter');

figure;
imshow(filteredImg,'Border','Tight');
set(gcf, 'PaperPositionMode', 'auto');
h = gcf;
saveas(h, 'avgFilter.png');

