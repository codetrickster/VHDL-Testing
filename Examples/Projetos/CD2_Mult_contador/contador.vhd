LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity contador is 
port (
  clk: in std_logic;
  sel: in std_logic_vector(1 downto 0);
  ser: out std_logic_vector(2 downto 0)
);
end contador;

architecture arq_contador of contador is

signal q0, q1, q2, q3: std_logic_vector(2 downto 0);

begin
  process (clk)
  variable count: std_logic_vector(0 to 2);
  begin
    if sel="00" then
      if clk'event and clk='1' then
	    count := count + 1;			
	    if count = "111" then
	      count := "000";
	    end if;
	  end if;	
	  q0 <= count;
	end if;
  end process;
  
  process (clk)
  variable count: std_logic_vector(0 to 2);
  begin
    if sel="01" then
      if clk'event and clk='1' then
	    count := count + 1;	
	    if count = "110" then
	      count := "000";
	    end if;
	  end if;	
	  q1 <= count;
	end if;
  end process;
  
  process (clk)
  variable count: std_logic_vector(0 to 2);
  begin
    if sel="10" then
      if clk'event and clk='1' then
	    count := count + 1;	
	    if count = "100" then
	      count := "000";
	    end if;
	  end if;	
	  q2 <= count;
	end if;
  end process;
  
  process (clk)
  variable count: std_logic_vector(0 to 2);
  begin
    if sel="11" then
      if clk'event and clk='1' then
	    count := count + 1;	
	    if count = "011" then
	      count := "000";
	    end if;
	  end if;	
	  q3 <= count;
	end if;
  end process;
  
  with sel select
    ser <= q0 when "00",
           q1 when "01",
           q2 when "10",
           q3 when "11";  

end arq_contador;