LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY seg7 IS
  PORT(
  ent: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(13 downto 0)
  );
end seg7;
architecture arq_seg7 of seg7 is
begin 
  with ent select
  
  s <= "10000001000000" when "0000",
       "10000001111001" when "0001",
       "10000000100100" when "0010",
       "10000000110000" when "0011",
       "10000000011001" when "0100",
       "10000000010010" when "0101",
       "10000000000010" when "0110",
       "10000001111000" when "0111",
       "10000000000000" when "1000",
       "10000000010000" when "1001",
       
       "11110011000000" when "1010",
       "11110011111001" when "1011",
       "11110010100100" when "1100",
       "11110010110000" when "1101",
       "11110010011001" when "1110",
       "11110010010010" when "1111",
       
       "01111110111111" when others;
       
end arq_seg7;