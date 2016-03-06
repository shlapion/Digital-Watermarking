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



clear;

instr = "Hi, some test text!";
instr2 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed volutpat malesuada erat, et sagittis metus maximus eget. Duis bibendum turpis justo. In semper, est quis vestibulum dictum, mi magna volutpat mauris, ac semper risus massa sit amet felis. In eu tortor vel turpis volutpat ullamcorper et in quam. Aliquam non elit quis elit pretium finibus id nec magna. Donec tincidunt, felis at finibus iaculis, dolor nunc efficitur risus, quis lobortis velit velit sit amet odio. Integer sollicitudin augue id ex accumsan, ac ultrices lorem porta. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed sit amet luctus ligula. Donec semper malesuada erat, non feugiat nulla placerat ac. In maximus varius mollis.";
instr3 = "H";

pos = 1;

disp('get image');
imOrg=imread('test01.jpg');
disp(typeinfo(imOrg));

disp('get bitseq');
bitstr = toBits(instr);
bitstr2 = toBits(instr2);
bitstr3 = toBits(instr3);


disp('imbed');
WMWork = embedBits(imOrg, bitstr, pos);
WMWork2 = embedBits(imOrg, bitstr2, pos);
WMWork3 = embedBits(imOrg, bitstr3, pos);


disp(typeinfo(WMWork));
imwrite(WMWork,"Solution/4/work.png");
imwrite(WMWork2,"Solution/4/long.png");
imwrite(WMWork3,"Solution/4/short.png");



break;
