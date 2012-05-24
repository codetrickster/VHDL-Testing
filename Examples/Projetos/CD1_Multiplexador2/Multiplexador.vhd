LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY multiplexador IS
  PORT(
  a: in std_logic;
  b: in std_logic;
  sel: in std_logic;
  y: out std_logic
  );
end multiplexador;
architecture arq_multiplexador of multiplexador is
begin 
  y <= (not(sel) and a) or (sel and b);
end arq_multiplexador;