library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CDX is
	generic
	(
		size : natural := 4
	);
	port 
	(
		EN : in  std_logic := '1';
		X  : in  std_logic_vector((2**size) - 1 downto 0);
		Y  : out std_logic_vector(size - 1 downto 0)
	);
end entity;

architecture rtl of CDX is
begin
	process (EN, X)
		variable temp: integer range 0 to (2**size) - 1;
	begin
		Y <= (others => '0');
		if (EN = '1') then
			for i in X'range loop
				if (X(i) = '1') then
					temp := i;
					exit;
				else
					temp := 0;
				end if;
			end loop;
			Y <= std_logic_vector(to_unsigned(temp, Y'length));
		end if;
	end process;
end rtl;