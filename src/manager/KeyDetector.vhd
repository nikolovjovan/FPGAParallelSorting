library ieee;
use ieee.std_logic_1164.all;

entity KeyDetector is

	port 
	(
		key_code_in  : in  std_logic_vector(7 downto 0);
		key_code_out : out std_logic_vector(7 downto 0);
		isE0         : out std_logic := '0';
		isF0         : out std_logic := '0';
		isEnter      : out std_logic := '0';
		isBKSP       : out std_logic := '0';
		isOther      : out std_logic := '0'
	);

end entity;

architecture rtl of KeyDetector is
begin
	process (key_code_in) is
	begin
		isE0 <= '0';
		isF0 <= '0';
		isEnter <= '0';
		isBKSP <= '0';
		isOther <= '0';
		key_code_out <= key_code_in;
		case key_code_in is
			when "11100000" => isE0 <= '1';
			when "11110000" => isF0 <= '1';
			when "01011010" => isEnter <= '1';
			when "01100110" => isBKSP <= '1';
			when others     => isOther <= '1'; 
	  end case;
	end process;
end rtl;