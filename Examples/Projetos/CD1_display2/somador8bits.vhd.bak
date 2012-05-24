LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY somador8bits IS
  PORT(
  a, b: in std_logic_vector(7 downto 0);
  s: out std_logic_vector(7 downto 0);
  c8: out std_logic
  );
end somador8bits;

architecture arq_somador8bits of somador8bits is
SIGNAL C1, C2, C3, C4, C5, C6, C7: std_logic;

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
    port map(a => a(3), b => b(3), c_in => C3, s => s(3), c_out => C4);
  soma5: sc
    port map(a => a(4), b => b(4), c_in => C4, s => s(4), c_out => C5);
  soma6: sc
    port map(a => a(5), b => b(5), c_in => C5, s => s(5), c_out => C6);
  soma7: sc
    port map(a => a(6), b => b(6), c_in => C6, s => s(6), c_out => C7);
  soma8: sc
    port map(a => a(7), b => b(7), c_in => C7, s => s(7), c_out => c8);
      
end arq_somador8bits;