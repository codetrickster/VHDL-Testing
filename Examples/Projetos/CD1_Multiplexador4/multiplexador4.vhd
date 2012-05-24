LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY multiplexador4 IS
  PORT(
  a, b, c, d: in std_logic;
  sel0, sel1: in std_logic;
  y: out std_logic
  );
end multiplexador4;
architecture arq_multiplexador4 of multiplexador4 is
begin 
  y <= (not(sel1)and not(sel0) and a)or(not(sel1) and sel0 and b)or(sel1 and not(sel0) and c)or(sel1 and sel0 and d);
end arq_multiplexador4;