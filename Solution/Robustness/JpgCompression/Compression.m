clc; 
clear all; 
close all;


image = imread ('work.png');

prec = 0.1;
s1= 'compress';

for n = 1:18
imwrite(image,strcat(s1,num2str(prec),'.jpg'), 'quality',prec);   
prec = prec + 0.1;
end


