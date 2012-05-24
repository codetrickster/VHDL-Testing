LIBRARY IEEE;
USE IEEE.STD_logic_1164.all;

ENTITY somasub is
port(
  a: in std_logic_vector(3 downto 0) ;
  b: in std_logic_vector(3 downto 0) ;
  controle : in std_logic;
  s: out std_logic_vector(3 downto 0) ;
  overflow: out std_logic
);
end somasub;

architecture arq_somasub of somasub is
signal c1,c2,c3,c4 : std_logic;
signal d : std_logic_vector(3 downto 0);
component fulladder
port(
  a: in std_logic;
  b: in std_logic;
  cin: in std_logic;
  s: out std_logic;
  cout: out std_logic
);
end component;
begin
  d(0) <= (b(0) xor controle);
  d(1) <= (b(1) xor controle);
  d(2) <= (b(2) xor controle);
  d(3) <= (b(3) xor controle);
  Full1: fulladder
	port map(a => a(0), b => d(0), cin => controle, s => s(0), cout => c1 );
  Full2: fulladder
	port map(a => a(1), b => d(1), cin => c1, s => s(1), cout => c2 );
  Full3: fulladder
	port map(a => a(2), b => d(2), cin => c2, s => s(2), cout => c3 );
  Full4: fulladder
	port map(a => a(3), b => d(3), cin => c3, s => s(3), cout => c4 );
  overflow <= (c3 xor c4);
end arq_somasub;