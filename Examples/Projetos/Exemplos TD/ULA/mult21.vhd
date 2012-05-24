LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY mult21 IS
PORT(
  a, b: in std_logic;
  sel: in std_logic;
  s: out std_logic
);
end mult21;

architecture arq_mult21 of mult21 is
begin
WITH sel SELECT
  s <= a when '0',
	   b when '1';
end arq_mult21;