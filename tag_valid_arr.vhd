library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tag_valid_arr is
	port (
		clk, reset_n, wren, invalidate, validate: in std_logic;
		address: in std_logic_vector(5 downto 0);
		wrdata: in std_logic_vector(3 downto 0);
		
		output: out std_logic_vector(4 downto 0)

	);
end tag_valid_arr;

architecture rtl of tag_valid_arr is

type reg is array(0 to 63) of std_logic_vector(4 downto 0);
signal registers : reg := (others => (others => '0'));
 
begin
output<=registers(to_integer(unsigned(address)));

process(clk)
begin
	if(clk='0')then
	if(wren='1')then
		registers(to_integer(unsigned(address)))(3 downto 0)<=wrdata;
	end if;
	
	if(invalidate='1')then
		registers(to_integer(unsigned(address)))(4)<='0';
	end if;

	if(validate='1')then
		registers(to_integer(unsigned(address)))(4)<='1';
	end if;
	end if;
end process;

end rtl;
