
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mealy_1Process is
 Port ( 
clk, rst        : in std_logic;
    din         : in std_logic;
dout            : out std_logic            
 );
end Mealy_1Process;

architecture Behavioral of Mealy_1Process is
type state_machine is(S0,S1);
signal State_reg : state_machine;

begin
mealy_1Process: process(clk)
begin
    if(rising_edge(clk)) then
        if(rst ='1') then
            State_reg <= S0;
        else
            case(state_reg) is
when S0 => 
    if(din ='1') then 
        state_reg <= S1;
        dout <= '0';
    else 
        state_reg <= S0;
        dout <= '0';
    end if;
when S1 => 
    if(din ='1') then
        state_reg <= S0;
        dout <='1';
    else
        state_reg <= S1;
        dout <='0';
    end if;
when others=> 
    state_reg <= S0;
    dout <= '0';
end case;
        end if;
     end if;
end process;
end Behavioral;
