LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY exemplo11_mult41 IS
  PORT(
  a: in std_logic_vector(0 to 3);
  sel: in std_logic_vector(0 to 1);
  s: out std_logic
  );
end exemplo11_mult41;
architecture arq_exemplo11_mult41 of exemplo11_mult41 is
begin 
  with sel select
  
    s <= "1000" when "00",
         "0100" when "01",
         "0010" when "10",
         "0001" when "11",
         "0000" when others;
    
end arq_exemplo11_mult41;