library ieee;
use ieee.std_logic_1164.all;

entity Traffic_light_FSM is
port(
    clk, rst    : in std_logic;
    r , g , y   : out std_logic
);
end Traffic_light_FSM;

architecture behav of Traffic_light_FSM is 
type traffic_FSM is(red, green, yellow);
signal state_next, state_reg : traffic_FSM;
signal counter_reg, counter_next : integer range 0 to 10:=0;
signal r_next,r_reg : std_logic;
signal g_next,g_reg : std_logic;
signal y_next,y_reg : std_logic;
begin
Reset_process:process(clk)
begin
    if(rising_edge(clk)) then
        if(rst = '1') then
           r_reg <= '0';
           y_reg <= '0'; 
           g_reg <= '0'; 
           state_reg <= red;
           counter_reg <=0;
        else
           r_reg <= r_next;
           y_reg <= y_next; 
           g_reg <= g_next; 
           state_reg <= state_next;
           counter_reg <= counter_next;
        end if;
           
    end if;
end process;

logic_out_process:process(state_reg,counter_reg,r_reg,g_reg,y_reg)
begin
     state_next   <= state_reg;
    counter_next <= counter_reg;

    r_next <= r_reg;
    g_next <= g_reg;
    y_next <= y_reg;
    case(state_reg) is 
        when red=> 
                r_next <='1';
                g_next <='0';
                y_next <='0';
                if(counter_reg < 9) then
                state_next <= red;
                counter_next <= counter_reg +1;
                else
                state_next <= green;
                counter_next <=0;
               end if;
        when green=> 
                r_next <='0';
                g_next <='1';
                y_next <='0';
                if(counter_reg < 9) then
                state_next <= green;
                counter_next <= counter_reg +1;
                else
                state_next <= yellow;
                counter_next <=0;
               end if;
            
        when yellow=> 
                r_next <='0';
                g_next <='0';
                y_next <='1';
                if(counter_reg < 9) then
                state_next <= yellow;
                counter_next <= counter_reg +1;
                else
                state_next <= red;
                counter_next <=0;
               end if;
        when others=> 
                
                r_next <='0';
                g_next <='0';
                y_next <='0';
                state_next <= red;
                counter_next <=0;
        end case;
end process;

r <= r_reg;
g <= g_reg;
y <= y_reg;
end behav;