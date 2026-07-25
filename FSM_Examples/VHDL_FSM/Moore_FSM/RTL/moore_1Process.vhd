
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Moore_1Process is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           din : in STD_LOGIC;
           dout : out STD_LOGIC);
end Moore_1Process;

architecture Behavioral of Moore_1Process is
type moore_state is(S0,S1);
signal state_reg : moore_state;
begin
reset_Process:process(clk)
begin
    if(rising_edge(clk)) then
     if(rst = '1') then
        state_reg <= S0;
    else
       case(state_reg) is
        when S0 => 
            dout <='0';
            if(din ='1') then
              state_reg <= S1;
            else
              state_reg <= S0;
            end if;
        when S1 => 
             dout <='1';
            if(din ='1') then
              state_reg <=s0;
            else
              state_reg <=s1;
            end if;
        when others =>
            dout <='0'; 
        state_reg <= s0;
        end case;
        
    end if;
    end if;
end process;

end Behavioral;
