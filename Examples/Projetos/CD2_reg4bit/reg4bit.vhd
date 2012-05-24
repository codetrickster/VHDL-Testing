LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY reg4bit IS
  PORT(
  clear, clk, load: in std_logic;
  d: in std_logic_vector(3 downto 0);
  q: out std_logic_vector(3 downto 0)
  );
end reg4bit;
architecture arq_reg4bit of reg4bit is
component reg1bit
PORT(
clear, clk, carga, d: in std_logic;
q: out std_logic
);
end component;

begin
  reg1: reg1bit
    port map(clear => clear, clk => clk, carga => load, d => d(0), q => q(0));
  reg2: reg1bit
    port map(clear => clear, clk => clk, carga => load, d => d(1), q => q(1));
  reg3: reg1bit
    port map(clear => clear, clk => clk, carga => load, d => d(2), q => q(2));
  reg4: reg1bit
    port map(clear => clear, clk => clk, carga => load, d => d(3), q => q(3));
end arq_reg4bit;