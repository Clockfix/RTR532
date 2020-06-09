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
    hex_sin = [hex_sin; a.hex];
    hex_cos = [hex_cos; b.hex];
end
%hex_sin,
%hex_cos,

fid = fopen('lookuptable.vhd', 'wt');
    fprintf(fid, 'type rom_table is array ( 0 to 2**%d - 1) of std_logic_vector(%d - 1 downto 0);\n', table_size, word_lenght);
    fprintf(fid, 'constant signal_rom_table : rom_table := \n');
    fprintf(fid, '(\n');
    
for i=1:length(hex_sin) 
    temp = hex_sin(i,1:word_lenght/4);
        fprintf(fid, '\t%d => x"%s",\n', i-1, hex_sin(i,1:word_lenght/4) );
end

    fprintf(fid, ');\n');

    
disp('Text files write done');disp(' ');
fclose(fid);