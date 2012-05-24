LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY reg1bit IS
  PORT(
  clear, clk, carga, d: in std_logic;
  q: out std_logic
  );
end reg1bit;
architecture arq_reg1bit of reg1bit is
signal q_temp: std_logic;
begin 
  process (clk, clear, carga)
  begin 
    if (clear = '1') then
      q_temp <= '0';
    elsif (clk'event and clk = '1') then
    
      if (carga = '1') then
        q_temp <= d;
      else
        q_temp <= q_temp;
      end if; 
       
    end if;
  end process;     
  q <= q_temp;
end arq_reg1bit;