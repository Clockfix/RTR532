%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Author - Imants Pulkstenis
% Date - 29.03.2020
% Project name - PS04
% Module name - DDS (direct digital synthesis)
%
% Detailed module description:
% This file generates lock up table with SIN values
%
% Revision:
% A - initial design
% B - 
% C - 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

word_lenght = 8;
table_size = 4;   % 2^n
x = linspace(0, (2*pi - 2*pi/2^table_size) , 2^table_size);
sin_x = sin(x);
sin_x = round(sin_x * 2^word_lenght) / 2^word_lenght;

%% Print values in hex
hex = [];
for i=1:2^table_size
	a = sfi(sin_x(i),word_lenght,word_lenght-2);
	hex = [hex; a.bin];
end
hex,

fid = fopen('lookuptable.v', 'wt');
    fprintf(fid, 'module lookuptable(\n');
    fprintf(fid, '\tinput               [%d :0]  in,\n',word_lenght-1);
    fprintf(fid, '\toutput     reg      [%d :0]  out);\n',word_lenght-1);
    
    fprintf(fid, 'reg [%d :0]      out  = %d''h0;    \n', word_lenght-1,word_lenght);
    fprintf(fid, 'always@* begin\n');
    fprintf(fid, 'case (in)\n');
    
for i=1:length(hex) 
    temp = hex(i,1:word_lenght);
        fprintf(fid, '\t%d''d%d : out <= %d''b%s;\n',word_lenght, i-1 ,word_lenght, hex(i,1:word_lenght) );
end
    fprintf(fid, '\tdefault   : out <= %d''b%s;\n ',word_lenght, hex(1,1:word_lenght) );
    fprintf(fid, 'endcase\n');
    fprintf(fid, 'end\n');
    fprintf(fid, 'endmodule');
    
disp('Text files write done');disp(' ');
fclose(fid);