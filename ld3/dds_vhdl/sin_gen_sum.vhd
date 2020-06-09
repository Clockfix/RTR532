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
        phase_incr_one                      : integer := 37;
        phase_incr_two                      : integer := 57
    );
    port
    (
        clk 								: in std_logic;	--100mhz clock
        rst									: in std_logic;	--rst
        signal_out							: out std_Logic_vector(data_width - 1 downto 0)
    );
    end sin_gen_sum;

--define inside of the module
architecture behavioral of sin_gen_sum is
    --define inside use signals
    signal signal_out_one					   : std_Logic_vector(data_width - 1 downto 0) := (others => '0');
    signal signal_out_two   					: std_Logic_vector(data_width - 1 downto 0) := (others => '0');
	signal signal_summ   						: signed(data_width - 1 downto 0) := (others => '0'); --  17bit word
     
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
            --phase_out							: out std_Logic_vector(phase_width - 1 downto 0);
            signal_out							: out std_Logic_vector(data_width - 1 downto 0)
        );
        end component;

begin	--define the operation of the module!
    --signal output 
    
	signal_out <= std_logic_Vector(signal_summ);


sin_gen_one : sin_gen 
generic map
(
    phase_width 						=> phase_width,
    data_width							=> data_width
)
port map
(
    clk 							    	=> clk,
    rst									=> rst,
    phase_incr							=> std_logic_Vector(To_unsigned(phase_incr_one,phase_width)),
    --phase_out						=> phase_out,
    signal_out							=> signal_out_one
);

sin_gen_two : sin_gen 
generic map
(
    phase_width 						=> phase_width,
    data_width							=> data_width
)
port map
(
    clk 							    	=> clk,
    rst									=> rst,
    phase_incr							=> std_logic_Vector(To_unsigned(phase_incr_two,phase_width)),
    --phase_out						=> phase_out,
    signal_out							=> signal_out_two
);

	--adder
	process(clk)
	begin
        if rising_edge(clk) then
                if ((std_logic(signal_out_one(data_width-1)) and std_logic(signal_out_two(data_width-1))) = '1' ) and
                (signed(signal_out_one) + signed(signal_out_two) > x"0000" )
                                             then     --max negative
                    signal_summ <= x"8000"; --overflow
                else if (std_logic(signal_out_one(data_width-1)) nor std_logic(signal_out_two(data_width-1))) = '1' and
                (signed(signal_out_one) + signed(signal_out_two) < x"0000" )
                                             then      --max positive
                    signal_summ <= x"7fff"; --overflow
                    else
                    signal_summ <= signed(signal_out_one) + signed(signal_out_two);
                    end if; 
                end if;
		end if;
	end process;



end behavioral;