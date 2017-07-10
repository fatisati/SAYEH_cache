library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tbuffer is
    Port ( A    : in  std_logic_vector(15 downto 0);    -- single buffer input
           EN   : in  STD_LOGIC;    -- single buffer enable
           Y    : out std_logic_vector(15 downto 0));   -- single buffer output
end tbuffer;

architecture Behavioral of tbuffer is

begin

    -- single active low enabled tri-state buffer
    Y <= A when (EN = '1') else "ZZZZZZZZZZZZZZZZ";
    
end Behavioral;
