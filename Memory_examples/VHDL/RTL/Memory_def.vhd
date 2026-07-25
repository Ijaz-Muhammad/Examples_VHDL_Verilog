--------------- default vivado will create distributted memory for this size of memoru
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use ieee.numeric_std.all;

--entity Memory_def is
--Port (  clk, wr : in std_logic;
--        addr    : in std_logic_vector(5 downto 0);--64 depth memory 
--        din     : in std_logic_vector(7 downto 0);--8 bit wide memory 
--        dout    : out std_logic_vector(7 downto 0)
--         );
--end Memory_def;

--architecture Behavioral of Memory_def is
--type memory_type is array (0 to 63) of std_logic_vector(7 downto 0);
--signal mem: memory_type;
--begin
--process(clk)
--begin
--    if(rising_edge(clk)) then
--        if(wr ='1') then
--            mem(to_integer(unsigned(addr))) <= din;
--        else
--            dout <= mem(to_integer(unsigned(addr)));
--        end if;
--    end if;
--end process;
--end Behavioral;
-------------- 
----------------
--------------
----------------
----------
---------------------- when we increase the size vivado will select the BRAM 
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use ieee.numeric_std.all;

--entity Memory_def is
--Port (  clk, wr : in std_logic;
--        addr    : in std_logic_vector(9 downto 0);--64 depth memory 
--        din     : in std_logic_vector(31 downto 0);--8 bit wide memory 
--        dout    : out std_logic_vector(31 downto 0)
--         );
--end Memory_def;

--architecture Behavioral of Memory_def is
--type memory_type is array (0 to 1023) of std_logic_vector(31 downto 0);
--signal mem: memory_type;
--begin
--process(clk)
--begin
--    if(rising_edge(clk)) then
--        if(wr ='1') then
--            mem(to_integer(unsigned(addr))) <= din;
--        else
--            dout <= mem(to_integer(unsigned(addr)));
--        end if;
--    end if;
--end process;
--end Behavioral;
---------------------- Attiributes that dectate the vivado to distributed rame
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use ieee.numeric_std.all;

--entity Memory_def is
--Port (  clk, wr : in std_logic;
--        addr    : in std_logic_vector(9 downto 0);--64 depth memory 
--        din     : in std_logic_vector(31 downto 0);--8 bit wide memory 
--        dout    : out std_logic_vector(31 downto 0)
--         );
--end Memory_def;

--architecture Behavioral of Memory_def is
--type memory_type is array (0 to 1023) of std_logic_vector(31 downto 0);
--signal mem: memory_type;
---- Declare the attribute and tie it to your memory signal
--attribute ram_style : string;
--attribute ram_style of mem : signal is "distributed";
--begin
--process(clk)
--begin
--    if(rising_edge(clk)) then
--        if(wr ='1') then
--            mem(to_integer(unsigned(addr))) <= din;
--        else
--            dout <= mem(to_integer(unsigned(addr)));
--        end if;
--    end if;
--end process;
--end Behavioral;

---------------------- Attiributes that dectate the vivado to Block rame
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Memory_def is
Port (  clk, wr : in std_logic;
        addr    : in std_logic_vector(9 downto 0);--64 depth memory 
        din     : in std_logic_vector(31 downto 0);--8 bit wide memory 
        dout    : out std_logic_vector(31 downto 0)
         );
end Memory_def;

architecture Behavioral of Memory_def is
type memory_type is array (0 to 1023) of std_logic_vector(31 downto 0);
signal mem: memory_type;
-- Declare the attribute and tie it to your memory signal
--attribute ram_style : string;
--attribute ram_style of mem : signal is "distributed";
-- Force Vivado to use Block RAM (BRAM)
 attribute ram_style : string;
 attribute ram_style of mem : signal is "block";
begin
process(clk)
begin
    if(rising_edge(clk)) then
        if(wr ='1') then
            mem(to_integer(unsigned(addr))) <= din;
        else
            dout <= mem(to_integer(unsigned(addr)));
        end if;
    end if;
end process;
end Behavioral;
