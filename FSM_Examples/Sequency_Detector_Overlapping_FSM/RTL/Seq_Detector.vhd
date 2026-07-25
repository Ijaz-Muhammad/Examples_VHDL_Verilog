
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Seq_Detector is
Port ( 
    clk, rst, din : in std_logic;
    seq_detect  : out std_logic
);
end Seq_Detector;

architecture Behavioral of Seq_Detector is
type Seq_detector_FSM is (S0,S1,S2,S3);
signal seq_detect_reg,seq_detect_next : std_logic;
signal state_next,state_reg: Seq_detector_FSM;
begin
-- reset logic process 
reset_process:process(clk)
begin
    if(rising_edge(clk)) then
        if(rst ='1') then
            state_reg <= S0;
            seq_detect_reg <= '0';
        else
            state_reg <= state_next;
            seq_detect_reg <= seq_detect_next;
        end if;
    end if;
end process;

-- nextstate_and Output logic process 
state_output_process: process(din, state_reg)
begin
    case(state_reg) is 
        when S0 =>  
            if(din = '1')then 
                seq_detect_next <='0';
                state_next <= S1;
            else 
                seq_detect_next <='0';
                state_next <= S0;
            end if;
        when S1 =>
            if(din = '1')then 
                seq_detect_next <='0';
                state_next <= S1;
            else 
                seq_detect_next <='0';
                state_next <= S2;
            end if;  
        when S2 => 
            if(din = '1')then 
                seq_detect_next <='0';
                state_next <= S3;
            else 
                seq_detect_next <='0';
                state_next <= S0;
            end if; 
        when S3 =>  
            if(din = '1')then 
                seq_detect_next <='1';
                state_next <= S0;
            else 
                seq_detect_next <='0';
                state_next <= S2;
            end if;
        when others=> 
                seq_detect_next <='0';
                state_next <= S0;
    end case;
end process;
seq_detect <=seq_detect_reg;

end Behavioral;
