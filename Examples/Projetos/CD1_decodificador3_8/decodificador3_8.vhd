LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY decodificador3_8 IS
  PORT(
  a: in std_logic_vector(2 downto 0);
  s: out std_logic_vector(7 downto 0)
  );
end decodificador3_8;
architecture arq_decodificador3_8 of decodificador3_8 is
begin 
  s(0) <= not(a(2)) and not(a(1)) and not(a(0));
  s(1) <= not(a(2)) and not(a(1)) and (a(0));
  s(2) <= not(a(2)) and (a(1)) and not(a(0));
  s(3) <= not(a(2)) and (a(1)) and (a(0));
  s(4) <= (a(2)) and not(a(1)) and not(a(0));
  s(5) <= (a(2)) and not(a(1)) and (a(0));
  s(6) <= (a(2)) and (a(1)) and not(a(0));
  s(7) <= (a(2)) and (a(1)) and (a(0));
end arq_decodificador3_8;