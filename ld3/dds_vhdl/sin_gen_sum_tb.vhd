-----------------------------
-- Author Imants Pulkstenis
-- Date 09.06.2020
-- Project name Labwork No3
-- Module name sin_gen_sum_tb
--
-- Detailed module description
-- Test bench for signal sum module
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
entity sin_gen_sum_tb is
    generic
    (
        phase_width 						: integer := 9;
        data_width							: integer := 16;
		  phase_incr_one                      : integer := 37;
        phase_incr_two                      : integer := 57
    );
    end sin_gen_sum_tb;


--define inside of the module
architecture behavioral of sin_gen_sum_tb is

	--signals
		--signals
        signal clk 									: std_logic := '0';	--100mhz clock
        signal rst									: std_logic := '0';	--rst
        signal signal_out							: std_Logic_vector(data_width - 1 downto 0) := (others => '0');

    --define components to use
    component sin_gen_sum is
        generic
        (
            phase_width 						: integer := 9;
            data_width							: integer := 16;
            phase_incr_one                      : integer := phase_incr_one;
            phase_incr_two                      : integer := phase_incr_two
        );
        port
        (
            clk 								: in std_logic;	--100mhz clock
            rst									: in std_logic;	--rst
            signal_out							: out std_Logic_vector(data_width - 1 downto 0)--;
            --fs_out							: in std_logic
        );
    end component;

    constant clk_period : time := 10 ns;

    begin    
    clk <= not clk after clk_period/2;
	
	uut : sin_gen_sum 
	generic map
	(
		phase_width 				=> phase_width,
        	data_width				=> data_width,
        	phase_incr_one                      	=> phase_incr_one,
        	phase_incr_two                      	=> phase_incr_two
	)
	port map
	(
		clk 								=> clk,
		rst								=> rst,
		signal_out							=> signal_out
	);

    --tb process
    process
	begin
	rst <= '1';
	wait for 100 ns;
	rst <= '0';
	
	wait;
	end process;



end behavioral;