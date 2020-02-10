-----------------------------
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
	y1 		: out std_logic;
	y2			: out std_logic
);
end ps01q;


--define inside of the module  (internal signals, components and architecture)
architecture behavioral of ps01q is
	--define inside use signals
	signal SIG_INTERNAL : std_logic;


begin -- jums jaalabo tikai taalaakais.


	--gate one
	SIG_INTERNAL <= A and B;

	
	--gate two
	Y2 <= C and SIG_INTERNAL;
	
	
	--gate three
	Y1 <= A and B;
	
	
	--logic gate izsauksanas keywordi:
	-- not
	-- and, nand,
	-- or, xor, nor, xnor
	
	
	


end behavioral;





