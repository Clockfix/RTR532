-----------------------------
-- Author - Imants Pulkstenis
-- Date - 08.06.2020
-- Project name - Lab work No3
-- Module name - sin_gen_sum
--
-- Detailed module description:
-- This is top module containing 
-- signal genrators, FIR and IIR filter
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
entity sin_gen_sum is
    generic
    (
        phase_width 						: integer := 9;
        data_width							: integer := 16;
        phase_incr_one                      : integer := 16;
        phase_incr_two                      : integer := 16
    );
    port
    (
        clk 								: in std_logic;	--100mhz clock
        rst									: in std_logic;	--rst
        --phase_incr_one  					: in std_Logic_vector(phase_width - 1 downto 0); --"frequency for first signal"
        --phase_incr_two  					: in std_Logic_vector(phase_width - 1 downto 0); --"frequency for second signal"
        signal_out							: out std_Logic_vector(data_width - 1 downto 0)
    );
    end sin_gen_sum;

--define inside of the module
architecture behavioral of sin_gen_sum is
    --define inside use signals

    
    --define components to use
	component sin_gen is
        generic
        (
            phase_width 						: integer := 9;
            data_width							: integer := 16
        );
        port
        (
            clk 								: in std_logic;	--100mhz clock
            rst									: in std_logic;	--rst
            phase_incr							: in std_Logic_vector(phase_width - 1 downto 0); --"frequency"
            phase_out							: out std_Logic_vector(phase_width - 1 downto 0);
            signal_out							: out std_Logic_vector(data_width - 1 downto 0)
        );
        end component;

begin	--define the operation of the module!

dds_vhdl_one : sin_gen 
generic map
(
    phase_width 						=> phase_width,
    data_width							=> data_width
)
port map
(
    clk 							    => clk,
    rst									=> rst,
    phase_incr							=> phase_incr,
    phase_out							=> phase_out,
    signal_out							=> signal_out
);


end behavioral;