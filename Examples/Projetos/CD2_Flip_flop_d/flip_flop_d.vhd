LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY flip_flop_d IS
  PORT(
  d, clk, res, set: in std_logic;
  q, qb: out std_logic
  );
end flip_flop_d;
architecture arq_flip_flop_d of flip_flop_d is
begin 
  process (clk, res, set)
  begin 
    if (res = '1') then
      q <= '0';
      qb <= '1';
    elsif (set = '1') then
      q <= '1';
      qb <= '0';
    elsif (clk'event and clk='1') then
      q <= d;
      qb <= not(d);
    end if;
  end process;     
end arq_flip_flop_d;