LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY exemplo13_somador_completo IS
  PORT(
  a, b, c_in: in std_logic;
  s, c_out: out std_logic
  );
end exemplo13_somador_completo;
architecture arq_exemplo13_somador_completo of exemplo13_somador_completo is
begin 
  s <= c_in xor a xor b;
  c_out <= (a and b) or (a and c_in) or (b and c_in);
end arq_exemplo13_somador_completo;