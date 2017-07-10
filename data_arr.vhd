library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_arr is
	port (
		clk, wren: in std_logic;
		address: in std_logic_vector(5 downto 0);
		wrdata: in std_logic_vector(15 downto 0);
		
		data: out std_logic_vector(15 downto 0)
	);
end data_arr;

architecture rtl of data_arr is

type reg is array(0 to 63) of std_logic_vector(15 downto 0);
signal registers : reg;

begin	

	data<= registers(to_integer(unsigned(address)));

	process(clk)
	begin

		if(wren='1' and clk='1')then
			registers(to_integer(unsigned(address)))<=wrdata;
		end if;

	end process;
 
end rtl;
