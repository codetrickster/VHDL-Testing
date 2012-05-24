LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY display IS
  PORT(
  a, b: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(13 downto 0);
  c4: out std_logic
  );
end display;
architecture arq_display of display is
signal s1: std_logic_vector(3 downto 0);

COMPONENT somador4bits IS
  PORT(
  a, b: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(3 downto 0);
  c4: out std_logic
  );
END COMPONENT;

COMPONENT seg7 IS
  PORT(
  ent: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(13 downto 0)
  );
END COMPONENT;

begin 
  somador4bits1: somador4bits
    port map (a=>a, b=>b, s=>s1, c4=>c4);
    
  seg71: seg7
    port map (ent=>s1, s=>s);
    
  
       
end arq_display;