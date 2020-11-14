library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SevenSegmentDigitInterface is
	port
	(
		-- Input ports
		x	 : in std_logic_vector(3 downto 0);
		dot : in std_logic;
		en  : in std_logic;

		-- Output ports
		hex : out std_logic_vector(7 downto 0)
	);
end;

architecture rtl of SevenSegmentDigitInterface is
	 signal bcat : std_logic_vector(4 downto 0);
	 signal hex0 : std_logic;
begin
   bcat <= en & x;
	hex0 <= not (en and dot);

	process (bcat, hex0) is
	begin
		case bcat is
			when "10000" => hex <= "0000001" & hex0;
			when "10001" => hex <= "1001111" & hex0;
			when "10010" => hex <= "0010010" & hex0;
			when "10011" => hex <= "0000110" & hex0;
			when "10100" => hex <= "1001100" & hex0;
			when "10101" => hex <= "0100100" & hex0;
			when "10110" => hex <= "0100000" & hex0;
			when "10111" => hex <= "0001111" & hex0;
			when "11000" => hex <= "0000000" & hex0;
			when "11001" => hex <= "0000100" & hex0;
			when "11010" => hex <= "0001000" & hex0;
			when "11011" => hex <= "1100000" & hex0;
			when "11100" => hex <= "0110001" & hex0;
			when "11101" => hex <= "1000010" & hex0;
			when "11110" => hex <= "0110000" & hex0;
			when "11111" => hex <= "0111000" & hex0;
			when others  => hex <= "1111111" & hex0;
	  end case;
	end process;
end;