library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cache is
	port (
		clk, iread, iwrite: in std_logic;
		memin: in std_logic_vector(15 downto 0);
		address: in std_logic_vector(9 downto 0);
		dataready, readmem, writemem: out std_logic;
		in_data: in std_logic_vector(15 downto 0);
		out_data: out std_logic_vector(15 downto 0)
	);
end cache;

architecture rtl of cache is

component mux2to1 is
	port (
		s0, s1:in std_logic_vector(15 downto 0);
		iselect: in std_logic;
		iout: out std_logic_vector(15 downto 0)
	);
end component;

component tbuffer is
    Port ( A    : in  std_logic_vector(15 downto 0);    -- single buffer input
           EN   : in  STD_LOGIC;    -- single buffer enable
           Y    : out std_logic_vector(15 downto 0));   -- single buffer output
end component;

component data_arr is
	port (
		clk, wren: in std_logic;
		address: in std_logic_vector(5 downto 0);
		wrdata: in std_logic_vector(15 downto 0);
		
		data: out std_logic_vector(15 downto 0)
	);
end component;

component hit_miss_logic is
	port (
		tag: in std_logic_vector(3 downto 0);
		w0, w1: in std_logic_vector(4 downto 0);
		
		hit, w0_valid, w1_valid: out std_logic	
	);
end component;

component tag_valid_arr is
	port (
		clk, reset_n, wren, invalidate, validate: in std_logic;
		address: in std_logic_vector(5 downto 0);
		wrdata: in std_logic_vector(3 downto 0);
		
		output: out std_logic_vector(4 downto 0)

	);
end component;

component cache_controller is
	port (
		iread, iwrite, hit, s, clk, valid0, valid1: in std_logic;
		dataready, readmem, writemem, data_wren0, data_wren1, tag_arr_wren0, tag_arr_wren1,
			mem_on_out, validate0, validate1, mem_on_data_arr: out std_logic
	);
end component;

component mru is
	port (
		clk, w0_en, w1_en: in std_logic;
		address: in std_logic_vector(5 downto 0);
		s: out std_logic
	);
end component;

signal mru_wr0, mru_wr1, data_wren0, data_wren1, s, mem_on_out, nmem_on_out, mem_on_data_arr: std_logic;
signal data0, data1, cache_data, cdata, data_arr_in: std_logic_vector(15 downto 0);

signal w0, w1: std_logic_vector(4 downto 0);
signal hit, w0_valid, w1_valid: std_logic;

signal reset_n0, tag_arr_wren0, invalidate0, validate0, valid0: std_logic;
signal reset_n1, tag_arr_wren1, invalidate1, validate1, valid1: std_logic;

begin
nmem_on_out<=not(mem_on_out);
valid0<=w0(4); valid1<=w1(4);
d0: data_arr port map(clk, data_wren0, address(5 downto 0), data_arr_in, data0);
d1: data_arr port map(clk, data_wren1, address(5 downto 0), data_arr_in, data1);

mux1: mux2to1 port map(in_data, memin, mem_on_data_arr, data_arr_in);

hit0: hit_miss_logic port map(address(9 downto 6), w0, w1, hit, w0_valid, w1_valid);

t0: tag_valid_arr port map(clk, reset_n0, tag_arr_wren0, invalidate0, validate0, address(5 downto 0),
	address(9 downto 6), w0);

t1: tag_valid_arr port map(clk, reset_n1, tag_arr_wren1, invalidate1, validate1, address(5 downto 0),
	address(9 downto 6), w1);


mux0: mux2to1 port map(data0, data1, s, cache_data);
buff0: tbuffer port map(cache_data, nmem_on_out, cdata); --has to be buffer
buff1: tbuffer port map(cdata, iread, out_data);

control0: cache_controller port map(iread, iwrite, hit, s, clk, valid0, valid1,
		dataready, readmem, writemem, data_wren0, data_wren1, tag_arr_wren0, tag_arr_wren1,
			mem_on_out, validate0, validate1, mem_on_data_arr);

mru_wr0<=w0_valid;
mru_wr1<=w1_valid;

mru0: mru port map(clk, mru_wr0, mru_wr1, address(5 downto 0), s);

end rtl;
