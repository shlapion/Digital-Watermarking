clc; 
clear all; 
close all;

image = imread ('t1.png');
shearingFactor = 0.001;


strechImage = imresize(image,0.999);

tfrom = affine2d([1 0 0; shearingFactor 1 0; 0 0 1]);
shearedImage = imwarp(image,tfrom);

rotatedImage = imrotate(image,-0.001,'bilinear');

imageNoise = imnoise(image,'gaussian', 0.01, 0.0001);


strechImageStirMark = imresize(image,0.999);
shearedImageStirMark = imwarp(strechImageStirMark,tfrom);
rotatedImageStirMark = imrotate(shearedImageStirMark,-0.001,'bilinear');
imageNoiseStirMark = imnoise(rotatedImageStirMark,'gaussian', 0.01, 0.0001);
imwrite(imageNoiseStirMark,'stirMark.jpg', 'quality',75);




figure;
imshow(strechImage);
title('Streached image by a factor of 0.999');

figure;
imshowpair(image, strechImage,'diff');
title('Difference between original image and streched image');

figure; 
imshow(shearedImage);
title('Sheared image');

figure;
imshowpair(image, shearedImage,'diff');
title('Difference between original image and sheared image');


figure; 
imshow(rotatedImage);
title('Rotated image');

figure;
imshowpair(image, rotatedImage,'diff');
title('Difference between original image and rotated image');

figure;
imshow(imageNoise);
title('Image after aplying gaussian noise');

figure;
imshowpair(image, imageNoise,'diff');
title('Difference between original image and noisy image');

figure;
imshow(imageNoiseStirMark);
title('Image after aplying StirMark attack');

figure;
imshowpair(image, imageNoiseStirMark,'diff');
title('Difference between original image and StirMark attacked image');




