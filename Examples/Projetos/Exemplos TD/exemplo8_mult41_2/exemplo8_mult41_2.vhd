LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY exemplo8_mult41_2 IS
  PORT(
  a: in std_logic_vector(3 downto 0);
  sel: in std_logic_vector(1 downto 0);
  s: out std_logic
  );
end exemplo8_mult41_2;
architecture arq_exemplo8_mult41_2 of exemplo8_mult41_2 is
signal n: std_logic_vector(3 downto 0);
begin 
  n(0) <= not(sel(1))and not(sel(0)) and a(0);
  n(1) <= not(sel(1)) and sel(0) and a(1);
  n(2) <= sel(1) and not(sel(0)) and a(2);
  n(3) <= sel(1) and sel(0) and a(3);
  
  s <= n(0) or n(1) or n(2) or n(3);
end arq_exemplo8_mult41_2;