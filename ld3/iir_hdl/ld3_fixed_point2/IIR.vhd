-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\Imants\Desktop\sin_gen\iir_hdl\ld3_fixed_point2\IIR.vhd
-- Created: 2020-06-10 11:45:07
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
  SIGNAL enb_const_rate                   : std_logic;
  SIGNAL Constant_out1                    : unsigned(15 DOWNTO 0);  -- ufix16_En21
  SIGNAL Constant_out1_1                  : unsigned(15 DOWNTO 0);  -- ufix16_En21
  SIGNAL In1_signed                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Constant3_out1                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Constant2_out1                   : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL Subtract1_out1                   : signed(15 DOWNTO 0);  -- sfix16_En9
  SIGNAL Delay1_out1                      : signed(15 DOWNTO 0);  -- sfix16_En9
  SIGNAL a_3_cast                         : signed(16 DOWNTO 0);  -- sfix17_En16
  SIGNAL a_3_mul_temp                     : signed(32 DOWNTO 0);  -- sfix33_En25
  SIGNAL a_3_cast_1                       : signed(31 DOWNTO 0);  -- sfix32_En25
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
  SIGNAL b_1_cast                         : signed(16 DOWNTO 0);  -- sfix17_En21
  SIGNAL b_1_mul_temp                     : signed(32 DOWNTO 0);  -- sfix33_En30
  SIGNAL b_1_cast_1                       : signed(31 DOWNTO 0);  -- sfix32_En30
  SIGNAL b_1_out1                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL b_1_out1_1                       : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL Constant1_out1                   : signed(15 DOWNTO 0);  -- sfix16_En20
  SIGNAL Constant1_out1_1                 : signed(15 DOWNTO 0);  -- sfix16_En20
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
  Constant_out1 <= to_unsigned(16#D9E8#, 16);

  enb_const_rate <= clk_enable;

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Constant_out1_1 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_const_rate = '1' THEN
        Constant_out1_1 <= Constant_out1;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  In1_signed <= signed(In1);

  Constant3_out1 <= to_signed(-16#5E65#, 16);

  Constant2_out1 <= to_unsigned(16#F268#, 16);

  enb <= clk_enable;

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


  a_3_cast <= signed(resize(Constant2_out1, 17));
  a_3_mul_temp <= a_3_cast * Delay1_out1;
  a_3_cast_1 <= a_3_mul_temp(31 DOWNTO 0);
  a_3_out1 <= a_3_cast_1(30 DOWNTO 15);

  a_2_mul_temp <= Constant3_out1 * Subtract1_out1;
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


  b_1_cast <= signed(resize(Constant_out1_1, 17));
  b_1_mul_temp <= b_1_cast * Subtract1_out1;
  b_1_cast_1 <= b_1_mul_temp(31 DOWNTO 0);
  b_1_out1 <= b_1_cast_1(30 DOWNTO 15);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      b_1_out1_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_const_rate = '1' THEN
        b_1_out1_1 <= b_1_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Constant1_out1 <= to_signed(-16#6CF4#, 16);

  HwModeRegister2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Constant1_out1_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_const_rate = '1' THEN
        Constant1_out1_1 <= Constant1_out1;
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


  b_3_mul_temp <= Constant1_out1_1 * Delay1_out1_1;
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


  Sum1_add_cast <= resize(b_1_out1_1, 32);
  Sum1_add_cast_1 <= resize(b_3_out1_1, 32);
  Sum1_add_temp <= Sum1_add_cast + Sum1_add_cast_1;
  Sum1_out1 <= Sum1_add_temp(16 DOWNTO 1);

  Out1 <= std_logic_vector(Sum1_out1);

  ce_out <= clk_enable;

END rtl;

