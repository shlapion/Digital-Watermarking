clc; 
clear all; 
close all;

original = imread('test01.jpg');
watermarked = imread('long.png');
watermarked1 = imread('moodle.png');

figure;
imshowpair(original, watermarked,'diff');
title('Differnce between original and t1');

figure;
imshowpair(watermarked1, watermarked,'diff');
title('Differnce between moodle and long');


