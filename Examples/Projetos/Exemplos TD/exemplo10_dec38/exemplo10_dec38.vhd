LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY exemplo10_dec38 IS
  PORT(
  a: in std_logic_vector(2 downto 0);
  s: out std_logic_vector(7 downto 0)
  );
end exemplo10_dec38;
architecture arq_exemplo10_dec38 of exemplo10_dec38 is
begin 
  with a select
  
  s <= "00000001" when "000",
       "00000010" when "001",
       "00000100" when "010",
       "00001000" when "011",
       "00010000" when "100",
       "00100000" when "101",
       "01000000" when "110",
       "10000000" when "111",
       "00000000" when others;
end arq_exemplo10_dec38;