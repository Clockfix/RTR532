-----------------------------
-- Author - 
-- Date - 
-- Project name - 
-- Module name - 
--
-- Detailed module description
--
-- Revision:
-- A - initial design
-- B - 
--
-----------------------------
library ieee;					--always use this library
use ieee.std_logic_1164.all;	--always use this library

use ieee.numeric_std.all;		--use this library if arithmetic required


--define connections to outside
entity dds_vhdl is
generic
(
	phase_width 						: integer := 4;
	data_width							: integer := 8
);
port
(
	clk 									: in std_logic;	--100mhz clock
	rst									: in std_logic;	--rst
	phase_incr							: in std_Logic_vector(phase_width - 1 downto 0); --"frequency"
	phase_out							: out std_Logic_vector(phase_width - 1 downto 0);
	signal_out							: out std_Logic_vector(data_width - 1 downto 0)
);
end dds_vhdl;

--define inside of the module
architecture behavioral of dds_vhdl is

	--define inside use signals
	type rom_table is array ( 0 to 2**phase_width - 1) of std_logic_vector(data_width - 1 downto 0);
	constant signal_rom_table : rom_table := 
	(
		0  => x"FF",
		1  => x"FF",
		2  => x"FF",
		3  => x"FF",
		4  => x"FF",
		5  => x"FF",
		6  => x"FF",
		7  => x"FF",
		8  => x"00",
		9  => x"00",
		10 => x"00",
		11 => x"00",
		12 => x"00",
		13 => x"00",
		14 => x"00",
		15 => x"00"
	);

	-- phase counter
	signal phase_cnt : unsigned(phase_width - 1 downto 0) := (others => '0');
	



begin	--define the operation of the module!
	
	--phase output for debugging
	phase_out <= std_logic_Vector(phase_cnt);
	
	--phase counter
	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then		
				phase_cnt <= 
			else
				phase_cnt <= 
			end if;
		end if;
	end process;


	
	--data output
	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then		
				signal_out <= 
			else
				--assign value from table
				signal_out <= 
			end if;
		end if;
	end process;
	
end behavioral;





