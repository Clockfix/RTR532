-----------------------------
-- Author Imants Pulkstenis
-- Date 10.06.2020
-- Project name Labwork No3
-- Module name lab3_tb
--
-- Detailed module description
-- Test bench for top module of lab.No.3
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
entity lab3_tb is
    generic
    (
        phase_width 						: integer := 9;
        data_width							: integer := 16
    );
    end lab3_tb;

--define inside of the module
architecture behavioral of lab3_tb is

    --signals
	signal clk 									: std_logic := '0';	--100mhz clock
    signal rst									: std_logic := '0';	--rst
    
    component lab3 is
        generic
        (
            phase_width                     : integer := 9;
            data_width                      : integer := 16
        );
        port
        (
            clk                             : in std_logic;	--100mhz clock
            rst                             : in std_logic	--rst
        );
        end component;

        constant clk_period : time := 10 ns;
	
	
	
begin
    
	 clk <= not clk after clk_period/2;
	 
	 
    uut : lab3 
	generic map
	(
		phase_width 						=> phase_width,
		data_width							=> data_width
	)
	port map
	(
		clk 								=> clk,
		rst									=> rst
    );
    
    	--tb process
	process
	begin
	rst <= '1';
	wait for 100 ns;
	rst <= '0';
	
	-- wait for clk_period/2;

	
	wait;
	end process;


	
end behavioral;