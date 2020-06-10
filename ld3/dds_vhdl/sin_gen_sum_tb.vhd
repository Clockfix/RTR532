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
-- B - Remove sin_gen module out of this module
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
        phase_incr_two                      : integer := 57;
        sampling_f					: integer := 4535;	-- 100MHz/22050Hz
	    clock_cnt_width				: integer := 13
    );
    end sin_gen_sum_tb;




--define inside of the module
architecture behavioral of sin_gen_sum_tb is

	    --define inside use signals
        signal signal_f_one                   : std_Logic_vector(data_width - 1 downto 0) := (others => '0');
        signal signal_f_two                   : std_Logic_vector(data_width - 1 downto 0) := (others => '0');
        signal clk 									: std_logic := '0';	--100mhz clock
        signal rst									: std_logic := '0';	--rst
        signal signal_out							: std_Logic_vector(data_width - 1 downto 0) := (others => '0');
	    signal clk_22050                      : std_Logic := '0'; 

    --define components to use
    component sin_gen_sum is
        generic
        (
            phase_width 						: integer := 9;
            data_width							: integer := 16
        );
        port
        (
            clk 								: in std_logic;	--100mhz clock
            --rst									: in std_logic;	--rst
            signal_in_one                       : in std_Logic_vector(data_width - 1 downto 0);
            signal_in_two                       : in std_Logic_vector(data_width - 1 downto 0);
            signal_out							: out std_Logic_vector(data_width - 1 downto 0)--;
        );
    end component;

	component sin_gen is
        generic
        (
            phase_width                 : integer := 9;
            data_width                  : integer := 16;
            
            sampling_f					: integer := 4535;	-- 100MHz/22050Hz
	        clock_cnt_width				: integer := 13
        );
        port
        (
            clk                         : in std_logic;	--100mhz clock
            rst                         : in std_logic;	--rst
            phase_incr                  : in std_Logic_vector(phase_width - 1 downto 0); --"frequency"
            phase_out                   : out std_Logic_vector(phase_width - 1 downto 0);
            signal_out                  : out std_Logic_vector(data_width - 1 downto 0);
            fs_out                      : out std_logic --output sampling clock 22050Hz
        );
        end component;




    constant clk_period : time := 10 ns;

    begin    
    clk <= not clk after clk_period/2;
	

uut  : sin_gen_sum   -- signal sumator
    generic map
    (
        phase_width 						=> phase_width,
        data_width						=> data_width
    )
    port map
    (
        clk 							    => clk,
        --rst									=> rst,
        signal_in_one						=> signal_f_one,
        signal_in_two						=> signal_f_two,
        signal_out						=> signal_out
    );

sin_gen_one : sin_gen   -- first signal generator
generic map
(
    phase_width 						=> phase_width,
    data_width							=> data_width,
    sampling_f							=> sampling_f,
	 clock_cnt_width					=> clock_cnt_width
)
port map
(
    clk                          => clk,
    rst									=> rst,
    phase_incr							=> std_logic_Vector(To_unsigned(phase_incr_one,phase_width)),
    --phase_out						        => phase_out,
    signal_out							=> signal_f_one,
	fs_out								=> clk_22050
);

sin_gen_two : sin_gen   -- second signal generator
generic map
(
    phase_width 						=> phase_width,
    data_width							=> data_width,
    sampling_f							=> sampling_f,
	 clock_cnt_width						=> clock_cnt_width
)
port map
(
    clk 							    => clk,
    rst									=> rst,
    phase_incr							=> std_logic_Vector(To_unsigned(phase_incr_two,phase_width)),
    --phase_out					        	=> phase_out,
    signal_out							=> signal_f_two
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