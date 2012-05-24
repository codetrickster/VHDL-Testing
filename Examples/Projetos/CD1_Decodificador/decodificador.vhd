LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY decodificador IS
  PORT(
  a: in std_logic_vector(1 downto 0);
  s: out std_logic_vector(3 downto 0)
  );
end decodificador;
architecture arq_decodificador of decodificador is
begin 
  s(0) <= not(a(1)) and not(a(0));
  s(1) <= not(a(1)) and a(0);
  s(2) <= a(1) and not(a(0));
  s(3) <= a(1) and a(0);
end arq_decodificador;