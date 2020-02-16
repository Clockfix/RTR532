----------------------------- info header [part 1 of the VHDL file]
-- Author 
-- Date
-- Project name
-- Module name
--
-- Detailed module description
--
--
--
--
--
--
--
-- Revision:
-- A - initial design
-- B - 
--
-----------------------------

-- define libraries to be used [part 2 of the VHDL file]
library ieee;						--always use this library
use ieee.std_logic_1164.all;	--always use this library
use ieee.numeric_std.all;		--use this library if arithmetic required


--Entity declaration [part 3 of the VHDL file].
entity alu is
generic
(
	data_width : integer := 32
);
port
(
	clk 		: in std_logic;
	A 			: in std_Logic_vector(data_width - 1 downto 0);
	B 			: in std_logic_vector(data_width - 1 downto 0);
	op 		: in std_logic_vector(3 downto 0);
	R 			: out std_logic_vector(data_width - 1 downto 0);
	flag		: out std_logic
);
end alu;

--define inside of the module
architecture behavioral of alu is
	--define inside use signals and components [part 4 of the VHDL file]





begin
	--define the operation of the module! [part 5 of the VHDL file]
	flag <= '0'; --optional




end behavioral;





