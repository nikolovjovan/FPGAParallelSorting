library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SevenSegmentCharInterface is
	port
	(
		-- Input ports
		x	: in std_logic_vector(4 downto 0);
		en : in std_logic;

		-- Output ports
		hex: out std_logic_vector(7 downto 0)
	);
end;

architecture rtl of SevenSegmentCharInterface is
	 signal bcat : std_logic_vector(5 downto 0);
begin
   bcat <= en & x;

	process (bcat) is
	begin
		case bcat is
			when "100000" => hex <= "00010001"; -- A(00d)
			when "100001" => hex <= "11000001"; -- b(01d)
			when "100010" => hex <= "01100011"; -- C(02d)
			when "100011" => hex <= "11100101"; -- c(03d)
			when "100100" => hex <= "10000101"; -- d(04d)
			when "100101" => hex <= "01100001"; -- E(05d)
			when "100110" => hex <= "01110001"; -- F(06d)
			when "100111" => hex <= "01000011"; -- G(07d)
			when "101000" => hex <= "10010001"; -- H(08d)
			when "101001" => hex <= "11010001"; -- h(09d)
			when "101010" => hex <= "11110011"; -- I(10d)
			when "101011" => hex <= "00000111"; -- J(11d)
			when "101100" => hex <= "10000111"; -- j(12d)
			when "101101" => hex <= "11100011"; -- L(13d)
			when "101110" => hex <= "11010101"; -- n(14d)
			when "101111" => hex <= "00000011"; -- O(15d)
			when "110000" => hex <= "11000101"; -- o(16d)
			when "110001" => hex <= "00110001"; -- P(17d)
			when "110010" => hex <= "11110101"; -- r(18d)
			when "110011" => hex <= "01001001"; -- S(19d)
			when "110100" => hex <= "11100001"; -- t(20d)
			when "110101" => hex <= "10000011"; -- U(21d)
			when "110110" => hex <= "11000111"; -- u(22d)
			when "110111" => hex <= "10110001"; -- V(23d)
			when "111000" => hex <= "10001001"; -- y(24d)
			when others   => hex <= "11111111";
	  end case;
	end process;
end;