LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY exemplo8_mult41_1 IS
  PORT(
  a: in std_logic_vector(3 downto 0);
  sel: in std_logic_vector(1 downto 0);
  s: out std_logic
  );
end exemplo8_mult41_1;
architecture arq_exemplo8_mult41_1 of exemplo8_mult41_1 is
begin 
  s <= (not(sel(1))and not(sel(0)) and a(0))or
       (not(sel(1)) and sel(0) and a(1))or
       (sel(1) and not(sel(0)) and a(2))or
       (sel(1) and sel(0) and a(3));
end arq_exemplo8_mult41_1;