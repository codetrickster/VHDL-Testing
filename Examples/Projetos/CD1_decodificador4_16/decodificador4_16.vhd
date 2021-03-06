LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY decodificador4_16 IS
  PORT(
  a: in std_logic_vector(0 to 3);
  s: out std_logic_vector(15 downto 0)
  );
end decodificador4_16;
architecture arq_decodificador4_16 of decodificador4_16 is
begin 
  s(0) <= not(a(3)) and not(a(2)) and not(a(1)) and not(a(0));
  s(1) <= not(a(3)) and not(a(2)) and not(a(1)) and (a(0));
  s(2) <= not(a(3)) and not(a(2)) and (a(1)) and not(a(0));
  s(3) <= not(a(3)) and not(a(2)) and (a(1)) and (a(0));
  s(4) <= not(a(3)) and (a(2)) and not(a(1)) and not(a(0));
  s(5) <= not(a(3)) and (a(2)) and not(a(1)) and (a(0));
  s(6) <= not(a(3)) and (a(2)) and (a(1)) and not(a(0));
  s(7) <= not(a(3)) and (a(2)) and (a(1)) and (a(0));
  s(8) <= (a(3)) and not(a(2)) and not(a(1)) and not(a(0));
  s(9) <= (a(3)) and not(a(2)) and not(a(1)) and (a(0));
  s(10) <= (a(3)) and not(a(2)) and (a(1)) and not(a(0));
  s(11) <= (a(3)) and not(a(2)) and (a(1)) and (a(0));
  s(12) <= (a(3)) and (a(2)) and not(a(1)) and not(a(0));
  s(13) <= (a(3)) and (a(2)) and not(a(1)) and (a(0));
  s(14) <= (a(3)) and (a(2)) and (a(1)) and not(a(0));
  s(15) <= (a(3)) and (a(2)) and (a(1)) and (a(0));
end arq_decodificador4_16;