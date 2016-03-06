clear;

 %msg = imread('small.png');
 
 msg = rand (1, 192) > 0.5;
 %msg = rand (10, 11) > 0.5;
 %G= reedmullergen(3,5);
 
 %msg = reshape(msg, 12, 16);
 % for I = 1:3
 %   z = zeros(1,16);
 %   msg = [msg;z];
 % endfor
msg = [msg,zeros(1,48)];
msg = reshape(msg, 15, 16);
 
 [c, g] = reedmullerenc (transpose(msg), 3, 4);
 %disp("c=");
 % disp(c);
 [dec_c, dec_m] = reedmullerdec (c, g, 3, 4)
 
 disp("msg=");
 disp(msg);
 
 disp("transpose dec_m")
 disp(transpose(dec_m));
 
 disp("is equal")
 disp(isequal(msg, transpose(dec_m)));
 
%imwrite(dec_m,"small2.png");
 
 
break;