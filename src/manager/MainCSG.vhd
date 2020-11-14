library ieee;
use ieee.std_logic_1164.all;

entity MainCSG is
	port 
	(
		read_end     : in  std_logic;
		isE0         : in  std_logic;
		isF0         : in  std_logic;
		isEnter      : in  std_logic;
		isBKSP       : in  std_logic;
		isDigit      : in  std_logic;
		Bis0         : in  std_logic;
		Nis1         : in  std_logic;
		done_read    : in  std_logic;
		done_send    : in  std_logic;
		done_merge   : in  std_logic;
		done_print   : in  std_logic;
		T            : in  std_logic_vector(15 downto 0);
		ldCNT        : out std_logic;
		Tnext        : out std_logic_vector(15 downto 0);
		reset        : out std_logic;
		clA          : out std_logic;
		incA         : out std_logic;
		decA         : out std_logic;
		ldB          : out std_logic;
		clB          : out std_logic;
		ldN          : out std_logic;
		erase        : out std_logic;
		stNum_4      : out std_logic;
		stNum_3      : out std_logic;
		stNum_2      : out std_logic;
		stNum_1      : out std_logic;
		display_load : out std_logic;
		display_sby  : out std_logic;
		display_done : out std_logic;
		display_end  : out std_logic;
		read_now     : out std_logic;
		send_now     : out std_logic;
		merge_now    : out std_logic;
		print_now    : out std_logic
	);
end entity;

architecture rtl of MainCSG is
begin
	process (read_end, isE0, isF0, isEnter, isBKSP, isDigit, Bis0, Nis1, done_read, done_send, done_merge, done_print, T)
	begin
		ldCNT   <= ((T(0) or T(2) or T(4) or T(8) or T(10)) and not (read_end and isF0)) or ((T(1) or T(9)) and not read_end) or
					  (T(3) and not (read_end and isEnter and not Bis0)) or (T(5) and not (read_end and isEnter and done_read and not Nis1)) or
					  (T(6) and not done_send) or (T(7) and not done_merge) or (T(11) and not (read_end and isEnter and done_print)) or T(12);

		-- Tnext(i) <= EN and (condition to switch to state T(i))
		-- only one Tnext(i) should be active at any given moment but a priority encoder is used to correct any mistakes...

		Tnext        <= (others => '0');
		Tnext(0)     <= T(0) and not (read_end and isF0);
		Tnext(1)     <= T(1) and not read_end;
		Tnext(2)     <= (T(2) and not (read_end and isF0)) or (T(3) and read_end and not isEnter);
		Tnext(3)     <= T(3) and not read_end;
		Tnext(4)     <= (T(4) and not (read_end and isF0)) or (T(5) and read_end and not (isEnter and done_read));
		Tnext(5)     <= T(5) and not read_end;
		Tnext(6)     <= T(6) and not done_send;
		Tnext(7)     <= T(7) and not done_merge;
		Tnext(8)     <= (T(5) and read_end and isEnter and done_read and Nis1) or (T(8) and not (read_end and isF0));
		Tnext(9)     <= T(9) and not read_end;
		Tnext(10)    <= (T(10) and not (read_end and isF0)) or (T(11) and read_end and not (isEnter and done_print));
		Tnext(11)    <= T(11) and not read_end;
		Tnext(12)    <= (T(3) and read_end and isEnter and Bis0) or T(12);
		reset        <= T(0);
		clA          <= T(6) and done_send;
		incA         <= T(11) and isEnter;
		decA         <= T(11) and isBKSP;
		ldB          <= (T(3) or T(5)) and (isDigit or isBKSP);
		clB          <= (T(3) or T(5)) and isEnter;
		ldN          <= T(3) and isEnter;
		erase        <= (T(3) or T(5)) and isBKSP;
		stNum_4      <= T(6) and done_send;
		stNum_3      <= T(0);
		stNum_2      <= T(3) and isEnter;
		stNum_1      <= '0';
		display_load <= T(0) or T(1);
		display_sby  <= T(6) or T(7);
		display_done <= T(8) or T(9);
		display_end  <= T(12);
		read_now     <= T(5) and isEnter;
		send_now     <= T(6);
		merge_now    <= T(7);
		print_now    <= T(10) or T(11);
	end process;
end rtl;