LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY flip_flop_jk IS
  PORT(
  clk, set, reset, j, k: in std_logic;
  q, qb: out std_logic
  );
end flip_flop_jk;
architecture arq_flip_flop_jk of flip_flop_jk is
signal q_temp, qb_temp: std_logic;
begin 
  process (clk, reset, set)
  begin
    if (set='1') then
      q_temp <= '1';
      qb_temp <= '0';
    elsif (reset='1') then
      q_temp <= '0';
      qb_temp <= '1';
    elsif (clk'event and clk = '1') then
      if (j = '0') and (k = '1') then
        q_temp <= '0';
        qb_temp <= '1';
      elsif (j = '1') and (k = '0') then
        q_temp <= '1';
        qb_temp <= '0';
      elsif (j = '1') and (k = '1') then
        q_temp <= qb_temp;
        qb_temp <= q_temp;
      end if;
    end if;  
  end process;     
  q <= q_temp;
  qb <= qb_temp;
end arq_flip_flop_jk;