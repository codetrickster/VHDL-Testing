LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mult41 IS
  PORT(
  a: in std_logic_vector(0 to 3);
  sel: in std_logic_vector(0 to 1);
  s: out std_logic
  );
end mult41;
architecture arq_mult41 of mult41 is
begin 
  with sel select
  
  s <= a(0) when "00",
       a(1) when "01",
       a(2) when "10",
       a(3) when "11";
       
end arq_mult41;