LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity fechadura is
port(	
  clk, reset, reset_estados, btn1, btn2, btn0: in std_logic;
  ld0, ld1, ld2: out std_logic;
  
  DATA_BUS: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  LCD_RW: BUFFER STD_LOGIC;
  LCD_RS, LCD_E, LCD_ON, RESET_LED: OUT STD_LOGIC;
  
  flag_senha5, flag_admin5, flag_full5, flag_escrita5: out std_logic
);
end fechadura; 

architecture arq_fechadura of fechadura is

component divisor is
port(	
  reset, clk: in std_logic;
  cout: out std_logic
);
end component; 


component Controle is
port(	
  clk, btn0: in std_logic;
  ld0, ld1, ld2, escrita: out std_logic;
  word_data_select: out std_logic_vector(2 downto 0);
  flag_senha, flag_admin: in std_logic
);
end component;

component Operativa is
PORT(
  reset, clk, btn0, btn1, btn2: IN STD_LOGIC;
  DATA_BUS: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  LCD_RW: BUFFER STD_LOGIC;
  LCD_RS, LCD_E, LCD_ON, RESET_LED: OUT STD_LOGIC;
  
  word_data_in, posicao0, posicao1: in std_logic_vector(3 downto 0);
  reg_data_in: in std_logic_vector(7 downto 0);
  user_senha: buffer std_logic_vector(7 downto 0);
  user_login: out std_logic_vector(3 downto 0);
  flag_admin, flag_senha: out std_logic
  
);
end component;

component DBase is
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
end component;

signal clk_400hz: std_logic;
signal word_data_sel: std_logic_vector(2 downto 0);
signal word_data: std_logic_vector(3 downto 0);
signal login: std_logic_vector(3 downto 0);
signal senha: std_logic_vector(7 downto 0);
signal reg_data: std_logic_vector(7 downto 0);
signal flag_senha1, flag_admin2, flag_full3, flag_escrita4: std_logic;
signal new_user0, new_user1, new_user2: std_logic_vector(3 downto 0);

begin
  
  div: divisor
  port map(reset => reset, clk => clk, cout => clk_400hz);

  dados: DBase
  port map(clk => clk_400hz, word_data_select => word_data_sel, word_data_out => word_data, reg_data_sel => login,
           reg_data_in => senha, reg_data_out => reg_data, posicao2 => new_user2, posicao1 => new_user1, 
           posicao0 => new_user0, flag_full => flag_full3, escrita => flag_escrita4, destino => new_user2);

  ct1: Controle
  port map(clk => clk_400hz, btn0 => btn0, ld0 => ld0, ld1 => ld1, ld2 => ld2, escrita => flag_escrita4,
           word_data_select => word_data_sel, flag_senha => flag_senha1, flag_admin => flag_admin2);
  
  op1: Operativa
  port map(reset => reset, clk => clk_400hz, btn0 => btn0, btn1 => btn1, btn2 => btn2, DATA_BUS => DATA_BUS,
           LCD_RW => LCD_RW, LCD_RS => LCD_RS, LCD_E => LCD_E, LCD_ON => LCD_ON, 
           RESET_LED => RESET_LED, word_data_in => word_data, user_senha => senha, user_login => login,
           reg_data_in => reg_data, flag_senha => flag_senha1, flag_admin => flag_admin2,
           posicao1 => new_user1, posicao0 => new_user0);
  
  flag_senha5 <= flag_senha1;
  flag_admin5 <= flag_admin2;
  flag_full5 <= flag_full3;
  flag_escrita5 <= flag_escrita4;
end arq_fechadura;