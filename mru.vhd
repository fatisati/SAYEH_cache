library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mru is
	port (
		clk, w0_en, w1_en: in std_logic;
		address: in std_logic_vector(5 downto 0);
		s: out std_logic
	);
end mru;

architecture rtl of mru is

type reg is array(0 to 63) of std_logic_vector(1 downto 0);
signal registers : reg := (others => (others => '0'));

begin

s<= '1' when(registers(to_integer(unsigned(address)))(1)='1') else '0';

process(clk)
begin
	if(w0_en='1')then
		registers(to_integer(unsigned(address)))(0)<='1';
		registers(to_integer(unsigned(address)))(1)<='0';

	elsif(w1_en='1')then
		registers(to_integer(unsigned(address)))(0)<='0';
		registers(to_integer(unsigned(address)))(1)<='1';
	end if;
end process;
end rtl;
