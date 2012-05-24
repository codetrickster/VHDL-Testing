LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY verifica IS
PORT(
  a: in std_logic_vector(3 downto 0);
  s: out std_logic
);
end verifica;

architecture arq_verifica of verifica is
begin
WITH a SELECT
  s <= '1' when "0000",
       '0' when OTHERS;
end arq_verifica;