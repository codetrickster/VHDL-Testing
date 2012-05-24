LIBRARY IEEE;
USE IEEE.STD_logic_1164.all;

ENTITY full_adder is
port(
  a, b, c_in: in std_logic;
  s, c_out: out std_logic
);
end full_adder;

architecture arq_full_adder of full_adder is
begin
  s <= a xor b xor c_in;
  c_out <= (a and b) or (a and c_in) or (b and c_in);
end arq_full_adder;