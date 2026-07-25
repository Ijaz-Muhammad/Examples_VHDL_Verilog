library ieee;
use ieee.std_logic_1164.all;

entity TB_VHDL_SD is
end TB_VHDL_SD;

architecture beh of TB_VHDL_SD is
component Seq_Detector is
port(   
        clk, rst, din : in std_logic;
        seq_detect        : out std_logic
        );
end component;

signal clk : std_logic:='0';
signal rst,din : std_logic;
signal seq_det      : std_logic;
begin
UUT1:Seq_Detector port map(
                            clk => clk,
                            rst => rst,
                            din => din,
                            seq_detect => seq_det
                            );
Stem:process(clk)
begin
clk <= not clk after 5ns;
end process;

init:process
begin
    rst <= '1';
    din <= '0';
    wait for 100ns;
    rst <='0';
    wait for 20ns;
    din <= '1';
    wait for 10ns;
    din <= '0';
    wait for 10ns;
    din <= '1';
    wait for 10ns;
    din <= '1';
    wait for 10ns;
    din <= '1';
    wait for 10ns;
    din <= '0';
    wait for 10ns;
    din <= '1';
    wait for 10ns;
    din <= '1';
    wait for 10ns;
    din <= '1';
    wait for 10ns;
    din <= '0';
  wait;  
end process;

end beh;