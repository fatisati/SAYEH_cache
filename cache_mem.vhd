library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cache_mem is
	port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : inout std_logic_vector (15 downto 0);
		memdataready, dataready : out std_logic);
end cache_mem;

architecture rtl of cache_mem is

component memory is

	port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : inout std_logic_vector (15 downto 0);
		memdataready : out std_logic);
end component;

component cache is
	port (
		clk, iread, iwrite: in std_logic;
		memin: in std_logic_vector(15 downto 0);
		address: in std_logic_vector(9 downto 0);
		dataready, readmem, writemem: out std_logic;
		in_data: in std_logic_vector(15 downto 0);
		out_data: out std_logic_vector(15 downto 0)
	);
end component;

signal ireadmem, iwritemem: std_logic;

begin

mem0: memory port map(clk, ireadmem, iwritemem, addressbus, databus, memdataready);
chache0: cache port map(clk, readmem, writemem, databus, addressbus(9 downto 0), dataready
			, ireadmem, iwritemem, databus, databus);	
	
end rtl;
