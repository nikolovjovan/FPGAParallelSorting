library ieee;
use ieee.std_logic_1164.all;

entity SortCSG is
	port 
	(
		T       : in  std_logic_vector(7 downto 0);
		continue: in  std_logic;
		input   : in  std_logic;
		ldCNT   : out std_logic;
		Tnext   : out std_logic_vector(7 downto 0);
		done    : out std_logic
		
	);
end entity;

architecture rtl of SortCSG is
begin
	process (T, continue, input)
	begin
		ldCNT    <= (((T(0) and not input)or T(6)) or T(5) or (T(4) and not continue));
		Tnext    <= (others => '0');
		Tnext(0) <= ((T(0) and not input)or T(6));
		Tnext(2) <= T(5);
		Tnext(6) <= (T(4) and not continue);
		done     <= T(6);
	end process;
end rtl;