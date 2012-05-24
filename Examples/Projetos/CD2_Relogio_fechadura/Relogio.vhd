LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity Relogio is 
port (
  clk, reset: in std_logic;
  s0, s1, s2, s3, s4, s5, s6, s7: out std_logic_vector(0 to 6)  
);
end Relogio;

architecture arq_Relogio of Relogio is
signal n0, n1, n2, n3, n4, n5, n6, n7: std_logic_vector(3 downto 0);
signal x: std_logic;

component contador is 
port (
  clk, reset: in std_logic;
  q0, q1, q2, q3, q4, q5, q6, q7: out std_logic_vector(3 downto 0)
);
end component;

component seg7 is
port(
  ent: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(0 to 6)
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
  port map(clk => x, reset => reset, q0 => n0, q1 => n1, q2 => n2, 
           q3 => n3, q4 => n4, q5 => n5, q6 => n6, q7 => n7);
  
  conversor0: seg7
  port map(ent => n0, s => s0);
  
  conversor1: seg7
  port map(ent => n1, s => s1);
  
  conversor2: seg7
  port map(ent => n2, s => s2);
  
  conversor3: seg7
  port map(ent => n3, s => s3);
  
  conversor4: seg7
  port map(ent => n4, s => s4);
  
  conversor5: seg7
  port map(ent => n5, s => s5);
  
  conversor6: seg7
  port map(ent => n6, s => s6);
  
  conversor7: seg7
  port map(ent => n7, s => s7);
      
end arq_Relogio;