LIBRARY IEEE;
USE IEEE.STD_logic_1164.all;

ENTITY shifter_left is
port(
  b: in std_logic_vector(3 downto 0) ;
  s: out std_logic_vector(3 downto 0)
);
end shifter_left;

architecture arq_shifter_left of shifter_left is

component mult21
port(
  a, b: in std_logic;
  sel: in std_logic;
  s: out std_logic
);
end component;

begin

  Multiplexador1: mult21
	port map(sel => '1', a=>b(3), b => b(2), s => s(3));
  
  Multiplexador2: mult21
	port map(sel => '1', a=>b(2), b => b(1), s => s(2));
  
  Multiplexador3: mult21
	port map(sel => '1', a=>b(1), b => b(0), s => s(1));
 
  Multiplexador4: mult21
	port map(sel => '1', a=>b(0), b => '0', s => s(0));
	
end arq_shifter_left;