library ieee;
use ieee.std_logic_1164.all;

entity DigitDetector is

	port 
	(
		key_code_in  : in  std_logic_vector(7 downto 0);
		key_code_out : out std_logic_vector(7 downto 0);
		digit_out    : out std_logic_vector(3 downto 0);
		isOther      : out std_logic := '0'
	);

end entity;

architecture rtl of DigitDetector is
begin
	process (key_code_in) is
	begin
		isOther <= '0';
		digit_out <= "0000";
		key_code_out <= key_code_in;
		case key_code_in is
			when "01000101" => digit_out <= "0000"; -- 0
			when "01110000" => digit_out <= "0000"; -- KP 0
			when "00010110" => digit_out <= "0001"; -- 1
			when "01101001" => digit_out <= "0001"; -- KP 1
			when "00011110" => digit_out <= "0010"; -- 2
			when "01110010" => digit_out <= "0010"; -- KP 2
			when "00100110" => digit_out <= "0011"; -- 3
			when "01111010" => digit_out <= "0011"; -- KP 3
			when "00100101" => digit_out <= "0100"; -- 4
			when "01101011" => digit_out <= "0100"; -- KP 4
			when "00101110" => digit_out <= "0101"; -- 5
			when "01110011" => digit_out <= "0101"; -- KP 5
			when "00110110" => digit_out <= "0110"; -- 6
			when "01110100" => digit_out <= "0110"; -- KP 6
			when "00111101" => digit_out <= "0111"; -- 7
			when "01101100" => digit_out <= "0111"; -- KP 7
			when "00111110" => digit_out <= "1000"; -- 8
			when "01110101" => digit_out <= "1000"; -- KP 8
			when "01000110" => digit_out <= "1001"; -- 9
			when "01111101" => digit_out <= "1001"; -- KP 9
			when "00011100" => digit_out <= "1010"; -- A
			when "00110010" => digit_out <= "1011"; -- B
			when "00100001" => digit_out <= "1100"; -- C
			when "00100011" => digit_out <= "1101"; -- D
			when "00100100" => digit_out <= "1110"; -- E
			when "00101011" => digit_out <= "1111"; -- F
			when others     => isOther <= '1'; 
	  end case;
	end process;
end rtl;