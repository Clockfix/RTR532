-----------------------------
-- Author - Kriss Osmanis 
-- Date - 2017-02-25; 2019-02-20
-- Project name - PS02
-- Module name - PS02 signal generator
--
-- Detailed module description
-- generates values for A, B, op
--
--
-- Revision:
-- A - initial design
-- B - modified op seq
--
-----------------------------
library ieee;						--always use this library
use ieee.std_logic_1164.all;	--always use this library
use ieee.numeric_std.all;		--use this library if arithmetic required


--define connections to outside
entity ps02_siggen is
generic
(
	data_width : integer := 32
);
port
(
	clk 		: in std_logic;
	rst		: in std_logic;
	A 			: out std_Logic_vector(data_width - 1 downto 0);
	B 			: out std_logic_vector(data_width - 1 downto 0);
	op 		: out std_logic_vector(3 downto 0)
);
end ps02_siggen;

--define inside of the module
architecture behavioral of ps02_siggen is
	--define inside use signals
	
	signal op_cnt : unsigned(3 downto 0) := x"0";

	type A_B_value_array is array (0 to 15) of std_logic_vector(data_width - 1 downto 0);
	signal A_list : A_B_value_array := 
	(
		std_logic_vector(to_signed(-15,data_width)), --sub
		std_logic_vector(to_signed(-14,data_width)), --add
		x"0000DEAD", --nand
		x"0000BEEF", --and
		x"0000ABCD", --or
		x"0000EFAD", --nor
		x"00001279", --xor
		x"00000310", --not a
		x"00003010", --not b
		std_logic_vector(to_signed(-1,data_width)),--incr B
		std_logic_vector(to_signed(0,data_width)),--incr A
		std_logic_vector(to_signed(0,data_width)),--sub A
		std_logic_vector(to_signed(0,data_width)),--sub B
		x"00000F0F",--sll A
		x"00000000",--sll B
		x"00001234"--noop
	);


	signal B_list : A_B_value_array :=
	(
		std_logic_vector(to_signed(37,data_width)), --sub
		std_logic_vector(to_signed(-999,data_width)), --add
		x"00001221", --nand
		x"00000FF0", --and
		x"0000F00F", --or
		x"00008754", --nor
		x"0000ADBF", --xor
		x"0000FECD", --not a
		x"0000CCDC", --not b
		std_logic_vector(to_signed(0,data_width)),--incr B
		std_logic_vector(to_signed(-1,data_width)),--incr A
		std_logic_vector(to_signed(0,data_width)),--sub A
		std_logic_vector(to_signed(0,data_width)),--sub B
		x"0000F0F0",--sll A
		x"0000ABAB",--sll B
		x"00004321"--noop
	);
	
begin
	--define the operation of the module!

	A <= A_list(to_integer(op_cnt));
	b <= B_list(to_integer(op_cnt));
		
	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				op_cnt <= (others => '0'); --zero counter on rst
			else
				op_cnt <= op_cnt + 1;
			end if;
		end if;
	end process;


end behavioral;





