LIBRARY IEEE;
USE IEEE.STD_logic_1164.all;

ENTITY mult81 is
port(
  op1, op2, op3, op4, op5, op6, op7, op8: in std_logic_vector(3 downto 0);
  sel: in std_logic_vector(2 downto 0);
  i: out std_logic_vector(3 downto 0)
);
end mult81;

architecture arq_mult81 of mult81 is
begin
WITH sel SELECT
  i <= op1 when "000",
	   op2 when "001",
	   op3 when "010",
	   op4 when "011",
	   op5 when "100",
	   op6 when "101",
	   op7 when "110",
	   op8 when "111";
end arq_mult81;