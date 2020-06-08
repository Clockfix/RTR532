-----------------------------
-- Author Imants Pulkstenis
-- Date 08.06.2020
-- Project name Labwork No3
-- Module name sin_gen_tb
--
-- Detailed module description
-- Test bench for signal generator
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
entity sin_gen_tb is
generic
(
	phase_width 						: integer := 9;
	data_width							: integer := 16
);
end sin_gen_tb;

--define inside of the module
architecture behavioral of sin_gen_tb is

	--signals
	signal clk 									: std_logic := '0';	--100mhz clock
	signal rst									: std_logic := '0';	--rst
	signal phase_incr							: std_Logic_vector(phase_width - 1 downto 0) := (others => '0'); --"frequency"
	signal phase_out							: std_Logic_vector(phase_width - 1 downto 0) := (others => '0');
	signal signal_out							: std_Logic_vector(data_width - 1 downto 0) := (others => '0');
	--signal fs_out								: std_logic := '0';	
	--define components to use
	component sin_gen is
	generic
	(
		phase_width 						: integer := 9;
		data_width							: integer := 16
	);
	port
	(
		clk 									: in std_logic;	--100mhz clock
		rst									: in std_logic;	--rst
		phase_incr							: in std_Logic_vector(phase_width - 1 downto 0); --"frequency"
		phase_out							: out std_Logic_vector(phase_width - 1 downto 0);
		signal_out							: out std_Logic_vector(data_width - 1 downto 0)--;
		--fs_out								: in std_logic
	);
	end component;

	constant clk_period : time := 10 ns;
	
	
	
	
begin
	
	clk <= not clk after clk_period/2;
	
	uut : sin_gen 
	generic map
	(
		phase_width 						=> phase_width,
		data_width							=> data_width
	)
	port map
	(
		clk 								=> clk,
		rst									=> rst,
		phase_incr							=> phase_incr,
		phase_out							=> phase_out,
		signal_out							=> signal_out--,
		--fs_out								=> fs_out
	);

	
	--tb process
	process
	begin
	rst <= '1';
	wait for 100 ns;
	rst <= '0';
	
	wait for clk_period/2;
	--phase_incr <= (0 => '1', others => '0'); --1
	--phase_incr <= (5 => '1',2 => '1', 1=> '1',  others => '0'); --37
	phase_incr <= (5 => '1',4 => '1',3 => '1', 0=> '1',  others => '0'); --57
	
	wait;
	end process;


	
end behavioral;





