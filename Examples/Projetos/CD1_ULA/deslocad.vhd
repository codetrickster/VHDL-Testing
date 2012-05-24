LIBRARY IEEE;
USE IEEE.STD_logic_1164.all;

ENTITY deslocad is
port(
  b: in std_logic_vector(3 downto 0) ;
  s: out std_logic_vector(3 downto 0)
);
end deslocad;

architecture arq_deslocad of deslocad is

component multiplexador_21
port(
  sel : in std_logic;
  a : in std_logic_vector (1 downto 0);
  s : out std_logic
);
end component;

begin

  Multiplexador1: multiplexador_21
	port map(sel => '0',  a(0)=> '0', a(1) => b(3), s => s(3));

  Multiplexador2: multiplexador_21
	port map(sel => '0', a(0)=>b(3), a(1) => b(2), s => s(2));

  Multiplexador3: multiplexador_21
	port map(sel => '0', a(0)=>b(2), a(1) => b(1), s => s(1));

  Multiplexador4: multiplexador_21
	port map(sel => '0', a(0)=>b(1), a(1) => b(0), s => s(0));

end arq_deslocad;