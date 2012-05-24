LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY seg7 IS
PORT(
  a : in std_logic_vector (3 downto 0);
  s : out std_logic_vector (13 downto 0)
);
end seg7;
architecture arq_seg7 of seg7 is
begin
WITH a SELECT
  s <= "11111111000000" WHEN "0000",
	   "11111111111001" WHEN "0001",
	   "11111110100100" WHEN "0010",
	   "11111110110000" WHEN "0011",
	   "11111110011001" WHEN "0100",
	   "11111110010010" WHEN "0101",
	   "11111110000010" WHEN "0110",
	   "11111111111000" WHEN "0111",
	   "01111110000000" WHEN "1000",
	   "01111111111000" WHEN "1001",
	   "01111110000010" WHEN "1010",
	   "01111110010010" WHEN "1011",
	   "01111110011001" WHEN "1100",
	   "01111110110000" WHEN "1101",
	   "01111110100100" WHEN "1110",
	   "01111111111001" WHEN "1111",
	   "01111110111111" WHEN OTHERS;		
end arq_seg7;