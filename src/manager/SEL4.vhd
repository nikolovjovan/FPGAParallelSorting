library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SEL4 is
	port 
	(
		X3 : in  std_logic;
		X2 : in  std_logic;
		X1 : in  std_logic;
		X0 : in  std_logic;
		Y3 : out std_logic := '0';
		Y2 : out std_logic := '0';
		Y1 : out std_logic := '0';
		Y0 : out std_logic := '0'
	);
end entity;

architecture rtl of SEL4 is
begin
	process (X3, X2, X1, X0)
	begin
		Y3 <= '0';
		Y2 <= '0';
		Y1 <= '0';
		Y0 <= '0';
		if (X3 = '1') then    Y3 <= '1';
		elsif (X2 = '1') then Y2 <= '1';
		elsif (X1 = '1') then Y1 <= '1';
		elsif (X0 = '1') then Y0 <= '1';
		end if;
	end process;
end rtl;