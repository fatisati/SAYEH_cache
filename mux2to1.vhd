library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mux2to1 is
	port (
		s0, s1:in std_logic_vector(15 downto 0);
		iselect: in std_logic;
		iout: out std_logic_vector(15 downto 0)
	);
end mux2to1;

architecture rtl of mux2to1 is
begin
	iout<=s0 when(iselect='0')else s1;
 
end rtl;
