Library IEEE;
use IEEE.std_logic_1164.all;

entity Divider is
port (
  clk: in STD_LOGIC;
  cout: out STD_LOGIC
);
end Divider; 

architecture Divider of Divider is 
constant TIMECONST : integer := 59;
signal count0, count1, count2, count3: integer range 0 to 1000 := 0;
signal D: STD_LOGIC := '0';

begin 
  process (clk)
  begin
    if (clk'event and clk = '1') then
	  count0 <= count0 + 1;
	  if (count0 = TIMECONST) then
	    count0 <= 0;
	    count1 <= count1 + 1;
	  elsif (count1 = TIMECONST) then
	    count1 <= 0;
	    count2 <= count2 + 1;
	  elsif (count2 = TIMECONST) then
	    count2 <= 0;
	    count3 <= count3 + 1;
	  elsif (count3 = TIMECONST) then
	    count3 <= 0;
	    D <= not D;
	  end if;
	end if;
  cout <= D;
  end process;
end Divider;