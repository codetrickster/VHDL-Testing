LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity Mult_contador is 
port (
  clk: in std_logic;
  sel: in std_logic_vector(1 downto 0);
  s: out std_logic_vector(6 downto 0)
);
end Mult_contador;

architecture arq_Mult_contador of Mult_contador is

signal n: std_logic_vector(2 downto 0);
signal x: std_logic;

component contador is 
port (
  clk: in std_logic;
  sel: in std_logic_vector(1 downto 0);
  ser: out std_logic_vector(2 downto 0)
);
end component;

component seg7 is
port(
  ent: in std_logic_vector(2 downto 0);
  s: out std_logic_vector(6 downto 0)
);
end component;

component divider is
port (
  clk: in STD_LOGIC;
  cout: out STD_LOGIC
);
end component;

begin
  div_clk: divider
  port map(clk => clk, cout => x);

  contador1: contador
  port map(clk => x, sel => sel, ser => n);
  
  conversor: seg7
  port map(ent => n, s => s);
  
end arq_Mult_contador;