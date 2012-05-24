LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity Controle is
port(	
  reset, reset_estados, clk, sw0: in std_logic;
  ld0, ld1, ld2: out std_logic
);
end Controle;

architecture arq_Controle of Controle is

type STATE_TYPE is (usuario, senha, login_usuario);
signal estado: STATE_TYPE;

signal CLK_COUNT_1HZ: std_logic_vector(7 downto 0);
signal CLK400HZ, CLK_1HZ, x: std_logic;

component divisor is
port(	
  reset, clk: in std_logic;
  cout: out std_logic
);
end component;�

begin

  div: divisor
  port map(reset => reset, clk => clk, cout => x);

  CLK400HZ <= x;
  process (CLK400HZ)
  begin
    if (CLK400HZ'EVENT and CLK400HZ = '1') then
	  IF CLK_COUNT_1HZ < 199 THEN
	    CLK_COUNT_1HZ <= CLK_COUNT_1HZ + 1;
	  ELSE
		CLK_COUNT_1HZ <= X"00";
		CLK_1HZ <= NOT CLK_1HZ;
	  END IF;
	end if;
  end process;

  process (reset_estados, CLK_1HZ)
  begin
    if (reset_estados='1') then
	  estado <= usuario;	  
	elsif (CLK_1HZ'EVENT and CLK_1HZ = '1') then
	  case estado is
        when usuario =>
	      ld0 <= '1';
	      ld1 <= '0';
	      ld2 <= '0';
	      if sw0='0' then
	        estado <= senha;
	      end if;
	    
	    when senha =>
	      ld0 <= '0';
	      ld1 <= '1';
	      ld2 <= '0';
	      if sw0='0' then
	        estado <= login_usuario;
	      end if;
	      
	    when login_usuario =>
	      ld0 <= '0';
	      ld1 <= '0';
	      ld2 <= '1';
	      if sw0='0' then
	        estado <= usuario;
	      end if;
	    
	      
	  end case;
	end if;
  end process;
  
end arq_Controle;
