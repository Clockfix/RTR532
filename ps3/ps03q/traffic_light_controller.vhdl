---------------------------------------------------------------- 
-- Author - Imants Pulkstenis
-- Date - 23.02.2020
-- Project name - PS03
-- Module name - Smart traffic light controler
--
-- Detailed module description:
--
-- Task is to develop a Smart Traffic Light Controller VHDL 
-- module using finite state machine principle (FSM).  
-- 
-- Port description  
-- | Port name  | Direction  | Description                                                                                                              |
-- |------------|------------|--------------------------------------------------------------------------------------------------------------------------|
-- | Clk        | In         | 1 GHz clock (1 ns period)                                                                                                |
-- | Rst        | In         | Active low reset                                                                                                         |
-- | MR_cars    | In         | An 8-bit input signal indicating the number of waiting cars at the secondary road traffic light. Interpret as unsigned.  |
-- | MR_ctl     | Out        | Main road traffic light controlling signal                                                                               |
-- | SR_ctl     | Out        | Secondary road traffic light controlling signal                                                                          |

-- Output light mapping for MR_ctl and SR_ctl signals to be used 
-- | Value (2bit binary)  | Light output                      |
-- |----------------------|-----------------------------------|
-- | 00                   | No light – traffic light is dark  |
-- | 01                   | Red light                         |
-- | 10                   | Yellow light                      |
-- | 11                   | Green light                       |
--
-- When rst is low, outputs should be dark, no light visible 
-- When rst is high then: 
--     Minimum main road green period length should be at least 30 nanoseconds. When green period ends: 
--         If there are zero cars waiting on the secondary road, then main road starts the green state again 
--         If there are less than PARAMETER cars waiting on the secondary road, green period length is extended 
--         by 30 nanoseconds and then switches to red (and secondary to green) 
--         If there are equals/more than PARAMETER cars waiting on the secondary road, main road switches to red (and secondary to green) 
--     Secondary road green period length is 10 nanoseconds, after that, main road switches to green (and secondary to red) 
--     Each transition (red to green and green to red) should go through 3 nanoseconds yellow light. Yellow lights can happen at the same 
--     time in both traffic directions. 
-- MR_ctl and SR_ctl both must not be green at the same time to avoid traffic accidents. 
-- PARAMETER = 45.  
--
-- Revision:
-- A - initial design
-- B - 
-- C - 
--
------------------------------------------------------------------

-- define libraries to be used [part 2 of the VHDL file]
library ieee;						--always use this library
use ieee.std_logic_1164.all;	--always use this library
use ieee.numeric_std.all;		--use this library if arithmetic required

--Entity declaration [part 3 of the VHDL file].
entity traffic_light_controller is
    generic
    (
        PARAMETER : integer := 45
    );
    port
    (
        clk 		: in std_logic;
        rst 		: in std_Logic;
        MR_cars 	: in std_logic_vector(7 downto 0);
        MR_ctl 		: out std_logic_vector(2 downto 0);
        SR_ctl		: out std_logic_vector(2 downto 0)
    );
    end smart_tl_ctl;

--define inside of the module
architecture behavioral of alu is
	--define inside use signals and components [part 4 of the VHDL file]
	signal state 	: std_logic_vector(2 downto 0) := "000";  --2b state
	signal cnt		: std_logic_vector(7 downto 0) := x"00"; --8b counter


begin
    --define the operation of the module! [part 5 of the VHDL file]
     
process(clk)
begin
	if rising_edge(clk) then
        if rst = '0' then
			state <= "000";
			cnt <= x"00";
        else
        case state is
            when "000" => -- lights off secs
                cnt <= 0;
                state <= "001";
                MR_ctl <= "00";
	            SR_ctl <= "00";    
            when "001" => -- MR green light 30 ns
                MR_ctl <= "11";
                SR_ctl <= "01"; 
                if cnt >= 30 then 
                    if MR_cars == 0 then
                        cnt <= 0;
                        state <= "001";
                    else if MR_cars < PARAMETER then
                        cnt <= 0;
                        state <= "010";
                    else 
                        cnt <= 0;
                        state <= "011";
                        end if; 
                    end if; 
                else      
                    cnt <= cnt + 1;
                    state <= "001";
                end if;				
            when "010" => -- MR green light 30 ns
                MR_ctl <= "11";
                SR_ctl <= "01";         
                if cnt < 30 then 
                    cnt <= cnt + 1;
                    state <= "010";
                else      
                    cnt <= 0;
                    state <= "011";
                end if;					
            when "011" => -- MR yellow light 3 ns
                MR_ctl <= "10";
                SR_ctl <= "10";        
                if cnt < 3 then 
                    cnt <= cnt + 1;
                    state <= "011";
                else 
                    cnt <= 0;
                    state <= "100";
                end if;	
            when "100" => -- SR green light 10 ns
                MR_ctl <= "01";
                SR_ctl <= "11"; 
                if cnt < 10 then 
                    cnt <= cnt + 1;
                    state <= "100";
                else 
                    cnt <= 0;
                    state <= "101";
                end if;
            when "101" => -- SR yellow light 3 ns
                MR_ctl <= "10";
                SR_ctl <= "10";         
                if cnt < 3 then 
                    cnt <= cnt + 1;
                    state <= "101";
                else 
                    cnt <= 0;
                    state <= "001";
                end if;	           
            when others =>
                cnt <= 0;
                state <= "000";				
            
        end case;
        end if;
    end if;
end process;

end behavioral;