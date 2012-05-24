LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY multiplexador4 IS
  PORT(
  a: in std_logic_vector(0 to 3);
  sel: in std_logic_vector(0 to 1);
  s: out std_logic
  );
end multiplexador4;
architecture arq_multiplexador4 of multiplexador4 is
begin 
  with sel select
  
  s <= a(0) when "00",
       a(1) when "01",
       a(2) when "10",
       a(3) when "11";
       
end arq_multiplexador4;