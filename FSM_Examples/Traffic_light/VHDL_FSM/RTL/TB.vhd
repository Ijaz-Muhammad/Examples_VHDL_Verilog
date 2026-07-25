----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2026 19:10:48
-- Design Name: 
-- Module Name: TB - Behavioral
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

entity TB is
end TB;

architecture Behavioral of TB is
component Traffic_light_FSM is
port(
    clk, rst    : in std_logic;
    r , g , y   : out std_logic
);
end component;

signal clk : std_logic :='0';
signal rst : std_logic :='0';
signal r,g,y: std_logic;
begin
uut: Traffic_light_FSM port map(
                                clk => clk,
                                rst => rst,
                                r   => r,
                                g   => g,
                                y   =>y
                                );
clk_gen:process(clk)
begin

clk <= not clk after 5ns;
end process;

sitmu:process
begin
    rst <='1' ;
    wait for 10ns;
    rst <='0' ;
    wait for 10ns;
    wait;
end process;
end Behavioral;
