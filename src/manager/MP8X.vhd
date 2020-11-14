library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MP8X is

	generic
	(
		size : natural := 16
	);

	port 
	(
		X0	: in std_logic_vector(size-1 downto 0);
		X1	: in std_logic_vector(size-1 downto 0);
		X2	: in std_logic_vector(size-1 downto 0);
		X3	: in std_logic_vector(size-1 downto 0);
		X4	: in std_logic_vector(size-1 downto 0);
		X5	: in std_logic_vector(size-1 downto 0);
		X6	: in std_logic_vector(size-1 downto 0);
		X7	: in std_logic_vector(size-1 downto 0);
		S  : in std_logic_vector(2 downto 0);
		Y  : out std_logic_vector(size-1 downto 0)
		
	);

end entity;

architecture rtl of MP8X is
begin

	process (S, X0, X1, X2, X3)
	begin
		case S is
			when "000" => Y <= X0;
			when "001" => Y <= X1;
			when "010" => Y <= X2;
			when "011" => Y <= X3;
			when "100" => Y <= X4;
			when "101" => Y <= X5;
			when "110" => Y <= X6;
			when "111" => Y <= X7;
	  end case;
	end process;
end rtl;
