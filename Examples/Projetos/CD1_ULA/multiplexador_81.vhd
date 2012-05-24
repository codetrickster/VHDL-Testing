LIBRARY IEEE;
USE IEEE.STD_logic_1164.all;

ENTITY multiplexador_81 is
port(
  u,d,t,q,c,s,o,n: in std_logic_vector(3 downto 0);
  sel: in std_logic_vector(2 downto 0);
  i: out std_logic_vector(3 downto 0)
);
end multiplexador_81;

architecture arq_multiplexador_81 of multiplexador_81 is
begin
WITH sel SELECT
  i <= u when "000",
	   d when "001",
	   t when "010",
	   q when "011",
	   c when "100",
	   s when "101",
	   o when "110",
	   n when "111";
end arq_multiplexador_81;