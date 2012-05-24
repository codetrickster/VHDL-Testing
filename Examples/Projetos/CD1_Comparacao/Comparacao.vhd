LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY comparacao IS
  PORT(
  a: in std_logic_vector(7 downto 0);
  b: in std_logic_vector(7 downto 0);
  menor: out std_logic;
  igual: out std_logic;
  maior: out std_logic
  );
end comparacao;
architecture arq_comparacao of comparacao is
begin 
  process (a, b)
  begin 
    if (a<b) then
      menor <= '1';
      igual <= '0';
      maior <= '0';
    elsif (a=b) then
      menor <= '0';
      igual <= '1';
      maior <= '0';
    else 
      menor <= '0';
      igual <= '0';
      maior <= '1';
    end if;
  end process;
end arq_comparacao;