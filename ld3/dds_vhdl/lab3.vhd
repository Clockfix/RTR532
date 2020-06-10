-----------------------------
-- Author Imants Pulkstenis
-- Date 09.06.2020
-- Project name Labwork No3
-- Module name lab3
--
-- Detailed module description
-- Top level module for Lab.No3
-- The top module contains two signal generator modules, 
-- a signal sum module, and two filters. The first filter 
-- is generated using Altera Megawizard plugin IP Core, 
-- but second, using the Simulink HDL code generator. 
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
entity lab3 is
    generic
    (
        phase_width                     : integer := 9;
        data_width                      : integer := 16;
        phase_incr_one                  : integer := 37;    -- 22050/1664
        phase_incr_two                  : integer := 57;
        sampling_f						: integer := 4535;	-- 100MHz/22050
	    clock_cnt_width					: integer := 13
    );
    port
    (
        clk                             : in std_logic;	--100mhz clock
        rst                             : in std_logic	--rst
    );
    end lab3;

--define inside of the module
architecture behavioral of lab3 is
    --define inside use signals
    signal signal_f_one                   : std_Logic_vector(data_width - 1 downto 0) := (others => '0');
    signal signal_f_two                   : std_Logic_vector(data_width - 1 downto 0) := (others => '0');
	 signal signal_sum                     : std_Logic_vector(data_width - 1 downto 0) := (others => '0');
	 signal clk_22050                      : std_Logic := '0'; 
	 signal not_rst                        : std_Logic := '1';  

    --define components to use
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
    
    component sin_gen_sum is
        generic
        (
            phase_width                     : integer := 9;
            data_width                      : integer := 16
        );
        port
        (
            clk                             : in std_logic;	--100mhz clock
            --rst                             : in std_logic;	--rst
            signal_in_one                   : in std_Logic_vector(data_width - 1 downto 0);
            signal_in_two                   : in std_Logic_vector(data_width - 1 downto 0);
            signal_out                      : out std_Logic_vector(data_width - 1 downto 0)
        );
        end component;
    
    component IIR is    
    port( clk                               :   IN    std_logic;
          reset                             :   IN    std_logic;
          clk_enable                        :   IN    std_logic;
          In1                               :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          ce_out                            :   OUT   std_logic;
          Out1                              :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
    end component;   

    component fir is
        port (
            clk              : in  std_logic                     := '0';             --                     clk.clk
            reset_n          : in  std_logic                     := '0';             --                     rst.reset_n
            ast_sink_data    : in  std_logic_vector(15 downto 0) := (others => '0'); --   avalon_streaming_sink.data
            ast_sink_valid   : in  std_logic                     := '0';             --                        .valid
            ast_sink_error   : in  std_logic_vector(1 downto 0)  := (others => '0'); --                        .error
            ast_source_data  : out std_logic_vector(36 downto 0);                    -- avalon_streaming_source.data
            ast_source_valid : out std_logic;                                        --                        .valid
            ast_source_error : out std_logic_vector(1 downto 0)                      --                        .error
        );
    end component;
   


begin	--define the operation of the module!

not_rst <= std_logic(not rst);


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


sin_gen_sum_one : sin_gen_sum   -- signal sumator
generic map
(
    phase_width 						=> phase_width,
    data_width							=> data_width
)
port map
(
    clk 							    => clk,
    --rst									=> rst,
    signal_in_one						=> signal_f_one,
    signal_in_two						=> signal_f_two,
    signal_out							=> signal_sum
);

iir_one : IIR    -- IIR filter from Simulink
port map
( 
        clk                               => clk_22050,
        reset                             => rst,
        clk_enable                        => '1',
        In1                               => signal_sum--,  -- sfix16_En14
        --ce_out                            =>,
        --Out1                              =>  -- sfix16_En14
);

fir_one : fir    -- FIR filter from Altera Megawizard plugin IP Core
port map
( 
				clk                               =>  clk_22050,			 	--  clk.clk
            reset_n                           =>  not_rst,   				--  rst.reset_n
            ast_sink_data                     =>  signal_sum,				--   avalon_streaming_sink.data
            ast_sink_valid                    =>  '1',         			--  .valid
            ast_sink_error                    =>  "00"  						-- .error (00: No error)
         --   ast_source_data                                 =>           -- avalon_streaming_source.data
         --   ast_source_valid                                =>           --    .valid
         --   ast_source_error                                =>           --   .error
);





end behavioral;