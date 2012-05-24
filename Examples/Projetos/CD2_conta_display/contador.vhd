LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity contador is 
port (
  clk, clr: in std_logic;
  q: out std_logic_vector(2 downto 0)
);
end contador;

architecture arq_contador of contador is
begin
  process (clk, clr)
  variable count : std_logic_vector(0 to 2);
  begin
    if (clr='0') then
	  count := "000";			
	elsif clk'event and clk='1' then
	  count := count + 1;			
	end if;	
	q <= count;
  end process;
end arq_contador;