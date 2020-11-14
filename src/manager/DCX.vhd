library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DCX is
	generic
	(
		size : natural := 8
	);
	port 
	(
		EN : in  std_logic := '1';
		X  : in  std_logic_vector(size - 1 downto 0);
		Y  : out std_logic_vector((2**size) - 1 downto 0)
	);
end entity;

architecture rtl of DCX is
begin
	process (EN, X)
	begin
		Y <= (others => '0');
		if (EN = '1') then
			Y(to_integer(unsigned(X))) <= '1';
		end if;
	end process;
end rtl;