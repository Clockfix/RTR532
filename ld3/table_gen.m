%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Author - Imants Pulkstenis
% Date - 02.05.2020
% Project name - Lab work No.3
% Module name - LookUpTable generator
%
% Detailed module description:
% This file generates lock up table with SIN and COS values
%
% Revision:
% A - initial design (copy from PS3)
% B - 
% C - 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
word_lenght = 16;
table_size = 9;   % 2^n
x = linspace(0, (2*pi - 2*pi/2^table_size) , 2^table_size);
sin_x = sin(x);
sin_x = round(sin_x * 2^word_lenght) / 2^word_lenght;   % round values

cos_x = cos(x);
cos_x = round(cos_x * 2^word_lenght) / 2^word_lenght;   % round values

%% Print values in HEX
hex_sin = [];
hex_cos = [];
for i=1:2^table_size
    a = sfi(sin_x(i),word_lenght,word_lenght-2);
    b = sfi(cos_x(i),word_lenght,word_lenght-2);
    hex_sin = [hex_sin; a.bin];
    hex_cos = [hex_cos; b.bin];
end
%hex_sin,
%hex_cos,

fid = fopen('lookuptable.v', 'wt');
    fprintf(fid, 'module lookuptable #( parameter    phase_width = %d,  data_width	= %d)(\n', table_size, word_lenght);
    fprintf(fid, '\tinput               [phase_width - 1 :0]  phase,\n');
    fprintf(fid, '\toutput     reg      [data_width - 1 :0]  sin,\n');
    fprintf(fid, '\toutput     reg      [data_width - 1 :0]  cos);\n');
    
%    fprintf(fid, 'reg [%d :0]      sin  = %d''h0;    \n', word_lenght-1,word_lenght);
    fprintf(fid, 'always@* begin\n');
    fprintf(fid, 'case (phase[phase_width - 1 : 0])\n');
    
for i=1:length(hex_sin) 
    temp = hex_sin(i,1:word_lenght);
        fprintf(fid, '\t%d''d%d : sin[data_width - 1 : 0] <= %d''b%s;\n',table_size, i-1  ,word_lenght, hex_sin(i,1:word_lenght) );
end
    fprintf(fid, '\tdefault   : sin[data_width - 1 : 0] <= %d''b%s;\n ',word_lenght,  hex_sin(1,1:word_lenght) );
    fprintf(fid, 'endcase\n');
    fprintf(fid, 'end\n');
    fprintf(fid, ' \n');

    fprintf(fid, 'always@* begin\n');
    fprintf(fid, 'case (phase[phase_width - 1 : 0])\n');
    
for i=1:length(hex_cos) 
    temp = hex_cos(i,1:word_lenght);
        fprintf(fid, '\t%d''d%d : cos[data_width - 1 : 0] <= %d''b%s;\n',table_size, i-1 ,  word_lenght, hex_cos(i,1:word_lenght) );
end
    fprintf(fid, '\tdefault   : cos[data_width - 1 : 0] <= %d''b%s;\n ',word_lenght,  hex_cos(1,1:word_lenght) );
    fprintf(fid, 'endcase\n');
    fprintf(fid, 'end\n');
    fprintf(fid, 'endmodule');
    
disp('Text files write done');disp(' ');
fclose(fid);