LIBRARY IEEE;
USE IEEE.STD_logic_1164.all;

ENTITY ula is
port(
  a: in std_logic_vector(3 downto 0) ;
  b: in std_logic_vector(3 downto 0) ;
  f: in std_logic_vector(2 downto 0) ;
  s: out std_logic_vector(13 downto 0) ;
  V,Z,N: out std_logic
);
end ula;

architecture arq_ula of ula is
signal v1, v2, v3, v4, r: std_logic_vector(3 downto 0);
signal sig: std_logic_vector(13 downto 0);
signal Valor_soma, Valor_sub: std_logic;

component soma_sub
port(
  a: in std_logic_vector(3 downto 0) ;
  b: in std_logic_vector(3 downto 0) ;
  controle : in std_logic;
  s: out std_logic_vector(3 downto 0) ;
  overflow: out std_logic
);
end component;

component seg7
port(
  a: in std_logic_vector (3 downto 0);
  s: out std_logic_vector (13 downto 0)
);
end component;

component mult81
port(
  op1, op2, op3, op4, op5, op6, op7, op8: in std_logic_vector(3 downto 0) ;
  sel: in std_logic_vector(2 downto 0) ;
  i: out std_logic_vector(3 downto 0)
);
end component;

component shifter_right
port(
  b: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(3 downto 0)
);
end component;

component shifter_left
port(
  b: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(3 downto 0)
);
end component;

component verifica
port(
  a: in std_logic_vector(3 downto 0);
  s: out std_logic
);
end component;

begin

  Soma: soma_sub
    port map(a => a, b => b, controle => f(0), s => v1, overflow => Valor_soma);
		
  Sub: soma_sub
    port map(a => a, b => b, controle => f(0), s => v2, overflow => Valor_sub);
		
  SLeft: shifter_left
	port map(b => b, s => v3);
		
  SRight: shifter_right
	port map(b => b, s => v4);
		
  Multiplexador: Mult81
	port map( op1 => v1, 
	          op2 => (a and b), 
	          op3 => (a or b), 
	          op4 => not a, 
	          op5 => a,
	          op6 => v2, 
	          op7 => v3, 
	          op8 => v4, 
	          sel => f, 
	          i => r);
	          
  N <= r(3);
  V <= ((not f(0)) and (not f(1)) and (not f(2)) and Valor_soma) or (f(0) and (not f(1)) and f(2) and Valor_sub);
	
  Verificazero: verifica
	port map(a => r, s => Z);
		
  Display: seg7
	port map(a => r, s => s);
end arq_ula;