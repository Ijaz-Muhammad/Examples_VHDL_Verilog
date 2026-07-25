----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2026 11:26:41
-- Design Name: 
-- Module Name: Mealy_3Process - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mealy_2Process is
 Port ( 
clk, rst        : in std_logic;
    din         : in std_logic;
dout            : out std_logic            
 );
end Mealy_2Process;

architecture Behavioral of Mealy_2Process is
type state_machine is(S0,S1);
signal state_next, State_reg : state_machine;

begin
reset_logic_process: process(clk)
begin
    if(rising_edge(clk)) then
        if(rst ='1') then
            State_reg <= S0;
        else
            State_reg <=state_next;
        end if;
     end if;
end process;

state_and_ouput_process:process(din, state_reg)
begin
case(state_reg) is
when S0 => 
    if(din ='1') then 
        state_next <= S1;
        dout <= '0';
    else 
        state_next <= S0;
        dout <= '0';
    end if;
when S1 => 
    if(din ='1') then
        state_next <= S0;
        dout <='1';
    else
        state_next <= S1;
        dout <='0';
    end if;
when others=> 
    state_next <= S0;
    dout <= '0';
end case;

end process;


end Behavioral;
