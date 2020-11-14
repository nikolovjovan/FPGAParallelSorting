library ieee;
use ieee.std_logic_1164.all;

entity SendCSG is
	port 
	(
		EN      : in  std_logic;
		SBA     : in  std_logic;
		SCA     : in  std_logic;
		CBA     : in  std_logic;
		CCA     : in  std_logic;
		priorB  : in  std_logic;
		done    : in  std_logic;
		T       : in  std_logic_vector(15 downto 0);
		ldCNT   : out std_logic;
		Tnext   : out std_logic_vector(15 downto 0);
		stCAB     : out std_logic;
		rsCAB     : out std_logic;
		stCAC     : out std_logic;
		rsCAC     : out std_logic;
		incAddr : out std_logic;
		tgl     : out std_logic
	);
end entity;

architecture rtl of SendCSG is
begin
	process (EN, SBA, SCA, CBA, CCA, priorB, done, T)
	begin
		ldCNT   <= EN and ((T(0) and not (not done and priorB)) or ((T(1) or T(7)) and not SBA) or 
								((T(2) or T(8)) and not CBA) or ((T(3) or T(5)) and not SCA) or ((T(4) or T(6)) and not CCA));

		-- Tnext(i) <= EN and (condition to switch to state T(i))
		-- only one Tnext(i) should be active at any given moment but a priority encoder is used to correct any mistakes...

		Tnext     <= (others => '0');
		Tnext(0)  <= EN and ((T(0) and done) or ((T(2) or T(8)) and CBA) or (T(3) and not SCA) or 
								  ((T(4) or T(6)) and CCA) or (T(7) and not SBA));
		Tnext(2)  <= EN and (T(2) and not CBA);
		Tnext(3)  <= EN and (T(1) and not SBA);
		Tnext(4)  <= EN and (T(4) and not CCA);
		Tnext(5)  <= EN and (T(0) and not done and not priorB);
		Tnext(6)  <= EN and (T(6) and not CCA);
		Tnext(7)  <= EN and (T(5) and not SCA);
		Tnext(8)  <= EN and (T(8) and not CBA);
		stCAB     <= EN and ((T(1) or T(7)) and SBA);
		rsCAB     <= EN and ((T(2) or T(8)) and CBA);
		stCAC     <= EN and ((T(3) or T(5)) and SCA);
		rsCAC     <= EN and ((T(4) or T(6)) and CCA);
		incAddr   <= EN and (((T(2) or T(8)) and CBA) or ((T(4) or T(6)) and CCA));
		tgl       <= EN and ((T(2) and CBA) or (T(6) and CCA));
	end process;
end rtl;