LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY somador4bits IS
  PORT(
  a, b: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(3 downto 0);
  c4: out std_logic
  );
end somador4bits;

architecture arq_somador4bits of somador4bits is
SIGNAL C1, C2, C3: std_logic;

COMPONENT ms
  PORT (
  a: in std_logic;
  b: in std_logic;
  s: out std_logic;
  c_out: out std_logic
  );
END COMPONENT;

COMPONENT sc
  PORT (
  a: in std_logic;
  b: in std_logic;
  c_in: in std_logic;
  s: out std_logic;
  c_out: out std_logic
  );
END COMPONENT;

begin 
  soma1: ms
    port map(a => a(0), b => b(0), s => s(0), c_out => C1);
  soma2: sc
    port map(a => a(1), b => b(1), c_in => C1, s => s(1), c_out => C2);
  soma3: sc
    port map(a => a(2), b => b(2), c_in => C2, s => s(2), c_out => C3);
  soma4: sc
    port map(a => a(3), b => b(3), c_in => C3, s => s(3), c_out => c4);
      
end arq_somador4bits;