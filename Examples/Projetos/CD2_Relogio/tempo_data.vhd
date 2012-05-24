Library IEEE;
use IEEE.std_logic_1164.all;

entity tempo_data is
port (
  clk, reset: in std_logic;
  sel: in std_logic_vector(1 downto 0);
  button: in std_logic_vector(2 downto 0);
  td0, td1, td2, td3, td4, td5, td6, td7: out std_logic_vector(3 downto 0)
);
end tempo_data; 

architecture arq_tempo_data of tempo_data is 
signal n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13: std_logic_vector(3 downto 0);

component contador is 
port (
  clk, reset: in std_logic;
  sel: in std_logic_vector(1 downto 0);
  button: in std_logic_vector(2 downto 0);
  q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13: out std_logic_vector(3 downto 0)
);
end component;

begin 

  Selecao: contador
  port map(clk => clk, reset => reset, sel => sel, button => button, 
           q0 => n0, q1 => n1, q2 => n2, q3 => n3, q4 => n4, q5 => n5, q6 => n6, q7 => n7, 
           q8 => n8, q9 => n9, q10 => n10, q11 => n11, q12 => n12, q13 => n13);
     
  
  with sel select
  td0 <= "1111" when "00",
         n10 when "01",
         "1111" when "10",
         n10 when "11";
  
  with sel select
  td1 <= "1111" when "00",
         n11 when "01",
         "1111" when "10",
         n11 when "11";
                 
  with sel select
  td2 <= n0 when "00",
         n12 when "01",
         n0 when "10",
         n12 when "11";
    
  with sel select
  td3 <= n1 when "00",
         n13 when "01",
         n1 when "10",
         n13 when "11";
    
  with sel select
  td4 <= n2 when "00",
         n8 when "01",
         n2 when "10",
         n8 when "11";
    
  with sel select
  td5 <= n3 when "00",
         n9 when "01",
         n3 when "10",
         n9 when "11";
    
  with sel select
  td6 <= n4 when "00",
         n6 when "01",
         n4 when "10",
         n6 when "11";
           
  with sel select
  td7 <= n5 when "00",
         n7 when "01",
         n5 when "10",
         n7 when "11";
         
end arq_tempo_data;