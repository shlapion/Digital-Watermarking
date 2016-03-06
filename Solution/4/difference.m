clc; 
clear all; 
close all;

original = imread('test01.jpg');
long = imread('long.png');
short = imread('short.png');

figure;
imshowpair(original, long,'diff');
title('Differnce between original and long');

figure;
imshowpair(original, short,'diff');
title('Differnce between original and short');

figure;
imshowpair(long, short,'diff');
title('Differnce long and short');






