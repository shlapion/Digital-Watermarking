%pkg install "image-2.4.1.tar.gz";
%pkg load all;
%pkg install "control-2.8.5.tar.gz";
%pkg install "signal-1.3.2.tar.gz";
pkg load all;

function bitstr = toBits(str)
  bytestr = toascii(str);
  [q, anz] = size(bytestr);
  bitstr = [];
  for I=1:16
    bitstr = [bitstr, 0];
  endfor
  for I=1:16
    bitstr = [bitstr, 1];
  endfor
  for I=1:anz
    val = bytestr(I);
    for J=1:8
      if val >= 2^(8-J)
        val = val-2^(8-J);
        bitstr = [bitstr, 1];
      else
        bitstr = [bitstr, 0];
      endif
    endfor
  endfor
  for I=1:8
    bitstr = [bitstr, 0];
  endfor
endfunction


function str = toString(bitstr)
  [q, maxanz] = size(bitstr);
  str='';
  subbytsstr = [];
  start = 1;
  startok = 0;
  while startok<32 && start < maxanz
    while startok<16 && start < maxanz
      if bitstr(start)==0
        startok++;
      else
        startok=0;
      endif
      start++;
    endwhile
    while startok>=16 && startok<32 && start < maxanz
      if bitstr(start)==1
        startok++;
      else
        startok=0;
      endif
      start++;
    endwhile
  endwhile
  aktpos = start;
  while aktpos <= maxanz
    nextA = 0;
    anzN = 0;
    subA = [];
    while nextA<8 && aktpos <= maxanz
      subA = [subA, bitstr(aktpos)];
      if bitstr(aktpos)==0
        anzN++;
      else
        anzN=0;
      endif
      nextA++;
      aktpos++;
    endwhile
    if anzN==8 
      aktpos=maxanz+1;
    elseif nextA != 8 
      aktpos=maxanz+1;
    else
      byte = 0;
      for I=1:8
        byte=2*byte + subA(I);
      endfor
      subbytsstr = [subbytsstr, byte];
    endif
  endwhile
  [q, anzchar] = size(subbytsstr);
  if anzchar>0
    str = char(subbytsstr);
  endif
endfunction



clear;

instr = "Hi, some test text!";
%instr2 = "Hi, some more text here, longer than the original one"

%pos = 1;

%disp('get image');
%imOrg=imread('test01.jpg');
%disp(typeinfo(imOrg));

%disp('get bitseq');
 disp("Original payload:");
 disp(instr);
 msg = toBits(instr);
 disp("msg=");
 disp(msg);
 %msg = rand (10, 11) > 0.5;
 %G= reedmullergen(3,4)
 
 msg = reshape(msg, 16, 12);
 msg = transpose(msg);
  for I = 1:3
    z = zeros(1,16);
    msg = [msg;z];
  endfor
 
 disp("msg=");
 disp(msg);
 
 [c, g] = reedmullerenc (transpose(msg), 3, 4);
 %disp("c=");
 % disp(c);
 [dec_c, dec_m] = reedmullerdec (c, g, 3, 4)
%bitstr2 = toBits(instr2);
disp(transpose(dec_m));


%disp('get image');
%imWM=imread('tttttt.png');
%disp('get bits');
%bitseq = getBits(imWM, pos);
%disp('get string');

 
 result = dec_m;
 result = reshape(result,1,240);
 disp("result matrix");
 disp(result);
 
 text = toString(result);
 disp(text);




break;
