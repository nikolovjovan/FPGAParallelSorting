library ieee;
use ieee.std_logic_1164.all;

entity MainCSG is
	port 
	(
		EN        : in  std_logic;
		SAB       : in  std_logic;
		CAB       : in  std_logic;
		done_read : in  std_logic;
		done_sort : in  std_logic;
		AisN      : in  std_logic;
		T         : in  std_logic_vector(15 downto 0);
		ldCNT     : out std_logic;
		Tnext     : out std_logic_vector(15 downto 0);
		SBA       : out std_logic;
		stCBA     : out std_logic;
		rsCBA     : out std_logic;
		wren      : out std_logic;
		ldA       : out std_logic;
		incA      : out std_logic;
		ldN       : out std_logic;
		sort_now  : out std_logic;
		done      : out std_logic
	);
end entity;

architecture rtl of MainCSG is
begin
	process (EN, SAB, CAB, done_read, done_sort, AisN, T)
	begin
		ldCNT   <= not EN or ((T(0) and not SAB) or (T(1) and done_read) or (T(2) and not (not done_read and CAB)) or 
									 T(3) or (T(4) and not SAB) or (T(5) and not (CAB and AisN)) or T(6));

		-- Tnext(i) <= EN and (condition to switch to state T(i))
		-- only one Tnext(i) should be active at any given moment but a priority encoder is used to correct any mistakes...

		Tnext     <= (others => '0');
		Tnext(0)  <= EN and (T(0) and not SAB);
		Tnext(1)  <= EN and ((T(2) and not done_read) or (T(3) and done_sort));
		Tnext(2)  <= EN and (T(2) and done_read and not CAB);
		Tnext(3)  <= EN and (T(3) and not done_sort);
		Tnext(4)  <= EN and (((T(1) or T(2)) and done_read) or (T(4) and not SAB) or (T(5) and CAB and not AisN));
		Tnext(5)  <= EN and (T(5) and not CAB);
		Tnext(6)  <= EN and T(6);
		SBA       <= EN and ((T(2) and not done_read) or T(4));
		stCBA     <= EN and ((T(2) and not done_read and CAB) or (T(4) and SAB));
		rsCBA     <= EN and ((T(2) and done_read) or T(3) or (T(5) and CAB));
		wren      <= EN and (T(2) and not done_read and CAB);
		ldA       <= EN and (((T(1) or T(2)) and done_read) or (T(5) and CAB and AisN));
		incA      <= EN and ((T(2) and not done_read and CAB) or (T(5) and CAB));
		ldN       <= EN and ((T(1) or T(2)) and done_read);
		sort_now  <= EN and (T(3));
		done      <= EN and (T(6));
	end process;
end rtl;