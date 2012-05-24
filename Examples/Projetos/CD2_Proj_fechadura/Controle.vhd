LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity Controle is
port(	
  reset_estados, clk, btn0: in std_logic;
  ld0, ld1, ld2, escrita: out std_logic;
    
  word_data_select: out std_logic_vector(2 downto 0);
  flag_senha, flag_admin: in std_logic
);
end Controle;

architecture arq_Controle of Controle is

signal CLK_COUNT_1HZ: std_logic_vector(7 downto 0);
signal CLK_1HZ, x: std_logic;

type STATE_TYPE is (insere_usuario, busca_usuario, insere_senha, compara_senha, senha_errada, 
login_usuario, login_admin, nova_senha);
signal estado, next_command: STATE_TYPE;

begin
      
  process (clk)
  begin
   if (clk'EVENT and clk = '1') then
	   IF CLK_COUNT_1HZ < 199 THEN
	     CLK_COUNT_1HZ <= CLK_COUNT_1HZ + 1;
	   ELSE
		 CLK_COUNT_1HZ <= X"00";
		 CLK_1HZ <= NOT CLK_1HZ;
	   END IF;
	 end if;
 end process;
  
  process (CLK_1HZ, reset_estados)
  variable data_select: std_logic_vector(2 downto 0);
  begin
    if reset_estados='1' then
      estado <= insere_usuario;
    elsif (CLK_1HZ'EVENT and CLK_1HZ='1') then
	  case estado is
        when insere_usuario =>
	      data_select := "000";
	      ld0 <= '1';
	      ld1 <= '0';
	      ld2 <= '0';
	      if btn0='0' then
	          estado <= busca_usuario;
	      end if;
	    
	    when busca_usuario =>
	      data_select := "111";
	      ld0 <= '0';
	      ld1 <= '1';
	      ld2 <= '0';
	      estado <= insere_senha;
	      	    
	    when insere_senha =>
	      data_select := "001";
	      ld0 <= '1';
	      ld1 <= '1';
	      ld2 <= '0';
	      if btn0='0' then
	        estado <= compara_senha;
	      end if;
	    
	      
	    when compara_senha =>
	      data_select := "111";
	      ld0 <= '0';
	      ld1 <= '0';
	      ld2 <= '1';
	      if flag_senha='1' then
	        if flag_admin='1' then
	          estado <= login_admin;
	        else
	          estado <= login_usuario;
	        end if;
	      else 
	        estado <= senha_errada;
	      end if;
	    
	    when login_admin =>
	      data_select := "100";
	      ld0 <= '1';
	      ld1 <= '0';
	      ld2 <= '1';
	      if btn0='0' then
	        estado <= nova_senha;
	      end if;  
	    
	    when nova_senha =>
	      data_select := "101";
	      ld0 <= '0';
	      ld1 <= '1';
	      ld2 <= '1';
	      if btn0='0' then
	        escrita <= '1';
	        estado <= insere_usuario;
	      end if;  

	    when login_usuario =>
	      data_select := "110";
	      ld0 <= '1';
	      ld1 <= '1';
	      ld2 <= '1';
	      if btn0='0' then
	        estado <= insere_usuario;
	      end if;  
	      	   
	    when senha_errada =>
	      data_select := "110";
	      ld0 <= '0';
	      ld1 <= '0';
	      ld2 <= '0';
	      if btn0='0' then
	        estado <= insere_usuario;
	      end if;  
	      
	  end case;
	end if;
	word_data_select <= data_select;
  end process;
  
end arq_Controle;
