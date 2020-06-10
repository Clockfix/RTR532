-- -------------------------------------------------------------
-- 
-- File Name: iif_hdl\ld3_fixed_point2\IIR.vhd
-- Created: 2020-06-09 20:33:43
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 4.53515e-05
-- Target subsystem base rate: 4.53515e-05
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        4.53515e-05
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- Out1                          ce_out        4.53515e-05
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: IIR
-- Source Path: ld3_fixed_point2/IIR
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY IIR IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        In1                               :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        ce_out                            :   OUT   std_logic;
        Out1                              :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END IIR;


ARCHITECTURE rtl OF IIR IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL kconst                           : signed(15 DOWNTO 0);  -- sfix16_En20
  SIGNAL kconst_1                         : signed(15 DOWNTO 0);  -- sfix16_En20
  SIGNAL In1_signed                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Subtract1_out1                   : signed(15 DOWNTO 0);  -- sfix16_En9
  SIGNAL Delay1_out1                      : signed(15 DOWNTO 0);  -- sfix16_En9
  SIGNAL a_3_mul_temp                     : signed(31 DOWNTO 0);  -- sfix32_En24
  SIGNAL a_3_out1                         : signed(15 DOWNTO 0);  -- sfix16_En10
  SIGNAL a_2_mul_temp                     : signed(31 DOWNTO 0);  -- sfix32_En23
  SIGNAL a_2_out1                         : signed(15 DOWNTO 0);  -- sfix16_En9
  SIGNAL Subtract2_sub_cast               : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL Subtract2_sub_cast_1             : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL Subtract2_sub_temp               : signed(31 DOWNTO 0);  -- sfix32_En14
  SIGNAL Subtract2_out1                   : signed(15 DOWNTO 0);  -- sfix16_En9
  SIGNAL Subtract1_sub_cast               : signed(31 DOWNTO 0);  -- sfix32_En10
  SIGNAL Subtract1_sub_cast_1             : signed(31 DOWNTO 0);  -- sfix32_En10
  SIGNAL Subtract1_sub_temp               : signed(31 DOWNTO 0);  -- sfix32_En10
  SIGNAL Subtract1_out1_1                 : signed(15 DOWNTO 0);  -- sfix16_En9
  SIGNAL b_1_mul_temp                     : signed(31 DOWNTO 0);  -- sfix32_En29
  SIGNAL b_1_out1                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL b_1_out1_1                       : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL b_2_out1                         : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Sum_add_cast                     : signed(31 DOWNTO 0);  -- sfix32_En15
  SIGNAL Sum_add_cast_1                   : signed(31 DOWNTO 0);  -- sfix32_En15
  SIGNAL Sum_add_temp                     : signed(31 DOWNTO 0);  -- sfix32_En15
  SIGNAL Sum_out1                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL kconst_2                         : signed(15 DOWNTO 0);  -- sfix16_En20
  SIGNAL kconst_3                         : signed(15 DOWNTO 0);  -- sfix16_En20
  SIGNAL Delay1_out1_1                    : signed(15 DOWNTO 0);  -- sfix16_En9
  SIGNAL b_3_mul_temp                     : signed(31 DOWNTO 0);  -- sfix32_En29
  SIGNAL b_3_out1                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL b_3_out1_1                       : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL Sum1_add_cast                    : signed(31 DOWNTO 0);  -- sfix32_En15
  SIGNAL Sum1_add_cast_1                  : signed(31 DOWNTO 0);  -- sfix32_En15
  SIGNAL Sum1_add_temp                    : signed(31 DOWNTO 0);  -- sfix32_En15
  SIGNAL Sum1_out1                        : signed(15 DOWNTO 0);  -- sfix16_En14

  ATTRIBUTE multstyle : string;

BEGIN
  kconst <= to_signed(16#6CF4#, 16);

  enb <= clk_enable;

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      kconst_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        kconst_1 <= kconst;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  In1_signed <= signed(In1);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= Subtract1_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  a_3_mul_temp <= to_signed(16#7934#, 16) * Delay1_out1;
  a_3_out1 <= a_3_mul_temp(29 DOWNTO 14);

  a_2_mul_temp <= to_signed(-16#5E65#, 16) * Subtract1_out1;
  a_2_out1 <= a_2_mul_temp(29 DOWNTO 14);

  Subtract2_sub_cast <= resize(In1_signed, 32);
  Subtract2_sub_cast_1 <= resize(a_2_out1 & '0' & '0' & '0' & '0' & '0', 32);
  Subtract2_sub_temp <= Subtract2_sub_cast - Subtract2_sub_cast_1;
  Subtract2_out1 <= Subtract2_sub_temp(20 DOWNTO 5);

  Subtract1_sub_cast <= resize(Subtract2_out1 & '0', 32);
  Subtract1_sub_cast_1 <= resize(a_3_out1, 32);
  Subtract1_sub_temp <= Subtract1_sub_cast - Subtract1_sub_cast_1;
  Subtract1_out1_1 <= Subtract1_sub_temp(16 DOWNTO 1);

  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Subtract1_out1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Subtract1_out1 <= Subtract1_out1_1;
      END IF;
    END IF;
  END PROCESS reduced_process;


  b_1_mul_temp <= kconst_1 * Subtract1_out1;
  b_1_out1 <= b_1_mul_temp(29 DOWNTO 14);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      b_1_out1_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        b_1_out1_1 <= b_1_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  b_2_out1 <= to_signed(16#0000#, 16);

  Sum_add_cast <= resize(b_1_out1_1, 32);
  Sum_add_cast_1 <= resize(b_2_out1 & '0', 32);
  Sum_add_temp <= Sum_add_cast + Sum_add_cast_1;
  Sum_out1 <= Sum_add_temp(15 DOWNTO 0);

  kconst_2 <= to_signed(-16#6CF4#, 16);

  HwModeRegister2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      kconst_3 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        kconst_3 <= kconst_2;
      END IF;
    END IF;
  END PROCESS HwModeRegister2_process;


  HwModeRegister3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1_1 <= Delay1_out1;
      END IF;
    END IF;
  END PROCESS HwModeRegister3_process;


  b_3_mul_temp <= kconst_3 * Delay1_out1_1;
  b_3_out1 <= b_3_mul_temp(29 DOWNTO 14);

  PipelineRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      b_3_out1_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        b_3_out1_1 <= b_3_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister1_process;


  Sum1_add_cast <= resize(Sum_out1, 32);
  Sum1_add_cast_1 <= resize(b_3_out1_1, 32);
  Sum1_add_temp <= Sum1_add_cast + Sum1_add_cast_1;
  Sum1_out1 <= Sum1_add_temp(16 DOWNTO 1);

  Out1 <= std_logic_vector(Sum1_out1);

  ce_out <= clk_enable;

END rtl;
