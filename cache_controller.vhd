library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cache_controller is
	port (
		iread, iwrite, hit, s, clk, valid0, valid1: in std_logic;
		dataready, readmem, writemem, data_wren0, data_wren1, tag_arr_wren0, tag_arr_wren1,
			mem_on_out, validate0, validate1, mem_on_data_arr: out std_logic
	);
end cache_controller;

architecture rtl of cache_controller is

type state is (s0, s1, s2);
signal current_state : state;
signal next_state : state;

begin

process (clk)
	begin
		
		if (clk'event and clk = '0') then
			current_state <= next_state;
			
		end if;
end process;

process(current_state, clk)
begin

	case current_state is
		
		when s0=>
			mem_on_data_arr<='0'; readmem<='0';
			dataready<='0'; validate0<='0'; validate1<='0'; mem_on_out<='0'; writemem<='0';
				data_wren0<='0'; tag_arr_wren0<='0';
				data_wren1<='0'; tag_arr_wren1<='0';
			if(iread='1' or iwrite ='1')then
				next_state<=s1;
			end if;
		when s1=>
			next_state<=s2;
			if(iread='1')then
				if(hit = '1')then
					 dataready<='1'; --next_state<=s0;
				else
					mem_on_data_arr<='1';
					readmem<='1'; mem_on_out<='1'; --next_state<=s2;
				end if;
			end if;

			if(iwrite='1')then
				writemem<='1'; next_state<=s2;
				if(valid0='0')then
					data_wren0<='1'; tag_arr_wren0<='1'; validate0<='1';
				elsif(valid1 = '0')then
					data_wren1<='1'; tag_arr_wren1<='1'; validate1<='1';
				elsif(s='0')then
					data_wren0<='1'; tag_arr_wren0<='1'; validate0<='1';
				else
					data_wren1<='1'; tag_arr_wren1<='1'; validate1<='1';
				end if;
			end if;
			

		when s2=>
			next_state<=s0;
			if(iread='1' and hit='0')then
				dataready<='1'; 
			
					if(valid0='0')then
						data_wren0<='1'; tag_arr_wren0<='1'; validate0<='1';
					elsif(valid1 = '0')then
						data_wren1<='1'; tag_arr_wren1<='1'; validate1<='1';
					elsif(s='0')then
						data_wren0<='1'; tag_arr_wren0<='1'; validate0<='1';
					else
						data_wren1<='1'; tag_arr_wren1<='1'; validate1<='1';
					end if;
				
			end if;
		end case;
		
end process;
		
end rtl;
