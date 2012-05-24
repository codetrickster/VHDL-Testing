LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY sc IS
  PORT(
  a: in std_logic;
  b: in std_logic;
  c_in: in std_logic;
  s: out std_logic;
  c_out: out std_logic
  );
end sc;
architecture arq_sc of sc is
begin 
  s <= (c_in) xor (a) xor (b);
  c_out <= (a and b) or (a and c_in) or ( b and c_in);
end arq_sc;