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
SIGNAL n: std_logic_vector (0 to 2);

COMPONENT meio_somador
  PORT (
  a, b : in std_logic;
  s, c_out: out std_logic
  );
END COMPONENT;

COMPONENT somador_completo
  PORT (
  a, b, c_in: in std_logic;
  s, c_out: out std_logic
  );
END COMPONENT;

begin 
  soma1: meio_somador
    port map(a => a(0), b => b(0), s => s(0), c_out => n(0));
    
  soma2: somador_completo
    port map(a => a(1), b => b(1), c_in => n(0), s => s(1), c_out => n(1));
    
  soma3: somador_completo
    port map(a => a(2), b => b(2), c_in => n(1), s => s(2), c_out => n(2));
    
  soma4: somador_completo
    port map(a => a(3), b => b(3), c_in => n(2), s => s(3), c_out => c4);
      
end arq_somador4bits;