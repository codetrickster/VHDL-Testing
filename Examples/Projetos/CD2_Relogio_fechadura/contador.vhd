LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity contador is 
port (
  clk, reset: in std_logic;
  q0, q1, q2, q3, q4, q5, q6, q7: out std_logic_vector(3 downto 0)
);
end contador;

architecture arq_contador of contador is

begin
  
  process(clk, reset)
  variable dec, segu0, segu1, minu0, minu1, hora0, hora1, aux: std_logic_vector(0 to 3) := "0000";
  variable aux_hora: std_logic_vector(0 to 4) := "00000";
  begin
    if (reset='0') then
      dec := "0000";
      segu0 := "0000"; -- segundos(0)
      segu1 := "0000"; -- segundos(1)
      minu0 := "0000"; -- minutos(0)
      minu1 := "0000"; -- minutos(1)
      hora0 := "0000"; -- horas(0)
      hora1 := "0000"; -- horas(1)
      aux_hora := "00000";
    elsif (clk'event and clk='1') then
      dec := dec + 1;
      if (dec="1010") then
        dec := "0000";
        segu0 := segu0 + 1;			
        if (segu0="1010") then
          segu0 := "0000";
          segu1 := segu1 + 1;
          if (segu1="0110") then
            segu1 := "0000";
            minu0 := minu0 + 1;
            if (minu0="1010") then
              minu0 := "0000";
              minu1 := minu1 + 1;
              if (minu1="0110") then
                minu1 := "0000";
                hora0 := hora0 + 1;
                aux_hora := aux_hora +1;
                if (hora0="1010") then 
                  hora0 := "0000";
                  hora1 := hora1 + 1;
                elsif (aux_hora="11000") then
                  hora0 := "0000";
                  hora1 := "0000";
                  aux_hora := "00000";
                end if;
              end if;
            end if;
          end if;
        end if;
      end if;
    end if;
  q0 <= segu0; -- segundos(0)
  q1 <= segu1; -- segundos(1)
  q2 <= minu0; -- minutos(0)
  q3 <= minu1; -- minutos(1)
  q4 <= hora0; -- horas(0)
  q5 <= hora1; -- horas(1)
  q6 <= "1111";
  q7 <= "1111";
  end process;
  
end arq_contador;