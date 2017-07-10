library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity hit_miss_logic is
	port (
		tag: in std_logic_vector(3 downto 0);
		w0, w1: in std_logic_vector(4 downto 0);
		
		hit, w0_valid, w1_valid: out std_logic	
	);
end hit_miss_logic;

architecture rtl of hit_miss_logic is

signal iw0_valid, iw1_valid: std_logic;
begin
	w0_valid<=iw0_valid;
	w1_valid<=iw1_valid;

	hit<= iw0_valid or iw1_valid;
 	process(tag, w0, w1)
	begin
		if(w0(4)='1' and w0(3 downto 0)=tag)then
			iw0_valid<='1';
		else
			iw0_valid<='0';
		end if;

		if(w1(4)='1' and w1(3 downto 0)=tag)then
			iw1_valid<='1';
		else
			iw1_valid<='0';
		end if;
	end process;
end rtl;
