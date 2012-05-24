LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity DBase is
port(	
  clk, escrita: in std_logic;
  destino: in std_logic_vector(3 downto 0);
  
  reg_data_sel: in std_logic_vector(3 downto 0);
  reg_data_in: in std_logic_vector(7 downto 0);
  reg_data_out: out std_logic_vector(7 downto 0);
  
  word_data_select: in std_logic_vector(2 downto 0);
  word_data_out: out std_logic_vector(3 downto 0);
  
  posicao2, posicao1, posicao0: out std_logic_vector(3 downto 0);
  flag_full: out std_logic
);
end DBase; 

architecture arq_DBase of DBase is

signal R0, R1, R2, R3, R4, R5, R6, R7, R8: std_logic_vector(7 downto 0):="00000000";
signal R9, R10, R11, R12, R13: std_logic_vector(7 downto 0):="00000000";
signal R14: std_logic_vector(7 downto 0):= "00010001";
signal n2, n1, n0: std_logic_vector(3 downto 0);
signal flag_full3: std_logic;

begin

-- proximo registrador a ser inserido.  
  process(clk)
  begin
    if clk'event and clk='1' then
      if R0="00000000" then
        n0 <= "0001";
        n1 <= "0000";
        n2 <= "0001";
      else
        if R1="00000000" then
          n0 <= "0010";
          n1 <= "0000";
          n2 <= "0010";
        else 
          if R2="00000000" then
            n0 <= "0011";
            n1 <= "0000";
            n2 <= "0011";
          else
            if R3="00000000" then
              n0 <= "0100";
              n1 <= "0000";
              n2 <= "0100";
            else
              if R4="00000000" then
                n0 <= "0101";
                n1 <= "0000";
                n2 <= "0101";
              else
                if R5="00000000" then
                  n0 <= "0110";
                  n1 <= "0000";
                  n2 <= "0110";
                else
                  if R6="00000000" then
                    n0 <= "0111";
                    n1 <= "0000";
                    n2 <= "0111";
                  else
                    if R7="00000000" then
                      n0 <= "1000";
                      n1 <= "0000";
                      n2 <= "1000";
                    else
                      if R8="00000000" then
                        n0 <= "1001";
                        n1 <= "0000";
                        n2 <= "1001";
                      else
                        if R9="00000000" then
                          n0 <= "0000";
                          n1 <= "0001";
                          n2 <= "1010";
                        else
                          if R10="00000000" then
                            n0 <= "0001";
                            n1 <= "0001";
                            n2 <= "1011";
                          else
                            if R11="00000000" then
                              n0 <= "0010";
                              n1 <= "0001";
                              n2 <= "1100";
                            else
                              if R12="00000000" then
                                n0 <= "0011";
                                n1 <= "0001";
                                n2 <= "1101";
                              else
                                if R13="00000000" then
                                  n0 <= "0100";
                                  n1 <= "0001";
                                  n2 <= "1110";
                                else
                                  if R14="00000000" then
                                    n0 <= "0101";
                                    n1 <= "0001";
                                    n2 <= "1111";
                                  else
                                    flag_full3 <= '1';
                                  end if;
                                end if;
                              end if;
                            end if;
                          end if;
                        end if;
                      end if;
                    end if;
                  end if;
                end if;
              end if;
            end if;
          end if;
        end if;  
      end if;
    end if;
    posicao0 <= n0;
    posicao1 <= n1;
    posicao2 <= n2;
    flag_full <= flag_full3;
  end process;
  
  process(clk)
  begin
    if clk'event and clk='1' then
--escreve em um registrador.
      if escrita='1' then
        if destino="0000" then
          R0 <= reg_data_in;
        elsif destino="0001" then
          R1 <= reg_data_in;
        elsif destino="0010" then
          R2 <= reg_data_in;
        elsif destino="0011" then
          R3 <= reg_data_in;
        elsif destino="0100" then
          R4 <= reg_data_in;
        elsif destino="0101" then
          R5 <= reg_data_in;
        elsif destino="0110" then
          R6 <= reg_data_in;
        elsif destino="0111" then
          R7 <= reg_data_in;
        elsif destino="1000" then
          R8 <= reg_data_in;
        elsif destino="1001" then
          R9 <= reg_data_in;
        elsif destino="1010" then
          R10 <= reg_data_in;
        elsif destino="1011" then
          R11 <= reg_data_in;
        elsif destino="1100" then
          R12 <= reg_data_in;
        elsif destino="1101" then
          R13 <= reg_data_in;
        elsif destino="1110" then
          R14 <= reg_data_in;
        end if;
      end if;  
      
--seleciona qual registrador irá enviar para Data_out.
      if reg_data_sel="0000" then
        reg_data_out <= R0;
      elsif reg_data_sel="0001" then
        reg_data_out <= R1;
      elsif reg_data_sel="0010" then
        reg_data_out <= R2;
      elsif reg_data_sel="0011" then
        reg_data_out <= R3;
      elsif reg_data_sel="0100" then
        reg_data_out <= R4;
      elsif reg_data_sel="0101" then
        reg_data_out <= R5;
      elsif reg_data_sel="0110" then
        reg_data_out <= R6;
      elsif reg_data_sel="0111" then
        reg_data_out <= R7;
      elsif reg_data_sel="1000" then
        reg_data_out <= R8;
      elsif reg_data_sel="1001" then
        reg_data_out <= R9;
      elsif reg_data_sel="1010" then
        reg_data_out <= R10;
      elsif reg_data_sel="1011" then
        reg_data_out <= R11;
      elsif reg_data_sel="1100" then
        reg_data_out <= R12;
      elsif reg_data_sel="1101" then
        reg_data_out <= R13;
      elsif reg_data_sel="1110" then
        reg_data_out <= R14;
      end if;
    end if;
  end process;
  
  

  with word_data_select select
  word_data_out <= "0000" when "000",
				   "0001" when "001",
				   "0010" when "010",
				   "0011" when "011",
				   "0100" when "100",
				   "0101" when "101",
				   "0110" when "110",
                   "1111" when others;
       
end arq_DBase;