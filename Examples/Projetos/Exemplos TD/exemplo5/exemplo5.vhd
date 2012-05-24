LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY exemplo5 IS
  PORT(
  a, b, c: in std_logic;
  s: out std_logic
  );
end exemplo5;
architecture arq_exemplo5 of exemplo5 is
signal s1, s2: std_logic;
begin 
  s1 <= not(a and b);
  s2 <= not(c);
  s <= s1 or s2;
end arq_exemplo5;