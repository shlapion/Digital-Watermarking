clc; 
clear all; 
close all;

image = imread('work.png');
[height,width,colordepth] = size(image);
halfWidth = width/2;
halfHeight = height/2;
prec = 0.1;
s1= 'imgTo';

for n = 1:15
cropImg = imcrop(image,[halfWidth - ((width-(width*prec))/2),halfHeight - ((height-(height*prec))/2),width-(width*prec),height-(height*prec)]);
imwrite(cropImg,strcat(s1,num2str(100-(prec*100)),'.png'));
prec = prec + 0.05;
end

