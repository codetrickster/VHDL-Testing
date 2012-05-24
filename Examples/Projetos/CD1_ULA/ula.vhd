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
signal v1, v2, v3, v4, v5, v6, v7, v8, r : std_logic_vector(3 downto 0);
signal sig : std_logic_vector(13 downto 0);
signal Valor_soma, Valor_sub : std_logic;

component somasub
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
  a : in std_logic_vector (3 downto 0);
  s : out std_logic_vector (13 downto 0)
);
end component;

component multiplexador_81
port(
  u,d,t,q,c,s,o,n: in std_logic_vector(3 downto 0) ;
  sel: in std_logic_vector(2 downto 0) ;
  i: out std_logic_vector(3 downto 0)
);
end component;

component deslocad
port(
  b: in std_logic_vector(3 downto 0) ;
  s: out std_logic_vector(3 downto 0)
);
end component;

component deslocae
port(
  b: in std_logic_vector(3 downto 0) ;
  s: out std_logic_vector(3 downto 0)
);
end component;

component verifica
port(
  a : in std_logic_vector(3 downto 0);
  s : out std_logic
);
end component;

begin

  Soma: somasub
    port map( a => a, b => b, controle => f(0), s => v1, overflow => Valor_soma);
	v2 <= (a and b);
	v3 <= (a or b);
	v4 <= not a;
	v5 <= a;
	
  Sub: somasub
    port map( a => a, b => b, controle => f(0), s => v6, overflow => Valor_sub);
		
  Deslocaesquerda: deslocae
	port map( b => b, s => v7 );
		
  Deslocadireita: deslocad
	port map( b => b, s => v8 );
		
  Multiplexador: Multiplexador_81
	port map( u => v1, d => v2, t => v3, q => v4, c => v5, s => v6, o => v7, n => v8, sel => f , i => r);
  N <= r(3);
  V <= ((not f(0)) and (not f(1)) and (not f(2)) and Valor_soma) or (f(0) and (not f(1)) and f(2) and Valor_sub);
	
  Verificazero: verifica
	port map( a => r, s => Z );
		
  Display: seg7
	port map( a => r, s => s );
end arq_ula;