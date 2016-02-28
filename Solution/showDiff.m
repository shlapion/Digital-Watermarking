clc; 
clear all; 
close all;

original = imread('original.jpg');
test1 = imread('t1.png');
test2 = imread('t2.png');
avg = imread('avg.png');

figure;
title('Differnce between original and t1')
imshowpair(original, test1,'diff');

figure
title('Differnce between original and t2')
imshowpair(original, test2,'diff');

figure
title('Differnce between t1 and t2')
imshowpair(test1, test2,'diff');

figure
title('Differnce between t1 and avg')
imshowpair(test1, avg,'diff');

figure
title('Differnce between t2 and avg')
imshowpair(test2, avg,'diff');






