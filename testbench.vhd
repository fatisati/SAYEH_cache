library IEEE;
use IEEE.std_logic_1164.all;

entity main_t is
end entity main_t;

architecture rtl of main_t is

	component datapath
		port (
		clk, controller_rst, memdataready: in std_logic;
		databus: inout std_logic_vector(15 downto 0);
		addressbus: out std_logic_vector (15 downto 0);
		instruction0: out std_logic_vector (7 downto 0);
		readmem, writemem, readio, writeio: out std_logic
	);
	end component;
	
	component memory
		port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : inout std_logic_vector (15 downto 0);
		memdataready : out std_logic);
	end component;

	component cache_mem is
	port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : inout std_logic_vector (15 downto 0);
		memdataready, dataready : out std_logic);
	end component;
	
	
	signal clk : std_logic := '0';
	signal controller_rst, memdataready, dataready:  std_logic;
	signal	databus:  std_logic_vector(15 downto 0);
	--signal	outdatabus:  std_logic_vector(15 downto 0);
	signal	addressbus:  std_logic_vector (15 downto 0);
	signal instruction0: std_logic_vector(7 downto 0);
	signal	readmem, writemem, readio, writeio: std_logic;
	
begin
	d : datapath port map(clk, controller_rst, dataready,
		databus, addressbus, instruction0,
		readmem, writemem, readio, writeio);
		
	cache_mem0: cache_mem port map(clk, readmem, writemem,
		addressbus,databus ,memdataready, dataready);

	--memory0: memory port map(clk, readmem, writemem,
		--addressbus,databus ,memdataready);
		
	controller_rst <= '0', '1' after 5 ns ;
	--indatabus <= "0011001100000000";
	clk <= not clk after 10 ns;

end architecture;
