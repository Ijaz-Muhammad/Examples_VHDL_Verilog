
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Moore_3Process is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           din : in STD_LOGIC;
           dout : out STD_LOGIC);
end Moore_3Process;

architecture Behavioral of Moore_3Process is
type moore_state is(S0,S1);
signal state_next, state_reg : moore_state;
begin
reset_Process:process(clk)
begin
    if(rising_edge(clk)) then
     if(rst = '1') then
        state_reg <= S0;
    else
        state_reg <= state_next;
    end if;
    end if;
end process;

next_state_Process:process(din, state_reg)
begin
case(state_reg) is
when S0 => 
    if(din ='1') then
      state_next <= S1;
    else
      state_next <= S0;
    end if;
when S1 => 
    if(din ='1') then
      state_next <=s0;
    else
      state_next <=s1;
    end if;
when others => 
state_next <= s0;

end case;
end process;

output_Process:process(din, state_reg)
begin
case (state_reg) is
when s0 => 
    dout <='0';
when s1 =>
    dout <= '1';
when others => 
    dout <='0';
end case;
end process;
end Behavioral;
