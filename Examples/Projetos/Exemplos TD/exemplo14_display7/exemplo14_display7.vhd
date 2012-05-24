LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY exemplo14_display7 IS
  PORT(
  a, b: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(6 downto 0);
  c4: out std_logic
  );
end exemplo14_display7;

architecture arq_exemplo14_display7 of exemplo14_display7 is
signal n: std_logic_vector(3 downto 0);

COMPONENT somador4bits IS
  PORT(
  a, b: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(3 downto 0);
  c4: out std_logic
  );
END COMPONENT;

COMPONENT seg7 IS
  PORT(
  entrada: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(6 downto 0)
  );
END COMPONENT;

begin 
  somador: somador4bits
    port map ( a => a, b => b, s => n, c4 => c4);
    
  segmento7: seg7
    port map (entrada => n, s => s);
           
end arq_exemplo14_display7;