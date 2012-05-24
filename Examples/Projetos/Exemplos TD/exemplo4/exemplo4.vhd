LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY exemplo4 IS
  PORT(
  a, b, c: in std_logic;
  s: out std_logic
  );
end exemplo4;
architecture arq_exemplo4 of exemplo4 is
begin 
  s <= not(a and b) or not(c);
end arq_exemplo4;