-----------------------------
-- Imants Pulkstenis 
-- 10.02.2020
-- RTR532 PS1
-- PS1
--
-- Task 2 for Problem set #1 – My first VHDL code
--
-- Revision:
-- A - initial design
-- 
--
-----------------------------

--Libraries
library ieee;					
use ieee.std_logic_1164.all;	
use ieee.numeric_std.all;		


--define entity (module) connections to "outside"
entity ps01q is
port
(
	a 			: in std_Logic;
	b 			: in std_logic;
	c 			: in std_logic;
	y1 			: out std_logic;
	y2			: out std_logic
);
end ps01q;


--define inside of the module  (internal signals, components and architecture)
architecture behavioral of ps01q is
	--define inside use signals
	signal SIG_INTERNAL : std_logic;


begin 

	--gate one
	SIG_INTERNAL <= A xor B;
	
	--gate two
	Y2 <= C xnor SIG_INTERNAL;
		
	--gate three
	Y1 <= A nor B; -- in assigment gate three is not ?????
		

end behavioral;





