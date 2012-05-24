LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY display2 IS
  PORT(
  a, b: in std_logic_vector(7 downto 0);
  s: out std_logic_vector(20 downto 0);
  c8: out std_logic
  );
end display2;
architecture arq_display2 of display2 is
signal s1: std_logic_vector(7 downto 0);

COMPONENT somador8bits IS
  PORT(
  a, b: in std_logic_vector(7 downto 0);
  s: out std_logic_vector(7 downto 0);
  c8: out std_logic
  );
END COMPONENT;

COMPONENT seg15 IS
  PORT(
  ent: in std_logic_vector(7 downto 0);
  s: out std_logic_vector(20 downto 0)
  );
END COMPONENT;

begin 
  somador8bits1: somador8bits
    port map (a=>a, b=>b, s=>s1, c8=>c8);
    
  seg71: seg15
    port map (ent=>s1, s=>s);
         
end arq_display2;