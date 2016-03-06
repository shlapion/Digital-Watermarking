clc; 
clear all; 
close all;

image = imread('work.png');
long = imread('long.png');
short = imread('short.png');

[height,width,colordepth] = size(image);
halfWidth = width/2;
halfHeight = height/2;
prec = 0.001;

s1= 'workTo';
s2= 'longTo';
s3= 'shortTo';

for n = 1:15
cropImgWork = imcrop(image,[halfWidth - ((width-(width*prec))/2),halfHeight - ((height-(height*prec))/2),width-(width*prec),height-(height*prec)]);
cropImgLong = imcrop(long,[halfWidth - ((width-(width*prec))/2),halfHeight - ((height-(height*prec))/2),width-(width*prec),height-(height*prec)]);
cropImgShort = imcrop(short,[halfWidth - ((width-(width*prec))/2),halfHeight - ((height-(height*prec))/2),width-(width*prec),height-(height*prec)]);
imwrite(cropImgWork,strcat(s1,num2str(100-(prec*100)),'.png'));
imwrite(cropImgLong,strcat(s2,num2str(100-(prec*100)),'.png'));
imwrite(cropImgShort,strcat(s3,num2str(100-(prec*100)),'.png'));
prec = prec + 0.001;
end


