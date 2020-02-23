-----------------------------
-- Author 
-- Date
-- Project name
-- Module name
--
-- Detailed module description
--
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
entity fsm_training_traffic is
port
(
	clk 		: in std_logic;
	rst 		: in std_Logic;
	light		: out std_logic_vector(1 downto 0)
);
end fsm_training_traffic;

--define inside of the module
architecture behavioral of fsm_training_traffic is

	--define inside use signals
	signal state 	: std_logic_vector(1 downto 0) := "00";  --2b state
	signal cnt		: unsigned(7 downto 0) := x"00"; --8b counter
	
	--define components to use



begin
	--define the operation of the module!
	
	process(clk)
	begin
	if rising_edge(clk) then
		if rst = '1' then
			state <= "00";
			cnt <= x"00";
		else 
			case state is
				when "00" => --red light 30 secs
					if cnt < 30 then 
					cnt <= cnt + 1;
					state <= "00";
					else 
					cnt <= 0;
					state <= "01";
					end if;
					
				when "01" => --yellow light 5 secs
					if cnt < 5 then 
					cnt <= cnt + 1;
					state <= "01";
					else 
					cnt <= 0;
					state <= "10";
					end if;				

				when "10" => --green light 30 secs
					if cnt < 30 then 
					cnt <= cnt + 1;
					state <= "10";
					else 
					cnt <= 0;
					state <= "11";
					end if;	

				when "11" => --yellow light 5 secs
					if cnt < 5 then 
					cnt <= cnt + 1;
					state <= "11";
					else 
					cnt <= 0;
					state <= "00";
					end if;	
					
				when others =>
					cnt <= 0;
					state <= "00";				
				
			end case;
		end if;
	end if;
	end process;
	
	
	light <= "00";
	




end behavioral;





