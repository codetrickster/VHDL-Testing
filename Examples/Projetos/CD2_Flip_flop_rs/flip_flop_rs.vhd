LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY flip_flop_rs IS
  PORT(
  clk, r, s: in std_logic;
  q, qb: out std_logic
  );
end flip_flop_rs;
architecture arq_flip_flop_rs of flip_flop_rs is
begin 
  process (clk, r, s)
  begin
    if (clk'event and clk='1') then
      if (r = '0') and (s = '1') then
        q <= '1';
        qb <= '0';
      elsif (r = '1') and (s = '0') then
        q <= '0';
        qb <= '1';
      elsif (r = '1') and (s = '1') then
        q <= 'X';
        qb <= 'X';
      end if;
    end if;
  end process;     
end arq_flip_flop_rs;