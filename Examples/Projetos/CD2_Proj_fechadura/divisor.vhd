LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity divisor is
port(	
  reset, clk: in std_logic;
  cout: out std_logic
);
end divisor; 

architecture arq_divisor of divisor is

SIGNAL CLK_COUNT_400HZ: STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL CLK_COUNT_10HZ: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL CLK_400HZ: STD_LOGIC:= '0';

begin
  
  PROCESS
  BEGIN
    WAIT UNTIL clk'EVENT AND clk = '1';
	IF RESET = '0' THEN
	  CLK_COUNT_400HZ <= X"00000";
	  CLK_400HZ <= '0';
	ELSE
	  IF CLK_COUNT_400HZ < X"0F424" THEN 
	    CLK_COUNT_400HZ <= CLK_COUNT_400HZ + 1;
	  ELSE
		CLK_COUNT_400HZ <= X"00000";
		CLK_400HZ <= NOT CLK_400HZ;
	  END IF;
    END IF;
    cout <= CLK_400HZ;
  END PROCESS;	  
end arq_divisor;