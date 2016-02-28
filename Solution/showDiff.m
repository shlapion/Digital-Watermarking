clc; 
clear all; 
close all;

original = imread('original.jpg');
test1 = imread('t1.png');
test2 = imread('t2.png');
avg = imread('avg.png');

figure;
imshowpair(original, test1,'diff');
title('Differnce between original and t1');

figure;
imshowpair(original, test2,'diff');
title('Differnce between original and t2');

figure;
imshowpair(test1, test2,'diff');
title('Differnce between t1 and t2');






