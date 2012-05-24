LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY latch_d IS
  PORT(
  d, c: in std_logic;
  q, qb: out std_logic
  );
end latch_d;
architecture arq_latch_d of latch_d is
begin 
  process (c, d)
  begin 
    if c = '1' then
      q <= d;
      qb <= not(d);
    end if;
  end process;     
end arq_latch_d;