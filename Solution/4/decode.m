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

function im = embedBits(im, bitSeq, pos)
  [q, bitNum] = size(bitSeq);
  [maxX, maxY, maxZ] = size(im);
  z=1;
  im(:,:,pos) = (im(:,:,pos).-mod(im(:,:,pos),2));
  for x=1:maxX
    for y=1:maxY
      if bitSeq(z) == 1
         im(x,y,pos) = im(x,y,pos)+1;
      endif
      z++;
      if z>bitNum
        z=1;
      endif
    endfor
  endfor
endfunction

function bitSeq = getBits(im, pos)
  bitSeq = [];
  [maxX, maxY, maxZ] = size(im);
  for x=1:maxX
    for y=1:maxY
      bitSeq = [bitSeq, mod(im(x,y,pos),2)];
    endfor
  endfor
 endfunction

clear;

%instr = "Hi, some test text!";

pos = 1;


disp('get image');
imWM=imread('longTo99.8.png');
disp('get bits');
bitseq = getBits(imWM, pos);
disp('get string');
str1 = toString(bitseq);
disp(str1);

disp('get image');
imWM2=imread('shortTo99.8.png');
disp('get bits');
bitseq2 = getBits(imWM2, pos);
disp('get string');
str2 = toString(bitseq2);
disp(str2);

disp('get image');
imWM3=imread('workTo99.8.png');
disp('get bits');
bitseq3 = getBits(imWM3, pos);
disp('get string');
str3 = toString(bitseq3);
disp(str3);


break;
