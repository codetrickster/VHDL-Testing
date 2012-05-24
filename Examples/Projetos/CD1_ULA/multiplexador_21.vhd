LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY multiplexador_21 IS
PORT(
  sel : in std_logic;
  a : in std_logic_vector(1 downto 0);
  s : out std_logic
);
end multiplexador_21;
architecture arq_multiplexador_21 of multiplexador_21 is
begin
WITH sel SELECT
  s <= a(0) when '0',
	   a(1) when '1';
end arq_multiplexador_21;