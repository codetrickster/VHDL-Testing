LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ms IS
  PORT(
  a: in std_logic;
  b: in std_logic;
  s: out std_logic;
  c_out: out std_logic
  );
end ms;
architecture arq_ms of ms is
begin 
  s <= (not(a) and b) or (a and not(b));
  c_out <= a and b;
end arq_ms;