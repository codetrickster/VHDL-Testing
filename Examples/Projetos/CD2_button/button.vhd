LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity button is 
port (
  clr, b0, b1, b2: in std_logic;
  sel: in std_logic_vector(1 downto 0);
  q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13: out std_logic_vector(3 downto 0)
);
end button;

architecture arq_button of button is
begin
  
  process(sel, b0, b1, b2)
  variable segu0, segu1, minu0, minu1, hora0, hora1, dias0, dias1, mese0, mese1, 
           anos0, anos1, anos2, anos3: std_logic_vector(0 to 3);
  variable aux_hora, aux_dias, aux_meses: std_logic_vector(0 to 4);
  begin
  
  if sel="10" then    
  
    if (b0'event and b0='0') then
      segu0 := segu0 + 1;
      if (segu0="1010") then
        segu0 := "0000";
        segu1 := segu1 + 1;
        if (segu1="0110") then
          segu1 := "0000";
        end if;
      end if;
    end if;
    
    if (b1'event and b1='0') then
      minu0 := minu0 + 1;
      if (minu0="1010") then
        minu0 := "0000";
        minu1 := minu1 + 1;
        if (minu1="0110") then
          minu1 := "0000";
        end if;
      end if;
    end if;
    
    if (b2'event and b2='0') then
      hora0 := hora0 + 1;
      aux_hora := aux_hora + 1;
      if (hora0="1010") then
        hora0 := "0000";
        hora1 := hora1 + 1;
        if (aux_hora="11000") then
          hora0 := "0000";
          hora1 := "0000";
          aux_hora := "00000";
        end if;
      end if;
    end if;
  elsif sel="11" then
    if (b0'event and b0='0') then
      dias0 := dias0 + 1;
      aux_dias := aux_dias + 1;
      if (dias0="1010") then
        dias0 := "0000";
        dias1 := dias1 + 1;
        if (aux_dias="11111") then
          dias0 := "0001";
          dias1 := "0000";
          aux_dias := "00001";
        end if;
      end if;
    end if;
    if (b1'event and b1='0') then
      mese0 := mese0 + 1;
      aux_meses := aux_meses + 1;
      if (mese0="1010") then
        mese0 := "0000";
        mese1 := mese1 + 1;
        if (aux_meses="01101") then
          mese0 := "0001";
          mese1 := "0000";
          aux_meses := "00001";
        end if;
      end if;
    end if;
    if (b2'event and b2='0') then
      anos0 := anos0 + 1;
      if (anos0="1010") then
        anos0 := "0000";
        anos1 := anos1 + 1;
        if (anos1="1010") then
          anos1 := "0000";
          anos2 := anos2 + 1;
          if (anos2="1010") then
            anos2 := "0000";
            anos3 := anos3 + 1;
            if (anos3="1010") then
              anos3 := "0000";
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
    q6 <= dias0; -- dias(0)
    q7 <= dias1; -- dias(1)
    q8 <= mese0; -- mes(0)
    q9 <= mese1; -- mes(1)
    q10<= anos0; -- anos(0)
    q11<= anos1; -- anos(1)
    q12<= anos2; -- anos(2)
    q13<= anos3; -- anos(3)
    
  end process;
 
end arq_button;