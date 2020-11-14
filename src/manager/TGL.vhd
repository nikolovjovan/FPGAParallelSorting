library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TGL is

	generic
	(
		default_value: std_logic := '0'
	);

	port 
	(
		toggle : in  std_logic := '0';
		state  : out std_logic
	);

end entity;

architecture rtl of TGL is
	signal state_next:std_logic := default_value;
begin
	state <= state_next;
	
	process (toggle)
	begin
		if toggle = '1' then
			state_next <= not state_next;
		end if;
	end process;
end rtl;