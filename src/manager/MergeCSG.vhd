library ieee;
use ieee.std_logic_1164.all;

entity MergeCSG is
	port 
	(
		EN       : in  std_logic;
		SBA      : in  std_logic;
		SCA      : in  std_logic;
		CBA      : in  std_logic;
		CCA      : in  std_logic;
		validB   : in  std_logic;
		validC   : in  std_logic;
		skipB    : in  std_logic;
		skipC    : in  std_logic;
		BlessC   : in  std_logic;
		T        : in  std_logic_vector(15 downto 0);
		ldCNT    : out std_logic;
		Tnext    : out std_logic_vector(15 downto 0);
		SAB      : out std_logic;
		SAC      : out std_logic;
		CAB      : out std_logic;
		CAC      : out std_logic;
		ldB      : out std_logic;
		ldC      : out std_logic;
		stValidB : out std_logic;
		stValidC : out std_logic;
		rsValidB : out std_logic;
		rsValidC : out std_logic;
		clNRB    : out std_logic;
		incNRB   : out std_logic;
		clNRC    : out std_logic;
		incNRC   : out std_logic;
		letC     : out std_logic;
		wren     : out std_logic;
		incA     : out std_logic;
		done     : out std_logic
	);
end entity;

architecture rtl of MergeCSG is
begin
	process (EN, SBA, SCA, CBA, CCA, validB, validC, skipB, skipC, BlessC, T)
	begin
		ldCNT   <= EN and ((T(0) and not (SBA or SCA)) or (T(1) and skipB and skipC) or 
								 (T(2) and not (not validB and not SBA)) or T(3) or (T(4) and not CBA) or
								 (T(5) and not (not validC and not SCA)) or T(6) or (T(7) and not CCA) or
								 T(8) or T(9));

		-- Tnext(i) <= EN and (condition to switch to state T(i))
		-- only one Tnext(i) should be active at any given moment but a priority encoder is used to correct any mistakes...

		Tnext     <= (others => '0');
		Tnext(0)  <= EN and T(0) and not (SBA or SCA);
		Tnext(1)  <= EN and T(8);
		Tnext(4)  <= EN and ((T(2) and not validB and SBA) or (T(4) and not CBA));
		Tnext(5)  <= EN and ((T(2) and validB) or T(3));
		Tnext(7)  <= EN and ((T(5) and not validC and SCA) or (T(7) and not CCA));
		Tnext(8)  <= EN and ((T(5) and validC) or T(6));
		Tnext(9)  <= EN and ((T(1) and skipB and skipC) or T(9));
		SAB       <= EN and T(4);
		SAC       <= EN and T(7);
		CAB       <= EN and T(4) and CBA;
		CAC       <= EN and T(7) and CCA;
		ldB       <= EN and T(4) and CBA;
		ldC       <= EN and T(7) and CCA;
		stValidB  <= EN and ((T(3) and skipB) or (T(4) and CBA));
		stValidC  <= EN and ((T(6) and skipC) or (T(7) and CCA));
		rsValidB  <= EN and (T(0) or (T(8) and not skipB and validB and (skipC or (validC and BlessC))) or T(9));
		rsValidC  <= EN and (T(0) or (T(8) and not skipC and validC and (skipB or (validB and not BlessC))) or T(9));
		clNRB     <= EN and (T(0) or (T(4) and CBA) or T(9));
		incNRB    <= EN and T(3);
		clNRC     <= EN and (T(0) or (T(7) and CCA) or T(9));
		incNRC    <= EN and T(6);
		letC      <= EN and T(8) and not skipC and validC and (skipB or (validB and not BlessC));
		wren      <= EN and T(8) and ((not skipC and validC and (skipB or validB)) or (not skipB and skipC and validB));
		incA      <= EN and T(8) and ((not skipC and validC and (skipB or validB)) or (not skipB and skipC and validB));
		done      <= EN and T(9);
	end process;
end rtl;