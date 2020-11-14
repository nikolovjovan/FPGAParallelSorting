library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REGX is

	generic
	(
		size : natural := 16;
		default_value: natural:=0
	);

	port 
	(
		clk      : in  std_logic;
		ld       : in  std_logic := '0';
		cl       : in  std_logic := '0';
		inc      : in  std_logic := '0';
		dec      : in  std_logic := '0';
		il       : in  std_logic;
		ir       : in  std_logic;
		sl       : in  std_logic := '0';
		sr       : in  std_logic := '0';
		data_in  : in  std_logic_vector(size - 1 downto 0);
		data_out : out std_logic_vector(size - 1 downto 0)
	);

end entity;

architecture rtl of REGX is
	signal data, data_next:std_logic_vector(size - 1 downto 0) := std_logic_vector(to_unsigned(default_value, size));
begin
	data_out <= data;
	process (clk)
	begin
		if (rising_edge(clk)) then
			data <= data_next;
		end if;
	end process;

	process (cl, ld, inc, dec, il, ir, sl, sr, data_in, data)
	begin
		if cl = '1' then
			data_next <= (others => '0');
		elsif ld='1' then
			data_next <= data_in;
		elsif inc='1' then
			data_next <= std_logic_vector(to_unsigned(to_integer(unsigned(data)) + 1, size));
		elsif dec='1' then
			data_next <= std_logic_vector(to_unsigned(to_integer(unsigned(data)) - 1, size));
		elsif sl='1' then
			data_next <= std_logic_vector(shift_left(unsigned(data), 1));
			data_next(0) <= il;
		elsif sr='1' then
			data_next <= std_logic_vector(shift_right(unsigned(data), 1));
			data_next(size-1) <= ir;
		else
			data_next <= data;
		end if;
	end process;

end rtl;
