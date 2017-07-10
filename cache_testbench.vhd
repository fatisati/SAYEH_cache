library IEEE;
use IEEE.std_logic_1164.all;

entity cache_testbench is
end entity cache_testbench;

architecture rtl of cache_testbench is

	component cache_mem is
	port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : inout std_logic_vector (15 downto 0);
		memdataready, dataready : out std_logic);
	end component;
	
	signal clk, readmem, writemem : std_logic := '0';
	signal addressbus: std_logic_vector (15 downto 0);
	signal	databus : std_logic_vector (15 downto 0);
	signal	memdataready, dataready : std_logic;
	
	
begin
	cashe0: cache_mem port map(clk, readmem, writemem,
		addressbus,
		databus,
		memdataready, dataready);
		
	--controller_rst <= '0', '1' after 5 ns ;
	--indatabus <= "0000000000000100";
	readmem<='0', '1' after 60 ns, '0' after 120 ns,'1' after 180 ns;
	writemem<='0';--, '1' after 140 ns;
	databus<="ZZZZZZZZZZZZZZZZ";--, "0000000000000100" after 140 ns;
	addressbus<="0000000000000100", "0000000001000100" after 150 ns, "0000000000000100" after 300 ns;
	clk <= not clk after 10 ns;

end architecture;
