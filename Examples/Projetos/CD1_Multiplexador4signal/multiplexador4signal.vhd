LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY multiplexador4signal IS
  PORT(
  a, b, c, d: in std_logic;
  sel0, sel1: in std_logic;
  
  y: out std_logic
  );
end multiplexador4signal;
architecture arq_multiplexador4signal of multiplexador4signal is
signal s1, s2: std_logic;
begin 
  s1 <= (not(sel1) and a)or(sel1 and b);
  s2 <= (not(sel1) and c)or(sel1 and d);
  y <= (not(sel0) and s1)or(sel0 and s2);
end arq_multiplexador4signal;