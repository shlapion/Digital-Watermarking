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

function resMtrx = retrieve(bitstr)
  [q, maxanz] = size(bitstr);
  str='';
  start = 1;
  startok = 0;
  
  resMtrx = [];
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
  aktpos = 33;
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
        resMtrx = [resMtrx, subA(I)];
      endfor
    endif
  endwhile
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

function str = toStr(bitstr)
  aktpos=0    
  subbytsstr = [];
  while aktpos < 240
      byte = 0;
      for I=1:8
        byte=2*byte + bitstr(I + aktpos);
      endfor
      subbytsstr = [subbytsstr, byte];
      aktpos = aktpos + 8;    
  endwhile
  [q, anzchar] = size(subbytsstr);
  if anzchar>0
    str = char(subbytsstr);
  endif
endfunction

clear;

instr = "Hi, some test text!";

pos = 1;

disp('get image');
imOrg=imread('test01.jpg');

msg = toBits(instr);

%%to make the messages column size after reshaping with 
%%the row size of generation matrix we add zeros at the end of it
msg = [msg,zeros(1,48)];
msg = reshape(msg, 15, 16);

%%encoding
[c, g] = reedmullerenc (transpose(msg), 3, 4);

%%reshaping encoded payload to embed into the original work
bitstr = reshape(c, 1, 256);
WMWork = embedBits(imOrg, bitstr, pos);
eq(imOrg,WMWork);
disp(typeinfo(WMWork));
imwrite(WMWork,"watermarkedwork.png");


imWM=imread('watermarkedwork.png');
bitseqnc = getBits(imWM, pos);
str = retrieve(bitseqnc);
str = [str,zeros(1,24)];

[dec_c, dec_m] = reedmullerdec (reshape(str,16,16), g, 3, 4)
resultString = toStr(reshape(dec_m,1,240));

break;
