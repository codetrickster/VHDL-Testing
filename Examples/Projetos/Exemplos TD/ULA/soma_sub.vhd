LIBRARY IEEE;
USE IEEE.STD_logic_1164.all;

ENTITY soma_sub is
port(
  a: in std_logic_vector(3 downto 0);
  b: in std_logic_vector(3 downto 0);
  controle: in std_logic;
  s: out std_logic_vector(3 downto 0);
  overflow: out std_logic
);
end soma_sub;

architecture arq_soma_sub of soma_sub is
signal c: std_logic_vector(3 downto 0);

component full_adder
port(
  a, b, c_in: in std_logic;
  s, c_out: out std_logic
);
end component;

begin
  
  Full1: full_adder
	port map(a => a(0), b => (b(0) xor controle), c_in => controle, s => s(0), c_out => c(0) );
	
  Full2: full_adder
	port map(a => a(1), b => (b(1) xor controle), c_in => c(0), s => s(1), c_out => c(1));
  
  Full3: full_adder
	port map(a => a(2), b => (b(2) xor controle), c_in => c(1), s => s(2), c_out => c(2));
  
  Full4: full_adder
	port map(a => a(3), b => (b(3) xor controle), c_in => c(2), s => s(3), c_out => c(3));
	
  overflow <= (c(2) xor c(3));
  
end arq_soma_sub;