LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity Contador_display is 
port (
  clk, clr: in std_logic;
  s: out std_logic_vector(6 downto 0)
);
end Contador_display;

architecture arq_Contador_display of Contador_display is
signal n: std_logic_vector(2 downto 0);
signal x: std_logic;
component contador is 
port (
  clk, clr: in std_logic;
  q: out std_logic_vector(2 downto 0)
);
end component;

component seg7 IS
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
  port map(clk => x, clr => clr, q => n);
  
  conversor: seg7
  port map(ent => n, s => s);
  
end arq_Contador_display;